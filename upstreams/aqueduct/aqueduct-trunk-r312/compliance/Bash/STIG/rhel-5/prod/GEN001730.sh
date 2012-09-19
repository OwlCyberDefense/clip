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
# Group ID (Vulid): V-22356
# Group Title: GEN001730
# Rule ID: SV-37279r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001730
# Rule Title: All global initialization files must not have extended ACLs.
#
# Vulnerability Discussion: Global initialization files are used to 
# configure the user's shell environment upon login.  Malicious 
# modification of these files could compromise accounts upon logon.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check global initialization files for extended ACLs:

# ls -l /etc/bashrc /etc/csh.cshrc /etc/csh.login /etc/csh.logout 
# /etc/environment /etc/ksh.kshrc /etc/profile /etc/suid_profile 
# /etc/profile.d/* 2>null|grep "\+ "

# If the permissions include a '+', the file has an extended ACL. If the 
# file has an extended ACL and it has not been documented with the IAO, 
# this is a finding.
#
# Fix Text: 
#
# Remove the extended ACL from the file.

# ls -l etc/bashrc /etc/csh.cshrc /etc/csh.login /etc/csh.logout 
# /etc/environment /etc/ksh.kshrc /etc/profile /etc/suid_profile 
# /etc/profile.d/* 2>null|grep "\+ "|sed "s/^.* \///g"|xargs setfacl 
# --remove-all  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001730
	
# Start-Lockdown

for GINIT in `ls /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc /etc/environment /etc/.login /etc/security/environ /etc/profile.d/* /etc/suid_profile /etc/csh.logout /etc/ksh.kshrc 2>/dev/null`
do
  ACLOUT=`getfacl --skip-base $GINIT 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all $GINIT
  fi
done

