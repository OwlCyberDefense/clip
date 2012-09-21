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
# Group ID (Vulid): V-22457
# Group Title: GEN005504
# Rule ID: SV-37823r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005504
# Rule Title: The SSH daemon must only listen on management network 
# addresses unless authorized for uses other than management.
#
# Vulnerability Discussion: The SSH daemon should only listen on network 
# addresses designated for management traffic.  If the system has multiple 
# network interfaces and SSH listens on addresses not designated for 
# management traffic, the SSH service could be subject to unauthorized 
# access.  If SSH is used for purposes other than management, such as 
# providing an SFTP service, the list of approved listening addresses may 
# be documented.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Ask the SA to identify which interfaces on the system are designated 
# for management traffic.  If all interfaces on the system are authorized 
# for management traffic, this is not applicable.

# Check the SSH daemon configuration for listening network addresses.

# grep -i Listen /etc/ssh/sshd_config | grep -v '^#'

# If no configuration is returned, or if a returned 'Listen' configuration 
# contains addresses not designated for management traffic, this is a 
# finding.
#
# Fix Text: 
#
# Edit the SSH daemon configuration to specify listening network 
# addresses designated for management traffic.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005504
	
# Start-Lockdown

