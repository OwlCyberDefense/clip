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
# Group ID (Vulid): V-12022
# Group Title: GEN005540
# Rule ID: SV-37913r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005540
# Rule Title: The SSH daemon must be configured for IP filtering.
#
# Vulnerability Discussion: The SSH daemon must be configured for IP 
# filtering to provide a layered defense against connection attempts from 
# unauthorized addresses.
#
# Responsibility: System Administrator
# IAControls: ECSC-1, ECWM-1
#
# Check Content:
#
# Check the TCP wrappers configuration files to determine if sshd is 
# configured to use TCP wrappers.

# Procedure:
# grep sshd /etc/hosts.deny
# grep sshd /etc/hosts.allow

# If no entries are returned, the TCP wrappers are not configured for sshd, 
# this is a finding.


#
# Fix Text: 
#
# Add appropriate IP restrictions for SSH to the /etc/hosts.deny and/or 
# /etc/hosts.allow files.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005540
	
# Start-Lockdown

