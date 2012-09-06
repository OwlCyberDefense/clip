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
# Group ID (Vulid): V-24357
# Group Title: GEN002870
# Rule ID: SV-37948r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN002870
# Rule Title: The system must be configured to send audit records to a 
# remote audit server.
#
# Vulnerability Discussion: Audit records contain evidence that can be 
# used in the investigation of compromised systems. To prevent this 
# evidence from compromise, it must be sent to a separate system 
# continuously. Methods for sending audit records include, but are not 
# limited to, system audit tools used to send logs directly to another host 
# or through the system's syslog service to another host.

#
# Responsibility: System Administrator
# IAControls: ECTB-1
#
# Check Content:
#
# Verify the system is configured to forward all audit records to a 
# remote server. If the system is not configured to provide this function, 
# this is a finding.

# Procedure:
# Ensure the audit option for the kernel is enabled.

# grep "audit" /boot/grub/grub.conf

# If the kernel does not have the "audit=1" option specified, this is a 
# finding.

# Ensure the kernel auditing is active.

# grep "active" /etc/audisp/plugins.d/syslog.conf

# If the "active" setting is either missing or not set to "yes", this is a 
# finding.

# Ensure all audit records are forwarded to a remote server.

# grep "\*.\*" /etc/syslog.conf |grep "@" (for syslog)
# or:
# grep "\*.\*" /etc/rsyslog.conf | grep "@" (for rsyslog)

# If neither of these lines exist, it is a finding.
#
# Fix Text: 
#
# Configure the system to send audit records to a remote server. 

# Procedure:
# These instructions assume a known remote audit server is available to 
# this system. 
# Modify /etc/syslog.conf to contain a line sending all audit records to a 
# remote audit server. The server is specified by placing an "@" before the 
# DNS name or IP address in the line. 

# *.* @<remote audit server>

# Edit the "active" line in /etc/audisp/plugins.d/syslog.conf so it shows 
# "active = yes".

# Restart audit and syslog:
# service auditd restart
# service syslog restart     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002870
	
# Start-Lockdown

