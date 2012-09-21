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
# Group ID (Vulid): V-22419
# Group Title: GEN003612
# Rule ID: SV-37633r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003612
# Rule Title: The system must be configured to use TCP syncookies when 
# experiencing a TCP SYN flood.
#
# Vulnerability Discussion: A TCP SYN flood attack can cause Denial of 
# Service by filling a system's TCP connection table with connections in 
# the SYN_RCVD state.  Syncookies are a mechanism used to only track a 
# connection when a subsequent ACK is received, verifying the initiator is 
# attempting a valid connection and is not a flood source.  This technique 
# does not operate in a fully standards-compliant manner, but is only 
# activated when a flood condition is detected, and allows defense of the 
# system while continuing to service valid requests.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Verify the system configured to use TCP syncookies when experiencing a 
# TCP SYN flood.
# cat /proc/sys/net/ipv4/tcp_syncookies
# If the result is not "1", this is a finding.
#
# Fix Text: 
#
# Configure the system to use TCP syncookies when experiencing a TCP SYN 
# flood.
# Edit /etc/sysctl.conf and add a setting for "net.ipv4.tcp_syncookies=1". 
# sysctl -p     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003612
COOKIEMONSTER=$( cat /proc/sys/net/ipv4/tcp_syncookies )

#Start-Lockdown

if [ $COOKIEMONSTER -ne 1 ]
then
  echo " " >> /etc/sysctl.conf
  echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
  echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf
  sysctl -p > /dev/null
fi
