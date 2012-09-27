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
# Group ID (Vulid): V-23741
# Group Title: GEN003601
# Rule ID: SV-37594r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003601
# Rule Title: TCP backlog queue sizes must be set appropriately.
#
# Vulnerability Discussion: To provide some mitigation to TCP Denial of 
# Service attacks, the TCP backlog queue sizes must be set to at least 1280 
# or in accordance with product-specific guidelines.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# # cat /proc/sys/net/ipv4/tcp_max_syn_backlog
# If the result is not 1280 or greater, this is a finding.
#
# Fix Text: 
#
# Edit /etc/sysctl.conf and add a setting for 
# "net.ipv4.tcp_max_syn_backlog=1280".

# Procedure:
# sysctl -p     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003601
BACKLOG=$( cat /proc/sys/net/ipv4/tcp_max_syn_backlog )

#Start-Lockdown

if [ $BACKLOG -lt 1280 ]
then
  echo " " >> /etc/sysctl.conf
  echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
  echo "net.ipv4.tcp_max_syn_backlog=1280" >> /etc/sysctl.conf
  sysctl -p > /dev/null
fi
