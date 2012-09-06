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
# Group ID (Vulid): V-12023
# Group Title: GEN005600
# Rule ID: SV-37929r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005600
# Rule Title: IP forwarding for IPv4 must not be enabled, unless the 
# system is a router.
#
# Vulnerability Discussion: If the system is configured for IP forwarding 
# and is not a designated router, it could be used to bypass network 
# security by providing a path for communication not filtered by network 
# devices.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check if the system is configured for IPv4 forwarding. If the system is 
# a VM host and acts as a router solely for the benefits of its client 
# systems, then this rule is not applicable.

# Procedure:
# cat /proc/sys/net/ipv4/ip_forward

# If the value is set to "1", IPv4 forwarding is enabled this is a finding.


#
# Fix Text: 
#
# Edit "/etc/sysctl.conf" and set net.ipv4.ip_forward to "0". Restart the 
# system or run "sysctl -p" to make the change take effect.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005600
	
# Start-Lockdown

