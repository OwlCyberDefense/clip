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
from var_mapper import map_rule2check

def map_fixes():
	global BASEDIR

	FIXDIR = "scap-security-guide/RHEL6/input/fixes/"
	PROFILES = "scap-security-guide/RHEL6/input/profiles/"

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

		with open(COMMON_PROFILE, "r") as profile:
			for line in profile:
				inclusion = re.search("idref\=\"[^\"]*\"", line)
				
				if inclusion:
					inclusion = re.sub("(idref\=\"|\")", "", inclusion.group(0))
                                        
					fix_string = "<fix rule=\"%s\"> {\"script\"" %inclusion +\
						" : \"/usr/libexec/aqueduct/SSG/scripts/%s.sh\"" %inclusion +\
						" }</fix>\n"

					if (inclusion+".sh" in legit_scripts):
						var_set = map_rule2check(BASEDIR, inclusion)
						
						if var_set and var_set[1] != "":
							var_string = ".sh\",\n\"environment-variables\"" +\
							" : { \"%s\"" %var_set[1] +\
							" : \"<sub idref=\"%s\" />\" }" %var_set[1]

							fix_string = re.sub("\.sh\"", var_string, fix_string)							
						fixes.write(fix_string)
			
		fixes.write("</fix-group>")

def main():
	global BASEDIR
	
	if len(sys.argv) != 2:
                BASEDIR="/usr/local/"
        else:
                BASEDIR=sys.argv[1]

	map_fixes()

if __name__ == "__main__":
	main()
