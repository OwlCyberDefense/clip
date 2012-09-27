#!/bin/bash

##########################################################################
#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  
#  Vincent C. Passaro (vincent.passaro@gmail.com)
#  Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
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
##########################################################################

##################### Fusion Technology LLC #############################
# By Shannon Mitchell                                                   #
# Fusion Technology LLC                                                 #
# Shannon[.]Mitchell[@]fusiontechnology-llc[.]com                       #
# www.fusiontechnology-llc.com                                          #
##################### Fusion Technology LLC #############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Shannon Mitchell   | 15-jul-2012|
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-901
# Group Title: GEN001480
# Rule ID: SV-37154r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001480
# Rule Title: All user home directories must have mode 0750 or less 
# permissive.
#
# Vulnerability Discussion: Excessive permissions on home directories 
# allow unauthorized access to user files.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the home directory mode of each user in /etc/passwd.

# Procedure:
# cut -d: -f6 /etc/passwd|sort|uniq|xargs -n1 ls -ld

# If a user home directory's mode is more permissive than 0750, this is a 
# finding.

# Note: Application directories are allowed and may need 0755 permissions 
# (or greater) for correct operation.


#
# Fix Text: 
#
# Change the mode of user home directories to 0750 or less permissive.

# Procedure (example):
# chmod 0750 <home directory>

# Note: Application directories are allowed and may need 0755 permissions 
# (or greater) for correct operation.   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001480
	
# Start-Lockdown

# So GEN000340 and GEN000360 should weed out non-system accounts being in the
# system and reserved account ranges from 0 to 499(0 to 999 in fedora 16). So 
# to keep from maintaining a massive list of accounts lets just check the user
# directories of accounts >= 500 minus nfsnobody. 

for USERHDIR in `awk -F ':' '{if ($3 >= 500 && $3 != 65534)print $6}' /etc/passwd`
do
  if [ -d "$USERHDIR" ]
  then

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' $USERHDIR`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(027)
    if [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&2)) != "0" ] || [ $(($FILEOTHER&7)) != "0" ]
    then
      chmod g-w,o-rwx $USERHDIR
    fi
  fi

done
