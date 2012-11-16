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

def map_fixes():
	FIXDIR = "scap-security-guide/RHEL6/input/fixes/"
	PROFILES = "scap-security-guide/RHEL6/input/profiles/"

	if len(sys.argv) != 2:
		BASEDIR="/usr/local/"
	else:
		BASEDIR=sys.argv[1]
	
	MANUAL = "/usr/libexec/aqueduct/SSG/tools/manual.xml"
	FIXDIR = BASEDIR+FIXDIR
	PROFILES = BASEDIR+PROFILES
	COMMON_PROFILE = PROFILES+"common.xml"

	FIX_FILE = FIXDIR+"bash-ks.xml"
	exclusions=""
	
	legit_scripts = os.listdir("/usr/libexec/aqueduct/SSG/scripts/")

	if os.path.exists(MANUAL):
		with open(MANUAL, "r") as manual_file:
			exclusions = manual_file.read()

	with open(FIX_FILE, "w") as fixes:
		fixes.write('<fix-group id="bash" system="urn:xccdf:fix:script:bash" xmlns="http://checklists.nist.gov/xccdf/1.1">\n')
		fixes.write('<!-- TODO: Add environment variables to each script. -->\n')

		with open(COMMON_PROFILE, "r") as profile:
			for line in profile:
				inclusion = re.search("idref\=\"[^\"]*\"", line)
				
				if inclusion and (str.find(exclusions, line) < 0):
					inclusion = re.sub("(idref\=\"|\")", "", inclusion.group(0))
					
					if (inclusion+".sh" in legit_scripts):
						fixes.write("<fix rule=\"%s\"> {\"script\" : \"/usr/libexec/aqueduct/SSG/scripts/%s.sh\"} </fix>\n" %(inclusion, inclusion))
			
                fixes.write('<!-- Manual content. -->\n')
		
		exclusions = re.sub("(<.*Profile.*)|(<title.*)|(<description.*)", "", exclusions)
		manual_content = re.sub("(<select idref=)\"([^\"]*)\".*", "<fix rule=\"\\2\"> {\"script\" : \"/usr/libexec/aqueduct/SSG/scripts/\\2.sh\"} </fix>", exclusions)
	
		fixes.write(manual_content)
		fixes.write("</fix-group>")

map_fixes()
