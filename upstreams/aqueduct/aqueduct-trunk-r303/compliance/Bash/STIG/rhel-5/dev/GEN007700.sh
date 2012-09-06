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
# Group ID (Vulid): V-22541
# Group Title: GEN007700
# Rule ID: SV-37606r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN007700
# Rule Title: The IPv6 protocol handler must not be bound to the network 
# stack unless needed.
#
# Vulnerability Discussion: IPv6 is the next version of the Internet 
# protocol.  Binding this protocol to the network stack increases the 
# attack surface of the host.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# If the IPv6 protocol handler is bound to the network stack, and the 
# system does not need IPv6, this is a finding.

# grep NETWORKING_IPV6 /etc/sysconfig/network
# If the line is set to "yes", this is a finding.
#
# Fix Text: 
#
# Remove the capability to use IPv6 protocol handler.

# Procedure:
# Edit /etc/sysconfig/network and change
# NETWORKING_IPV6=yes
# to
# NETWORKING_IPV6=no

# Edit /etc/modprobe.conf and add these lines (if they are not in it):
# alias net-pf-10 off
# alias ipv6 off

# Stop the ipv6tables service by typing:
# service ip6tables stop

# Disable the ipv6tables service by typing:
# chkconfig ip6tables off

# Remove the ipv6 kernel module
# rmmod ipv6

# Reboot
  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN007700
	
# Start-Lockdown

