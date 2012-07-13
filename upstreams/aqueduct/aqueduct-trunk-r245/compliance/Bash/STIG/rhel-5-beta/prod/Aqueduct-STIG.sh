#Aqueduct - Compliance Remediation Content
#
#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor,
#Boston, MA  02110-1301, USA.

#!/bin/bash

LOUD=false
IGNORE=false

SCRIPTZ=$( ls -1  *.sh | grep -vi aqueduct )

while getopts "i:v" opt
do
	case $opt in
		v)
			LOUD=true
			;;
		i)
			IGNORE_FILE=$OPTARG
			if [ -r "$IGNORE_FILE" ]
			then
					IGNORE=true
			else
				echo "Cannot read $IGNORE_FILE"
				exit
			fi
			;;
		\?)
			echo "Usage: $0 -v -i ignore_file"
			exit
			;;
	esac
done 	

echo "$SCRIPTZ"

for file in $SCRIPTZ
  do
	if  ! $IGNORE   || ! grep -q $file $IGNORE_FILE  
	then
		if  $LOUD  
	    then
			# I have no idea why the extra stuff is there.
			# It makes things hard to move to a document.
	    	# echo -e "\e[00;32mEXECUTING $file\e[00m"
			echo "EXECUTING $file"
		   	./$file
		else
			# echo "Quietly executing $file"
		   	./$file > /dev/null 2>&1
		fi
	fi	

done  
