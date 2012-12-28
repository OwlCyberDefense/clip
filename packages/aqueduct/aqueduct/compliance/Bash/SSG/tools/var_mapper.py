#! /usr/bin/python
#
# Copyright (c) 2012 Tresys Technology LLC, Columbia, Maryland, USA
#
# This software was developed by Tresys Technology LLC
# with U.S. Government sponsorship.
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import sys, re, os
import xml.etree.ElementTree as ET
from lxml.etree import Element

def find_attrib_in_tag(file, parent_tag, child_tag, id_name):
	tree = ET.parse(file)
	root = tree.getroot()
	
	# Iterate through tree elements with tag 'parent_tag'
	#  If the 'parent_tag' has an id 'id_name', then
	#  find 'child_tag' and return its id and variable value.
	for child in root.getiterator(parent_tag):
		if child.attrib['id'] == id_name:
			found_tag = child.find(child_tag)
			
			if found_tag != None:
				try:
					return [ found_tag.attrib['id'], found_tag.attrib['value'] ]
				except KeyError:
					return [ found_tag.attrib['id'], "" ]

def map_rule2check(base_directory, rule_id):
	global BASEDIR

	if base_directory == "":
                BASEDIR = "/usr/local/"
        else:
                BASEDIR = base_directory

	ssg_input_dir = BASEDIR+"/scap-security-guide/RHEL6/input"
	
	for root,f,dir in os.walk(ssg_input_dir):
		for files in dir:
			xccdf_file = os.path.join(root, files)
			if xccdf_file.endswith(".xml") and\
			"/system/" in xccdf_file or\
			"/services/" in xccdf_file:
				tag_var = find_attrib_in_tag(xccdf_file, 'Rule', 'oval', rule_id)
				
				if tag_var:
					return tag_var

# Generate a dictionary of rule->[oval_id,var] mappings and return it.
def map_rule2vars(base_directory, rule_id):
	global BASEDIR
	
	if base_directory == "":
		BASEDIR = "/usr/local/"
	else:
		BASEDIR = base_directory

	return map_rule2check(rule_id)

def main():
	global BASEDIR

	if len(sys.argv) < 2:
		BASEDIR = "/usr/local/"
	else:
		BASEDIR = sys.argv[1]

if __name__ == "__main__":
	main()	
