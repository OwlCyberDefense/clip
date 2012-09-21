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
# Group ID (Vulid): V-4255
# Group Title: GEN008680
# Rule ID: SV-4255r2_rule
# Severity: high
# Rule Version (STIG-ID): GEN008680
# Rule Title: If the system boots from removable media, it must be stored 
# in a safe or similarly secured container.
#
# Vulnerability Discussion: Storing the boot loader on removable media in 
# an insecure location could allow a malicious user to modify the systems 
# boot instructions or boot to an insecure operating system.
#
# Responsibility: System Administrator
# IAControls: PESS-1
#
# Check Content:
#
# Ask the SA if the system boots from removable media. If so, ask if the 
# boot media is stored in a secure container when not in use. If it is not, 
# this is a finding.
#
# Fix Text: 
#
# Store the system boot media in a secure container when not in use.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN008680
	
# Start-Lockdown

