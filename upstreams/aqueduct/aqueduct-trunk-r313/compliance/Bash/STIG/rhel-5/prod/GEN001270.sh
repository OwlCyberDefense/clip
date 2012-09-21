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
# Group ID (Vulid): V-22315
# Group Title: GEN001270
# Rule ID: SV-37233r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001270
# Rule Title: System log files must not have extended ACLs, except as 
# needed to support authorized software.
#
# Vulnerability Discussion: If the system log files are not protected, 
# unauthorized users could change the logged data, eliminating its forensic 
# value.  Authorized software may be given log file access through the use 
# of extended ACLs when needed and configured to provide the least 
# privileges required.
#
# Responsibility: System Administrator
# IAControls: ECLP-1, ECTP-1
#
# Check Content:
#
# Verify system log files have no extended ACLs.

# Procedure:
# ls -lL /var/log

# If the permissions include a '+', the file has an extended ACL. If an 
# extended ACL exists, verify with the SA if the ACL is required to support 
# authorized software and provides the minimum necessary permissions. If an 
# extended ACL exists providing access beyond the needs of authorized 
# software, this is a finding.


#
# Fix Text: 
#
# Remove the extended ACL from the file.

# Procedure:
# setfacl --remove-all [file with extended ACL]     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001270
	
# Start-Lockdown

#MAKE SURE YOU EXCLUDE WTMP!!!
LOGFILES=`find /var/log/ -type f`
for LOGFILETOFIX in $LOGFILES
do
  ACLOUT=`getfacl --skip-base $LOGFILETOFIX 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
    then
    setfacl --remove-all $LOGFILETOFIX
  fi
done
