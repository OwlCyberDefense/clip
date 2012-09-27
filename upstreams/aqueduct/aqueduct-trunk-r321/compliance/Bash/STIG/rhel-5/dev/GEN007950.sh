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
# Group ID (Vulid): V-23972
# Group Title: GEN007950
# Rule ID: SV-29788r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN007950
# Rule Title: The system must not respond to ICMPv6 echo requests sent to 
# a broadcast address.
#
# Vulnerability Discussion: Responding to broadcast ICMP echo requests 
# facilitates network mapping and provides a vector for amplification 
# attacks.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check for an iptables rule that drops inbound IPv6 ICMP ECHO_REQUESTs 
# sent to the all-hosts multicast address.

# Procedure:
# less /etc/sysconfig/ip6tables

# Check for a rule in, or referenced by, the INPUT chain such as:
# -A INPUT -p icmpv6 -d ff02::1 --icmpv6-type 128 -j DROP

# If such a rule does not exist, this is a finding.
#
# Fix Text: 
#
# Add an iptables rule that drops inbound IPv6 ICMP ECHO_REQUESTs sent to 
# the all-hosts multicast address.

# Edit /etc/sysconfig/ip6tables and add a rule in, or referenced by, the 
# INPUT chain such as:
# -A INPUT -p icmpv6 -d ff02::1 --icmpv6-type 128 -j DROP

# Reload the iptables rules.
# Procedure:
# service ip6tables restart  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN007950
	
# Start-Lockdown

