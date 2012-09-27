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
# Group ID (Vulid): V-905
# Group Title: GEN001880
# Rule ID: SV-37431r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001880
# Rule Title: All local initialization files must have mode 0740 or less 
# permissive.
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
# Check the modes of local initialization files.

# Procedure:
# ls -al /<usershomedirectory>/.bashrc
# ls -al /<usershomedirectory>/.bash_login
# ls -al /<usershomedirectory>/.bash_logout
# ls -al /<usershomedirectory>/.bash_profile
# ls -al /<usershomedirectory>/.cshrc
# ls -al /<usershomedirectory>/.kshrc
# ls -al /<usershomedirectory>/.login
# ls -al /<usershomedirectory>/.logout
# ls -al /<usershomedirectory>/.profile
# ls -al /<usershomedirectory>/.tcshrc
# ls -al /<usershomedirectory>/.env
# ls -al /<usershomedirectory>/.dtprofile (permissions should be 0755)
# ls -al /<usershomedirectory>/.dispatch
# ls -al /<usershomedirectory>/.emacs
# ls -al /<usershomedirectory>/.exrc
# find /<usershomedirectory>/.dt ! -fstype nfs \( -perm -0002 -o -perm 
# -0020 \) -exec ls -ld {} \; (permissions not to be more
# permissive than 0755)

# If local initialization files are more permissive than 0740 or the .dt 
# directory is more permissive than 0755 or the .dtprofile file is more 
# permissive than 0755, this is a finding.
#
# Fix Text: 
#
# Ensure user startup files have permissions of 0740 or more restrictive. 
# Examine each user's home directory and verify all file names beginning 
# with "." have access permissions of 0740 or more restrictive. If they do 
# not, use the chmod command to correct the vulnerability. 

# Procedure: 
# chmod 0740 .filename 

# Note: The period is part of the file name and is required.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001880
	
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

      # Pull the actual permissions
      FILEPERMS=`stat -L --format='%04a' "${USERHDIR}/${DOTFILE}"`

      # Break the actual file octal permissions up per entity
      FILESPECIAL=${FILEPERMS:0:1}
      FILEOWNER=${FILEPERMS:1:1}
      FILEGROUP=${FILEPERMS:2:1}
      FILEOTHER=${FILEPERMS:3:1}

      # Run check by 'and'ing the unwanted mask(037)
      if [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&3)) != "0" ] || [ $(($FILEOTHER&7)) != "0" ]
      then
        if [ "$DOTFILE" != ".dtprofile" ]
        then
          chmod g-wx,o-rwx "${USERHDIR}/${DOTFILE}"
        fi
      fi

      if [ "$DOTFILE" == ".dtprofile" ]
      then
        if [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&2)) != "0" ] || [ $(($FILEOTHER&2)) != "0" ]
        then
          chmod g-w,o-w "${USERHDIR}/${DOTFILE}"
        fi
      fi

    fi
  done
done
