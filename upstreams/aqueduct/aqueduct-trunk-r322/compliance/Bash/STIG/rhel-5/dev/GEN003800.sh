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
# Group ID (Vulid): V-1011
# Group Title: GEN003800
# Rule ID: SV-37439r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN003800
# Rule Title: Inetd or xinetd logging/tracing must be enabled.
#
# Vulnerability Discussion: Inetd or xinetd logging and tracing allows 
# the system administrators to observe the IP addresses connecting to their 
# machines and what network services are being sought.  This provides 
# valuable information when trying to find the source of malicious users 
# and potential malicious users.
#
# Responsibility: System Administrator
# IAControls: ECAR-1, ECAR-2, ECAR-3, ECSC-1
#
# Check Content:
#
# The /etc/xinetd.conf file and each file in the /etc/xinetd.d directory 
# file should be examined for the following: 

# Procedure:
# log_type = SYSLOG authpriv
# log_on_success = HOST PID USERID EXIT
# log_on_failure = HOST USERID

# If xinetd is running and logging is not enabled, this is a finding.


#
# Fix Text: 
#
# Edit each file in the /etc/xinetd.d directory and the /etc/xinetd.conf 
# file to contain:
# log_type = SYSLOG authpriv
# log_on_success = HOST PID USERID EXIT
# log_on_failure = HOST USERID

# The /etc/xinetd.conf file contains default values that will hold true for 
# all services unless individually modified in the service's xinetd.d file.

# To make the new settings effective, restart the xinetd service:
# service xinetd restart     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003800
	
# Start-Lockdown

