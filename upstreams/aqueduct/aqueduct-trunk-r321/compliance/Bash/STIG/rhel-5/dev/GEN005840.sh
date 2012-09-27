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

###################### Fotis Networks LLC ###############################
# By Vincent C. Passaro                                                 #
# Fotis Networks LLC	                                                #
# Vincent[.]Passaro[@]fotisnetworks[.]com                               #
# www.fotisnetworks.com	                                                #
###################### Fotis Networks LLC ###############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Vincent C. Passaro | 1-Aug-2012 |
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-933
# Group Title: GEN005840
# Rule ID: SV-37857r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005840
# Rule Title: The Network File System (NFS) server must be configured to 
# restrict file system access to local hosts.
#
# Vulnerability Discussion: The NFS access option limits user access to 
# the specified level. This assists in protecting exported file systems.  
# If access is not restricted, unauthorized hosts may be able to access the 
# system's NFS exports.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the permissions on exported NFS file systems.

# Procedure:
# exportfs -v

# If the exported file systems do not contain the 'rw' or 'ro' options 
# specifying a list of hosts or networks, this is a finding.


#
# Fix Text: 
#
# Edit /etc/exports and add ro and/or rw options (as appropriate) 
# specifying a list of hosts or networks which are permitted access. 
# Re-export the file systems.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005840
	
# Start-Lockdown

