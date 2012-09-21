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
# Group ID (Vulid): V-22414
# Group Title: GEN003607
# Rule ID: SV-37622r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003607
# Rule Title: The system must not accept source-routed IPv4 packets.
#
# Vulnerability Discussion: Source-routed packets allow the source of the 
# packet to suggest routers forward the packet along a different path than 
# configured on the router, which can be used to bypass network security 
# measures.  This requirement applies only to the handling of source-routed 
# traffic destined to the system itself, not to traffic forwarded by the 
# system to another system, such as when IPv4 forwarding is enabled and the 
# system is functioning as a router.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Verify the system does not accept source-routed IPv4 packets.

# Procedure:
# grep [01] /proc/sys/net/ipv4/conf/*/accept_source_route|egrep 
# "default|all"

# If all of the resulting lines do not end with "0", this is a finding.
#
# Fix Text: 
#
# Configure the system to not accept source-routed IPv4 packets.
# Edit /etc/sysctl.conf and add a setting for 
# "net.ipv4.conf.all.accept_source_route=0" and 
# "net.ipv4.conf.default.accept_source_route=0". 

# Reload the sysctls.
# Procedure:
# sysctl -p     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003607
IPACKETS=$( cat /proc/sys/net/ipv4/conf/all/accept_source_route )
IPACKETSDEF=$( cat /proc/sys/net/ipv4/conf/default/accept_source_route )

#Start-Lockdown

if [ $IPACKETS -ne 0 ]
then
  echo " " >> /etc/sysctl.conf
  echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
  echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
  sysctl -p > /dev/null
fi

if [ $IPACKETSDEF -ne 0 ]
then
  echo " " >> /etc/sysctl.conf
  echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
  echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
  sysctl -p > /dev/null
fi

