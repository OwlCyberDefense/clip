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
# Group ID (Vulid): V-22351
# Group Title: GEN001550
# Rule ID: SV-37180r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001550
# Rule Title: All files and directories contained in user home 
# directories must be group-owned by a group of which the home directory's 
# owner is a member.
#
# Vulnerability Discussion: If a user's files are group-owned by a group 
# of which the user is not a member, unintended users may be able to access 
# them.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the contents of user home directories for files group-owned by a 
# group of which the home directory's owner is not a member.
# 1. List the user accounts.
# cut -d : -f 1 /etc/passwd
# 2. For each user account, get a list of GIDs for files in the user's home 
# directory.
# find ~username -printf %G\\n | sort | uniq
# 3. Obtain the list of GIDs where the user is a member.
# id -G username
# 4. Check the GID lists. If there are GIDs in the file list not present in 
# the user list, this is a finding.
#
# Fix Text: 
#
# Change the group of a file not group-owned by a group of which the home 
# directory's owner is a member.
# chgrp <group with user as member> <file with bad group ownership>
# Document all changes.   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001550
	
# Start-Lockdown

# So GEN000340 and GEN000360 should weed out non-system accounts being in the
# system and reserved account ranges from 0 to 499(0 to 999 in fedora 16). So 
# to keep from maintaining a massive list of accounts lets just check the user
# directories of accounts >= 500 minus nfsnobody. 

for USERNAME in `awk -F ':' '{if ($3 >= 500 && $3 != 65534)print $1}' /etc/passwd`
do
  # create group list from primary and secondary groups
  GRPFILTER=''
  for GRP in `id -G ${USERNAME}`
  do
    GRPFILTER="$GRPFILTER ! -group $GRP"
  done

  USERHDIR=`egrep "^${USERNAME}" /etc/passwd | awk -F ':' '{print $6}'`
  USERPGRP=`egrep "^${USERNAME}" /etc/passwd | awk -F ':' '{print $4}'`
  if [ "$USERHDIR" != "/" ]
  then
    find $USERHDIR ! -fstype nfs $GRPFILTER -exec chgrp ${USERPGRP} {} \;
  fi
done
