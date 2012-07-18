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
# Group ID (Vulid): V-22595
# Group Title: GEN000000-LNX00450
# Rule ID: SV-26998r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000000-LNX00450
# Rule Title: The access.conf file must not have an extended ACL.
#
# Vulnerability Discussion: If the access permissions are more permissive 
# than 0640, system security could be compromised.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the permissions of the file.
# ls -lL /etc/security/access.conf
# If the permissions of the file or directory contain a '+', an extended 
# ACL is present. If the file has an extended ACL and it has not been 
# documented with the IAO, this is a finding.
#
# Fix Text: 
#
# Remove the extended ACL from the file.
# setfacl --remove-all /etc/security/access.conf  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000000-LNX00450
	
# Start-Lockdown

if [ -a "/etc/security/access.conf" ]
then
  ACLOUT=`getfacl --skip-base /etc/security/access.conf 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all /etc/security/access.conf 
  fi
fi

