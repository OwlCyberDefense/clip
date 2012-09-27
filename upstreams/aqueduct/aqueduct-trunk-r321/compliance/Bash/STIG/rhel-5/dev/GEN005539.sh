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
# Group ID (Vulid): V-22488
# Group Title: GEN005539
# Rule ID: SV-37908r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005539
# Rule Title: The SSH daemon must not allow compression or must only 
# allow compression after successful authentication.
#
# Vulnerability Discussion: If compression is allowed in an SSH 
# connection prior to authentication, vulnerabilities in the compression 
# software could result in compromise of the system from an unauthenticated 
# connection, potentially with root privileges.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the SSH daemon configuration for the compression setting.
# grep -i Compression /etc/ssh/sshd_config | egrep "no|delayed"
# If the setting is missing or is commented out, this is a finding.
# If the setting is present but is not set to "no" or "delayed", this is a 
# finding.


#
# Fix Text: 
#
# Edit the SSH daemon configuration and add or edit the "Compression" 
# setting value to "no" or "delayed".     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005539
	
# Start-Lockdown

