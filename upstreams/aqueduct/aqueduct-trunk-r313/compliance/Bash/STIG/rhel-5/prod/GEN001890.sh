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
# Group ID (Vulid): V-22362
# Group Title: GEN001890
# Rule ID: SV-37271r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001890
# Rule Title: Local initialization files must not have extended ACLs.
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
# Check user home directories for local initialization files with 
# extended ACLs.
# cut -d : -f 6 /etc/passwd | xargs -n1 -IDIR ls -alL DIR/.bashrc 
# DIR/.bash_login DIR/.bash_logout DIR/.bash_profile DIR/.cshrc DIR/.kshrc 
# DIR/.login DIR/.logout DIR/.profile DIR/.env DIR/.dtprofile DIR/.dispatch 
# DIR/.emacs DIR/.exrc
# If the permissions include a '+', the file has an extended ACL. If the 
# file has an extended ACL and it has not been documented with the IAO, 
# this is a finding.
#
# Fix Text: 
#
# Remove the extended ACL from the file.
# setfacl --remove-all <local initialization file with extended ACL>    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001890
	
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
      ACLOUT=`getfacl --skip-base "${USERHDIR}/${DOTFILE}" 2>/dev/null`;
      if [ "$ACLOUT" != "" ]
      then
        setfacl --remove-all "${USERHDIR}/${DOTFILE}"
      fi
    fi
  done
done
