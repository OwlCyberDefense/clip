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
# Group ID (Vulid): V-22461
# Group Title: GEN005510
# Rule ID: SV-37828r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005510
# Rule Title: The SSH client must be configured to only use FIPS 140-2 
# approved ciphers.
#
# Vulnerability Discussion: DoD information systems are required to use 
# FIPS 140-2 approved ciphers.  SSHv2 ciphers meeting this requirement are 
# 3DES and AES.
#
# Responsibility: System Administrator
# IAControls: DCNR-1
#
# Check Content:
#
# Check the SSH client configuration for allowed ciphers.
# grep -i ciphers /etc/ssh/ssh_config | grep -v '^#' 
# If no lines are returned, or the returned ciphers list contains any 
# cipher not starting with "3des" or "aes", this is a finding.


#
# Fix Text: 
#
# Edit the SSH client configuration and remove any ciphers not starting 
# with  with "3des" or "aes" and remove any ciphers ending with "cbc". If 
# necessary, add a "Ciphers" line.    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005510
	
# Start-Lockdown

