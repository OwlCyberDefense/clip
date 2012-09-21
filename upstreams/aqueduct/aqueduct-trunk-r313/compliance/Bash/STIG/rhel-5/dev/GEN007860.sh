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
# Group ID (Vulid): V-22550
# Group Title: GEN007860
# Rule ID: SV-37616r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN007860
# Rule Title: The system must ignore IPv6 ICMP redirect messages.
#
# Vulnerability Discussion: ICMP redirect messages are used by routers to 
# inform hosts that a more direct route exists for a particular 
# destination. These messages modify the host's route table and are 
# unauthenticated. An illicit ICMP redirect message could result in a 
# man-in-the-middle attack.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Verify the system is configured to ignore IPv6 ICMP redirect messages.
# cat /proc/sys/net/ipv6/conf/all/accept_redirects
# If the returned value is not "0", this is a finding.


#
# Fix Text: 
#
# Configure the system to ignore IPv6 ICMP redirect messages.
# Edit "/etc/sysctl.conf" and add a settings for 
# "net.ipv6.conf.default.accept_redirects=0" and 
# "net.ipv6.conf.all.accept_redirects=0". 
# Restart the system for the setting to take effect.    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN007860
	
# Start-Lockdown

