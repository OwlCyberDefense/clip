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
# Group ID (Vulid): V-4246
# Group Title: GEN008620
# Rule ID: SV-37925r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN008620
# Rule Title: System BIOS or system controllers supporting password 
# protection must have administrator accounts/passwords configured, and no 
# others.
#
# Vulnerability Discussion: A system's BIOS or system controller handles 
# the initial startup of a system and its configuration must be protected 
# from unauthorized modification. When the BIOS or system controller 
# supports the creation of user accounts or passwords, such protections 
# must be used and accounts/passwords only assigned to system 
# administrators. Failure to protect BIOS or system controller settings 
# could result in Denial of Service or compromise of the system resulting 
# from unauthorized configuration changes.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# On systems with a BIOS or system controller, verify a supervisor or 
# administrator password is set. If a password is not set, this is a 
# finding.

# If the BIOS or system controller supports user-level access in addition 
# to supervisor/administrator access, determine if this access is enabled. 
# If so, this is a finding.
#
# Fix Text: 
#
# Access the system's BIOS or system controller. Set a 
# supervisor/administrator password if one has not been set. Disable a 
# user-level password if one has been set.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN008620
	
# Start-Lockdown

