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
# Group ID (Vulid): V-22309
# Group Title: GEN000930
# Rule ID: SV-37358r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000930
# Rule Title: The root account's home directory must not have an extended 
# ACL.
#
# Vulnerability Discussion: File system extended ACLs provide access to 
# files beyond what is allowed by the unix permissions of the files.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the root account's home directory has no extended ACL.

# grep "^root" /etc/passwd | awk -F":" '{print $6}'

# ls -ld <root home directory>

# If the permissions include a '+' the directory has an extended ACL. If 
# the file has an extended ACL and it has not been documented with the IAO, 
# this is a finding.
#
# Fix Text: 
#
# Remove the extended ACL from the root account's home directory.
# setfacl --remove-all <root home directory>     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000930
	
# Start-Lockdown

ROOTHOMEDIR=`grep "^root" /etc/passwd | awk -F":" '{print $6}'`
if [ -a "$ROOTHOMEDIR" ]
then
  ACLOUT=`getfacl --skip-base $ROOTHOMEDIR 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all $ROOTHOMEDIR
  fi
fi
