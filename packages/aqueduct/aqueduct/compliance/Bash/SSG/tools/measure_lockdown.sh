#!/bin/sh
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

PACKS="/home/mpalmiotto/aqueduct-commit-access/trunk"
CONTENT="$PACKS/compliance/Bash/SSG"
FOLDER="$CONTENT/dev/*.sh"

#REF="/home/mpalmiotto/clip/packages/scap-security-guide/scap-security-guide/RHEL6/input/profiles/dcid_6-3.xml"
REF="common.xml"
MANUALREFS="manual.xml"

#FIXFILE="$PACKS/scap-security-guide/scap-security-guide/rhel6/src/input/fixes/bash_dcid_lockdown.xml"

i=0
ct=0
manual=$( grep -Po "idref\=\"([^\"])*\"" $MANUALREFS )
total=$( grep -Po "idref\=\"([^\"])*\"" $REF )

#echo '<fix-group id="bash" system="urn:xccdf:fix:script:bash" xmlns="http://checklists.nist.gov/xccdf/1.1">' > $FIXFILE

for entries in $FOLDER; do
	entries=${entries##/home/mpalmiotto/aqueduct-commit-access/trunk/compliance/Bash/SSG/dev/}
	entries=${entries%.sh}
	echo ${total} | grep -q ${entries}
	if [ $? -ne 0 ]; then
		echo $entries can be deleted
	fi
done;

for profile_entries in $total; do
        profile_entries=${profile_entries##"idref=\""}
        profile_entries=${profile_entries%\"}
	
	echo $manual | grep -Pq $profile_entries
	if [ $? -ne 0 ]; then
		ct=`expr $ct + 1`
		ls $FOLDER | grep -Pq $profile_entries
	  if [ $? -ne 0 ]; then
			printf "%55s|%30s|\n" $profile_entries "Lockdown Achieved: NO"
		else
			i=`expr $i + 1`
			#echo "<fix rule=\""$profile_entries"\">/var/lib/"$profile_entries"</fix>" >> $FIXFILE
			printf "%55s|%30s|\n" $profile_entries "Lockdown Achieved: YES"
		fi
	fi
done;

#echo "</fix-group>" >> $FIXFILE


echo -n "DCID Lockdown $(( ${i}*100/${ct} ))% complete."
echo
