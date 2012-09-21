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
# Group ID (Vulid): V-914
# Group Title: GEN001540
# Rule ID: SV-37175r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN001540
# Rule Title: All files and directories contained in interactive user 
# home directories must be owned by the home directory's owner.
#
# Vulnerability Discussion: If users do not own the files in their 
# directories, unauthorized users may be able to access them. Additionally, 
# if files are not owned by the user, this could be an indication of system 
# compromise.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# For each user in the /etc/passwd file, check for the presence of files 
# and directories within the user's home directory not owned by the home 
# directory owner.

# Procedure:
# find /<usershomedirectory> ! -fstype nfs ! -user <username> ! \( -name 
# .bashrc -o -name .bash_login -o -name .bash_logout -o -name .bash_profile 
# -o -name .cshrc -o -name .kshrc -o -name .login -o -name .logout -o -name 
# .profile -o -name .tcshrc -o -name .env -o -name .dtprofile -o -name 
# .dispatch -o -name .emacs -o -name .exrc \) -exec ls -ld {} \;

# If user home directories contain files or directories not owned by the 
# home directory owner, this is a finding.


#
# Fix Text: 
#
# Change the ownership of files and directories in user home directories 
# to the owner of the home directory. 

# Procedure:
# chown accountowner filename     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001540
	
# Start-Lockdown

# So GEN000340 and GEN000360 should weed out non-system accounts being in the
# system and reserved account ranges from 0 to 499(0 to 999 in fedora 16). So 
# to keep from maintaining a massive list of accounts lets just check the user
# directories of accounts >= 500 minus nfsnobody. 

for USERNAME in `awk -F ':' '{if ($3 >= 500 && $3 != 65534)print $1}' /etc/passwd`
do
  USERHDIR=`egrep "^${USERNAME}" /etc/passwd | awk -F ':' '{print $6}'`
  if [ "$USERHDIR" != "/" ]
  then
    find $USERHDIR ! -fstype nfs ! -user ${USERNAME} -exec chown ${USERNAME} {} \;
  fi
done
