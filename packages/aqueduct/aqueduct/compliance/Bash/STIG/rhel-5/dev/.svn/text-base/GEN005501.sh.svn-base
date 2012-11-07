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
# Group ID (Vulid): V-22456
# Group Title: GEN005501
# Rule ID: SV-37820r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005501
# Rule Title: The SSH client must be configured to only use the SSHv2 
# protocol.
#
# Vulnerability Discussion: SSHv1 is not a DoD-approved protocol and has 
# many well-known vulnerability exploits.  Exploits of the SSH client could 
# provide access to the system with the privileges of the user running the 
# client.
#
# Responsibility: System Administrator
# IAControls: DCPP-1
#
# Check Content:
#
# Check the SSH client configuration for allowed protocol versions.
# grep -i protocol /etc/ssh/ssh_config | grep -v '^#' 
# If the returned protocol configuration allows versions less than 2, this 
# is a finding.


#
# Fix Text: 
#
# Edit the /etc/ssh/ssh_config file and add or edit a "Protocol" 
# configuration line not allowing versions less than 2.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005501
	
# Start-Lockdown

