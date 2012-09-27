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
# Group ID (Vulid): V-22325
# Group Title: GEN001368
# Rule ID: SV-37321r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001368
# Rule Title: The /etc/hosts file must have mode 0644 or less permissive.
#
# Vulnerability Discussion: The /etc/hosts file (or equivalent) 
# configures local host name to IP address mappings that typically take 
# precedence over DNS resolution.  If this file is maliciously modified, it 
# could cause the failure or compromise of security functions requiring 
# name resolution, which may include time synchronization, centralized 
# authentication, and remote system logging.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the mode of the /etc/hosts file.
# ls -l /etc/hosts
# If the file mode is not 0644, this is a finding.


#
# Fix Text: 
#
# Change the mode of the /etc/hosts file to 0644.
# chmod 0644 /etc/hosts     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001368
	
# Start-Lockdown

if [ -a "/etc/hosts" ]
then
  # Pull the actual permissions
  FILEPERMS=`stat -L --format='%04a' /etc/hosts`

  # Break the actual file octal permissions up per entity
  FILESPECIAL=${FILEPERMS:0:1}
  FILEOWNER=${FILEPERMS:1:1}
  FILEGROUP=${FILEPERMS:2:1}
  FILEOTHER=${FILEPERMS:3:1}

  # Run check by 'and'ing the unwanted mask(7133)
  if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&3)) != "0" ] || [ $(($FILEOTHER&3)) != "0" ]
  then
    chmod u-xs,g-wxs,o-wxt /etc/hosts
  fi
fi



