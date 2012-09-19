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
# Group ID (Vulid): V-935
# Group Title: GEN005880
# Rule ID: SV-37859r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005880
# Rule Title: The Network File System (NFS) server must not allow remote 
# root access.
#
# Vulnerability Discussion: If the NFS server allows root access to local 
# file systems from remote hosts, this access could be used to compromise 
# the system.
#
# Responsibility: Information Assurance Officer
# IAControls: EBRP-1
#
# Check Content:
#
# List the exports.
# cat /etc/exports
# If any export contains "no_root_squash" or does not contain "root_squash" 
# or "all_squash", this is a finding.


#
# Fix Text: 
#
# Edit the "/etc/exports" file and add "root_squash" (or "all_squash") 
# and remove "no_root_squash".
  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005880
	
# Start-Lockdown

