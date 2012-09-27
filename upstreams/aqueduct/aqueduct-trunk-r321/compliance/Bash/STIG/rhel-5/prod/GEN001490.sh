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
# Group ID (Vulid): V-22350
# Group Title: GEN001490
# Rule ID: SV-37162r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN001490
# Rule Title: User home directories must not have extended ACLs.
#
# Vulnerability Discussion: Excessive permissions on home directories 
# allow unauthorized access to user files.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Verify user home directories have no extended ACLs.
# cut -d : -f 6 /etc/passwd | xargs -n1 ls -ld 
# If the permissions include a '+', the file has an extended ACL this is a 
# finding.


#
# Fix Text: 
#
# Remove the extended ACL from the file.
# setfacl --remove-all [user home directory with extended ACL]  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001490
	
# Start-Lockdown

ACLHOMEDIR=$(cut -d : -f 6 /etc/passwd | xargs -n1 ls -ld |grep '+' | awk '{print $9}')
for dir in $ACLHOMEDIR
do
  ACLOUT=`getfacl --skip-base $dir 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all $dir
  fi
done
