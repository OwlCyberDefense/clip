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
# Group ID (Vulid): V-1013
# Group Title: GEN008600
# Rule ID: SV-37986r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN008600
# Rule Title: The system must be configured to only boot from the system 
# boot device.
#
# Vulnerability Discussion: The ability to boot from removable media is 
# the same as being able to boot into single user, or maintenance, mode 
# without a password. This ability could allow a malicious user to boot the 
# system and perform changes with the potential to compromise or damage the 
# system. It could also allow the system to be used for malicious purposes 
# by a malicious anonymous user.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Determine if the system is configured to boot from devices other than 
# the system startup media. If so, this is a finding.


#
# Fix Text: 
#
# Configure the system to only boot from system startup media.

# Procedure:
# On systems with a BIOS or system controller use the BIOS interface at 
# startup to remove all but the proper boot device from the boot device 
# list.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN008600
	
# Start-Lockdown

