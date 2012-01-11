#!/usr/bin/python
import lxml.html, pprint, re, json,sys
from lxml.html import clean

tree = lxml.html.parse("cnssi1253_requirements.xhtml")
cleaner = clean.Cleaner(remove_tags=['style', 'div', 'font','p', 'br'])
tree=cleaner.clean_html(tree)

cntlno=re.compile("CNTL NO")

j1={}

i=3
d1nm={}
d1={}
for t in ('C', 'I' ,'A'):
    for l in ('L', 'M' ,'H'):
        d1[t+l] = {}
        d1nm[i] = t+l
        i = i+1

i=3
d2nm={}
d2={}
for t in ('C', 'I' ,'A'):
    d2[t] = {}
    d2nm[i] = t
    i = i+1

for r in tree.xpath('.//tr'):
    tuple=[]
    text = re.sub("\s+", " ", r.text_content()).rstrip().lstrip()
    for i in r.xpath('.//td'):
        text = re.sub("\s+", " ", i.text_content()).rstrip().lstrip()
        text = re.sub(u"\u2026", "...", text)
        tuple.append(text)
    # parse J1
    if len(tuple) == 4:
        if cntlno.search(tuple[0]):
            continue
        cntl = re.sub(r"([0-9]+)\(([0-9]+)", r"\1 (\2", tuple[0])
        record = {'cntl': cntl,
                  'name': tuple[1],
                  'text': tuple[2],
                  'dval': tuple[3]}
        j1[cntl] = record

    # parse D1
    if len(tuple) == 12:
        if tuple[0] == "":
            continue
        id = re.sub(r"([0-9]+)\(([0-9]+)", r"\1 (\2", tuple[1])
        for col in range(3,12):
            if tuple[col] == "X":
                d1[d1nm[col]][id] = 'X'

    # parse D2
    if len(tuple) == 6:
        if tuple[0] == "":
            continue
        id = re.sub(r"([0-9]+)\(([0-9]+)", r"\1 (\2", tuple[1])
        for col in range(3,6):
            if tuple[col] == "X":
                d2[d2nm[col]][id] = 'X'

file('j1.json', 'w').write(json.dumps(j1, sort_keys=True, indent=4))
file('d1.json', 'w').write(json.dumps(d1, sort_keys=True, indent=4))
file('d2.json', 'w').write(json.dumps(d2, sort_keys=True, indent=4))
