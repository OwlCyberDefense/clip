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
# Group ID (Vulid): V-22361
# Group Title: GEN001870
# Rule ID: SV-37252r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001870
# Rule Title: Local initialization files must be group-owned by the 
# user's primary group or root.
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
# Check user home directories for local initialization files group-owned 
# by a group other than the user's primary group or root.

# Procedure:
# FILES=" .login .cshrc .logout .profile .bash_profile .bashrc 
# .bash_logout .env .dtprofile .dispatch .emacs .exrc";
# for PWLINE in `cut -d: -f4,6 /etc/passwd`; do HOMEDIR=$(echo 
# ${PWLINE}|cut -d: -f2);GROUP=$(echo ${PWLINE} | cut -d: -f1);for INIFILE 
# in $FILES;do stat -c %g/%G:%n ${HOMEDIR}/${INIFILE} 2>null|egrep -v 
# "${GROUP}";done;done

# If any file is not group-owned by root or the user's primary GID, this is 
# a finding.
#
# Fix Text: 
#
#  Change the group-owner of the local initialization file to the user's 
# primary group, or root.
# chgrp <user's primary GID> <user's local initialization file>

# Procedure:
# FILES=".bashrc .bash_login .bash_logout .bash_profile .cshrc .kshrc 
# .login .logout .profile .tcshrc .env .dtprofile .dispatch .emacs .exrc";
# for PWLINE in `cut -d: -f4,6 /etc/passwd`; do HOMEDIR=$(echo 
# ${PWLINE}|cut -d: -f2);GROUP=$(echo ${PWLINE} | cut -d: -f1);for INIFILE 
# in $FILES;do MATCH=$(stat -c %g/%G:%n ${HOMEDIR}/${INIFILE} 2>null|egrep 
# -c -v "${GROUP}");if [ $MATCH != 0 ] ; then chgrp ${GROUP} 
# ${HOMEDIR}/${INIFILE};fi;done;done  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001870
	
# Start-Lockdown

# We are just going to pull the non system accounts and root.  Some of the
# system accounts share home directories which could cause some issues.
for USERNAME in root `awk -F ':' '{if ($3 >= 500 && $3 != 65534)print $1}' /etc/passwd`
do
  USERHDIR=`egrep "^${USERNAME}" /etc/passwd | awk -F ':' '{print $6}'`
  USERPGRP=`egrep "^${USERNAME}" /etc/passwd | awk -F ':' '{print $4}'`
  for DOTFILE in .cshrc .login .logout .profile .bash_profile .bashrc .env .dtprofile .dispatch .emacs .exrc .ldaprc .vimrc .muttrc .kshrc .tcshrc 
  do
    if [ -e "${USERHDIR}/${DOTFILE}" ]
    then
      CURGOWN=`stat -c %G ${USERHDIR}/${DOTFILE}`;
      if [ "$CURGOWN" != "$USERPGRP" ]
      then
        chgrp $USERPGRP "${USERHDIR}/${DOTFILE}"
      fi
    fi
  done
done
