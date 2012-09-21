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
# Group ID (Vulid): V-22487
# Group Title: GEN005538
# Rule ID: SV-37905r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005538
# Rule Title: The SSH daemon must not allow rhosts RSA authentication.

#
# Vulnerability Discussion: If SSH permits rhosts RSA authentication, a 
# user may be able to log in based on the keys of the host originating the 
# request and not any user-specific authentication.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the SSH daemon configuration for the RhostsRSAAuthentication 
# setting.
# grep -i RhostsRSAAuthentication /etc/ssh/sshd_config | grep -v '^#' 
# If the setting is set to "yes", this is a finding.


#
# Fix Text: 
#
# Edit the SSH daemon configuration and add or edit the 
# "RhostsRSAAuthentication" setting value to "no".     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005538
	
# Start-Lockdown

