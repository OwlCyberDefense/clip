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
# Group ID (Vulid): V-22409
# Group Title: GEN003602
# Rule ID: SV-37601r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN003602
# Rule Title: The system must not process Internet Control Message 
# Protocol (ICMP)  timestamp requests.
#
# Vulnerability Discussion: The processing of (ICMP) timestamp requests 
# increases the attack surface of the system.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Verify the system does not respond to ICMP TIMESTAMP_REQUESTs

# Procedure:
# grep "timestamp" /etc/sysconfig/iptables

# This should return entries for "timestamp-reply" and "timestamp_request". 
# Both should end with "-j DROP'. If either does not exist or does not 
# "DROP" the message, this is a finding.
#
# Fix Text: 
#
# Configure the system to not respond to ICMP TIMESTAMP_REQUESTs. This is 
# done by rejecting ICMP type 13 and 14 messages at the firewall.

# Procedure:
# Edit /etc/sysconfig/iptables to add:

# -A RH-Firewall-1-INPUT -p ICMP --icmp-type timestamp-request -j DROP
# -A RH-Firewall-1-INPUT -p ICMP --icmp-type timestamp-reply -j DROP

# Restart the firewall:
# service iptables restart  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003602
	
# Start-Lockdown

