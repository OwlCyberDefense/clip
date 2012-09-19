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
# Group ID (Vulid): V-12020
# Group Title: GEN005440
# Rule ID: SV-37810r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005440
# Rule Title: The system must not be used as a syslog server (loghost) 
# for systems external to the enclave.
#
# Vulnerability Discussion: Syslog messages are typically unencrypted, 
# may contain sensitive information, and are restricted to the enclave.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Ask the SA if the loghost server is collecting data for hosts outside 
# the local enclave. If it is, this is a finding.


#
# Fix Text: 
#
# Configure the hosts outside of the local enclave to not log to this 
# system.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005440
	
# Start-Lockdown

