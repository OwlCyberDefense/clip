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
# Group ID (Vulid): V-22548
# Group Title: GEN007840
# Rule ID: SV-37615r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN007840
# Rule Title: The DHCP client must be disabled if not needed.
#
# Vulnerability Discussion: DHCP allows for the unauthenticated 
# configuration of network parameters on the system by exchanging 
# information with a DHCP server.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Verify no interface is configured to use DHCP.
# grep -i bootproto=dhcp /etc/sysconfig/network-scripts/ifcfg-*
# If any configuration is found, this is a finding.


#
# Fix Text: 
#
# Edit the "/etc/sysconfig/network-scripts/ifcfg-*" file(s) and change 
# the "bootproto" setting to "static".  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN007840
	
# Start-Lockdown

