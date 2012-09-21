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
# Group ID (Vulid): V-1025
# Group Title: GEN000000-LNX00400
# Rule ID: SV-37224r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000000-LNX00400
# Rule Title: The /etc/access.conf file must be owned by root.
#
# Vulnerability Discussion: The /etc/access.conf file contains entries 
# restricting access from the system console by authorized System 
# Administrators.  If the file is owned by a user other than root, it could 
# compromise the system.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check access configuration ownership:

# ls -lL /etc/security/access.conf

# If this file exists and is not owned by root, this is a finding.
#
# Fix Text: 
#
# Follow the correct configuration parameters for access configuration 
# file. Use the chown command to configure it properly. 
# (for example:
# chown root /etc/security/access.conf  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000000-LNX00400
	
# Start-Lockdown
if [ -a "/etc/security/access.conf" ]
then
  CUROWN=`stat -c %U /etc/security/access.conf`;
  if [ "$CUROWN" != "root" ]
    then
      chown root /etc/security/access.conf
  fi
fi

