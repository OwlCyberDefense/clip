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
# Group ID (Vulid): V-904
# Group Title: GEN001860
# Rule ID: SV-37430r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001860
# Rule Title: All local initialization files must be owned by the home 
# directorys user or root.
#
# Vulnerability Discussion: Local initialization files are used to 
# configure the user's shell environment upon login.  Malicious 
# modification of these files could compromise accounts upon logon.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the ownership of local initialization files.

# Procedure:
# ls -al /<usershomedirectory>/.login
# ls -al /<usershomedirectory>/.cshrc
# ls -al /<usershomedirectory>/.logout
# ls -al /<usershomedirectory>/.profile
# ls -al /<usershomedirectory>/.bash_profile
# ls -al /<usershomedirectory>/.bashrc
# ls -al /<usershomedirectory>/.bash_logout
# ls -al /<usershomedirectory>/.env
# ls -al /<usershomedirectory>/.dtprofile
# ls -al /<usershomedirectory>/.dispatch
# ls -al /<usershomedirectory>/.emacs
# ls -al /<usershomedirectory>/.exrc
# find /<usershomedirectory>/.dt ! -fstype nfs ! -user <username> -exec 
# ls -ld {} \;

# If local initialization files are not owned by the home directory's user, 
# this is a finding.
#
# Fix Text: 
#
# Change the ownership of the startup and login files in the user's 
# directory to the user or root, as appropriate. Examine each user's home 
# directory and verify all filenames beginning with "." are owned by the 
# owner of the directory or root. If they are not, use the chown command to 
# change the owner to the user and research the reasons why the owners were 
# not assigned as required. 

# Procedure:
# chown username .filename
# Document all changes.    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001860
	
# Start-Lockdown

# We are just going to pull the non system accounts and root.  Some of the
# system accounts share home directories which could cause some issues.
for USERNAME in root `awk -F ':' '{if ($3 >= 500 && $3 != 65534)print $1}' /etc/passwd`
do
  USERHDIR=`egrep "^${USERNAME}" /etc/passwd | awk -F ':' '{print $6}'`
  for DOTFILE in .cshrc .login .logout .profile .bash_profile .bashrc .env .dtprofile .dispatch .emacs .exrc .ldaprc .vimrc .muttrc .kshrc .tcshrc
  do
    if [ -e "${USERHDIR}/${DOTFILE}" ]
    then
      CUROWN=`stat -c %U "${USERHDIR}/${DOTFILE}"`;
      if [ "$CUROWN" != "$USERNAME" ]
      then
        chown $USERNAME "${USERHDIR}/${DOTFILE}"
      fi
    fi
  done
done
