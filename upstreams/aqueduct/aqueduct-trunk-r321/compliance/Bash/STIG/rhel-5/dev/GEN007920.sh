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
# Group ID (Vulid): V-22553
# Group Title: GEN007920
# Rule ID: SV-37618r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN007920
# Rule Title: The system must not forward IPv6 source-routed packets.
#
# Vulnerability Discussion: Source-routed packets allow the source of the 
# packet to suggest that routers forward the packet along a different path 
# than configured on the router, which can be used to bypass network 
# security measures. This requirement applies only to the forwarding of 
# source-routed traffic, such as when IPv6 forwarding is enabled and the 
# system is functioning as a router. 
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Determine if the system is configured to forward IPv6 source-routed 
# packets.

# Procedure:
# egrep "net.ipv6.conf.*forwarding" /etc/sysctl.conf
# If there are no entries found or the value of the entries is not = "0", 
# this is a finding.


#
# Fix Text: 
#
# Configure the system to not forward IPv6 source-routed packets.

# Procedure:
# Edit the /etc/sysctl.conf file to include:
# net.ipv6.conf.all.forwarding = 0
# net.ipv6.conf.default.forwarding = 0

# Reload the kernel parameters:
# sysctl -p

  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN007920
	
# Start-Lockdown

