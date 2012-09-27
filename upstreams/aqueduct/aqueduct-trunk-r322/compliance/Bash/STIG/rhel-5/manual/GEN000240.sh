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
# Group ID (Vulid): V-4301
# Group Title: GEN000240
# Rule ID: SV-37402r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000240
# Rule Title: The system clock must be synchronized to an authoritative 
# DoD time source.
#
# Vulnerability Discussion: To assure the accuracy of the system clock, 
# it must be synchronized with an authoritative time source within DoD.  
# Many system functions, including time-based login and activity 
# restrictions, automated reports, system logs, and audit records depend on 
# an accurate system clock.  If there is no confidence in the correctness 
# of the system clock, time-based functions may not operate as intended and 
# records may be of diminished value.

# Authoritative time sources include authorized time servers within the 
# enclave that synchronize with upstream authoritative sources.  Specific 
# requirements for the upstream synchronization of network time protocol 
# (NTP) servers are covered in the Network Other Devices STIG.

# For systems located on isolated or closed networks, it is not necessary 
# to synchronize with a global authoritative time source.  If a global 
# authoritative time source is not available to systems on an isolated 
# network, a local authoritative time source must be established on this 
# network and used by the systems connected to this network.  This is 
# necessary to provide the ability to correlate events and allow for the 
# correct operation of time-dependent protocols between systems on the 
# isolated network.

# If the system is completely isolated (i.e., it has no connections to 
# networks or other systems), time synchronization is not required as no 
# correlation of events between systems will be necessary. If the system is 
# completely isolated, this requirement is not applicable.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check if NTP running:
# ps -ef | egrep "xntpd|ntpd"

# Check if "ntpd -qg" scheduled to run:
# grep "ntpd -qg" /var/spool/cron/*
# grep "ntpd -qg" /etc/cron.d/*
# grep "ntpd -qg" /etc/cron.daily/*
# grep "ntpd -qg" /etc/cron.hourly/*
# grep "ntpd -qg" /etc/cron.monthly/*
# grep "ntpd -qg" /etc/cron.weekly/*

# If NTP is running or "ntpd -qg" is found:

# more /etc/ntp.conf

# Confirm the timeservers and peers or multicast client (as applicable) are 
# local or authoritative U.S. DoD sources appropriate for the level of 
# classification which the network operates.

# If a non-local/non-authoritative time-server is used, this is a finding.
#
# Fix Text: 
#
# Use an authoritative local time server or a time server operated by the 
# U.S. government.  Ensure all systems in the facility feed from one or 
# more local time servers which feed from the authoritative U.S. government 
# time server.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000240
	
# Start-Lockdown

#Can't do much here since we don't know the NTP server IP's to be used for the GOV

