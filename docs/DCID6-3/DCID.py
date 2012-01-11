#!/usr/bin/python
import lxml.html, pprint, re, json
from lxml.html import clean

# get YAML from EPEL
try:
    import yaml
except:
    pass

tree = lxml.html.parse("x")
#tree = lxml.html.parse("DCID_6-3_PL4and5HighHigh_Requirements.xhtml")
cleaner = clean.Cleaner(remove_tags=['b','span'])
tree=cleaner.clean_html(tree)

for li in tree.xpath("//li[starts-with(text(),'[')]"):
    text = re.sub("\s+", " ", li.text).rstrip().lstrip()
    text = re.sub(u"\u2026", "...", text)
    text = re.sub(u"\u2019", "'", text)

    print "\n--\n", lxml.html.tostring(li)


