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
# Group ID (Vulid): V-903
# Group Title: GEN001520
# Rule ID: SV-37168r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001520
# Rule Title: All interactive user home directories must be group-owned 
# by the home directory owner's primary group.
#
# Vulnerability Discussion: If the Group Identifier (GID) of the home 
# directory is not the same as the GID of the user, this would allow 
# unauthorized access to files.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the group ownership for each user in the /etc/passwd file.

# Procedure:
# cut -d : -f 6 /etc/passwd | xargs -n1 ls -ld 

# If any user home directory is not group-owned by the assigned user's 
# primary group, this is a finding. Home directories for application 
# accounts requiring different group ownership must be documented using 
# site-defined procedures.


#
# Fix Text: 
#
# Change the group-owner for user home directories to the primary group 
# of the assigned user.

# Procedure:
# Find the primary group of the user (GID) which is the fourth field of the 
# user entry in /etc/passwd.

# chgrp <GID> <user home directory>

# Document all changes.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001520
	
# Start-Lockdown

# So GEN000340 and GEN000360 should weed out non-system accounts being in the
# system and reserved account ranges from 0 to 499(0 to 999 in fedora 16). So 
# to keep from maintaining a massive list of accounts lets just check the user
# directories of accounts >= 500 minus nfsnobody. 

for USERNAME in `awk -F ':' '{if ($3 >= 500 && $3 != 65534)print $1}' /etc/passwd`
do
  USERHDIR=`egrep "^${USERNAME}" /etc/passwd | awk -F ':' '{print $6}'`
  USERPGRP=`egrep "^${USERNAME}" /etc/passwd | awk -F ':' '{print $4}'`
  if [ -d "$USERHDIR" ]
  then
    CURGOWN=`stat -c %G $USERHDIR`;
    if [ "$CURGOWN" != "$USERNAME" ]
    then
      chgrp $USERPGRP $USERHDIR
    fi
  fi
done
