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
	FIXES = "/usr/local/scap-security-guide/rhel6/src/input/fixes"
 	PROFILES = "/usr/local/sbin/cap-security-guide/rhel6/src/input/profiles"
	DCID_PROFILE=PROFILES+"/dcid_6-3.xml"
	MANUAL_DCID=PROFILES+"/dcid_6-3_manual.xml"

	FIX_FILE=FIXES+"/dcid_lockdown_bash-ks.xml"
	exclusions=""
	if os.path.exists(MANUAL_DCID):
		with open(MANUAL_DCID, "r") as manual_file:
			exclusions = manual_file.read()

	with open(FIX_FILE, "w") as fixes:
		fixes.write('<fix-group id="bash" system="urn:xccdf:fix:script:bash" xmlns="http://checklists.nist.gov/xccdf/1.1">')

		with open(DCID_PROFILE, "r") as profile:
			for line in profile:
				inclusion = re.search("idref\=\"[^\"]*\"", line)

				if inclusion and line not in exclusions:
					inclusion = re.sub("(idref\=\"|\")", "", inclusion.group(0))
					fixes.write("<fix rule=\"%s\">/usr/libexec/aqueduct/SSG/rhel-6-beta/scripts/%s</fix>\n" %(inclusion, inclusion))


		fixes.write("</fix-group>")

map_fixes()
