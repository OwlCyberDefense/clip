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
# Group ID (Vulid): V-12021
# Group Title: GEN005480
# Rule ID: SV-37813r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005480
# Rule Title: The syslog daemon must not accept remote messages unless it 
# is a syslog server documented using site-defined procedures.
#
# Vulnerability Discussion: Unintentionally running a syslog server 
# accepting remote messages puts the system at increased risk.  Malicious 
# syslog messages sent to the server could exploit vulnerabilities in the 
# server software itself, could introduce misleading information in to the 
# system's logs, or could fill the system's storage leading to a Denial of 
# Service.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Ask the SA if the system is an authorized syslog server.  If the system 
# is an authorized syslog server, this is not applicable.

# Determine if the system's syslog service is configured to accept remote 
# messages.

# ps -ef | grep syslogd

# If the '-r' option is present, the system is configured to accept remote 
# syslog messages, and this is a finding.
#
# Fix Text: 
#
# Edit /etc/sysconfig/syslog to removing the '-r' in SYSLOGD_OPTIONS. 
# Restart the syslogd service.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005480
	
# Start-Lockdown

