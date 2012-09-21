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
# Group ID (Vulid): V-22491
# Group Title: GEN005610
# Rule ID: SV-37930r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005610
# Rule Title: The system must not have IP forwarding for IPv6 enabled, 
# unless the system is an IPv6 router.
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
# Check if the system is configured for IPv6 forwarding.

# grep [01] /proc/sys/net/ipv6/conf/*/forwarding|egrep "default|all"

# If all of the resulting lines do not end with 0, this is a finding.


#
# Fix Text: 
#
# Disable IPv6 forwarding.

# Edit /etc/sysctl.conf and add a setting for 
# "net.ipv6.conf.all.forwarding=0" and "net.ipv6.conf.default.forwarding=0".

# Reload the sysctls.
# Procedure:
# sysctl -p    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005610
	
# Start-Lockdown

