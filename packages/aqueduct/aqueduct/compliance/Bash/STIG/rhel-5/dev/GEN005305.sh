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
# Group ID (Vulid): V-22447
# Group Title: GEN005305
# Rule ID: SV-37692r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005305
# Rule Title: The SNMP service must use only SNMPv3 or its successors.
#
# Vulnerability Discussion: SNMP Versions 1 and 2 are not considered 
# secure. Without the strong authentication and privacy provided by the 
# SNMP Version 3 User-based Security Model (USM), an attacker or other 
# unauthorized users may gain access to detailed system management 
# information and use the information to launch attacks against the system.
#
# Responsibility: System Administrator
# IAControls: DCPP-1
#
# Check Content:
#
# Check the SNMP daemon is not configured to use the v1 or v2c security 
# models.

# Procedure:
# Examine the default install location /etc/snmpd.conf
# or:
# find / -name snmpd.conf 

# grep -E '(v1|v2c|community|com2sec)' <snmp.conf file> | grep -v '^#'
# If any configuration is found, this is a finding.
#
# Fix Text: 
#
# Edit /etc/snmpd.conf and remove references to the "v1", "v2c", 
# "community", or "com2sec". 
# Restart the SNMP service.
# service snmpd restart     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005305
	
# Start-Lockdown

