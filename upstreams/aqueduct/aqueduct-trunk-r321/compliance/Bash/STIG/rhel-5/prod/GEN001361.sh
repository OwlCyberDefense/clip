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
# Group ID (Vulid): V-22318
# Group Title: GEN001361
# Rule ID: SV-37277r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001361
# Rule Title: NIS/NIS+/yp command files must not have extended ACLs.
#
# Vulnerability Discussion: NIS/NIS+/yp files are part of the system's 
# identification and authentication processes and are critical to system 
# security.  ACLs on these files could result in unauthorized modification, 
# which could compromise these processes and the system.  
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Verify NIS/NIS+/yp files have no extended ACLs.
# ls -lL /var/yp/*
# If the permissions include a '+', the file has an extended ACL. If the 
# file has an extended ACL and it has not been documented with the IAO, 
# this is a finding.


#
# Fix Text: 
#
# Remove the extended ACL from the file.
# setfacl --remove-all /var/yp/*  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001361
	
# Start-Lockdown

for CURFILE in `find /var/yp -type f`
do
  ACLOUT=`getfacl --skip-base $CURFILE 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all $CURFILE
  fi
done

