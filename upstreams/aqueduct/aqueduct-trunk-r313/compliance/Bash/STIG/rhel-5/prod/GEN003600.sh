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
# Group ID (Vulid): V-12002
# Group Title: GEN003600
# Rule ID: SV-29795r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003600
# Rule Title: The system must not forward IPv4 source-routed packets.
#
# Vulnerability Discussion: Source-routed packets allow the source of the 
# packet to suggest routers forward the packet along a different path than 
# configured on the router, which can be used to bypass network security 
# measures.  This requirement applies only to the forwarding of 
# source-routed traffic, such as when IPv4 forwarding is enabled and the 
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

# If all of the returned lines do not end with 0, this is a finding.

# Note: The same setting is used by Linux for both the local acceptance and 
# forwarding of source-routed IPv4 packets.
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
PDI=GEN003600
SOURCEROUTE=$( cat /proc/sys/net/ipv4/conf/all/accept_source_route )
#Start-Lockdown

if [ $SOURCEROUTE -ne 0 ]
  then
    echo " "  >> /etc/sysctl.conf
    echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
    echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
    sysctl -p > /dev/null
fi
