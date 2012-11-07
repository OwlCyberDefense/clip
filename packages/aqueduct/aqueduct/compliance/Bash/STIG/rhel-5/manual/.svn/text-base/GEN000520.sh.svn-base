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
# Group ID (Vulid): V-769
# Group Title: GEN000520
# Rule ID: SV-37232r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000520
# Rule Title: The root user must not own the logon session for an 
# application requiring a continuous display.
#
# Vulnerability Discussion: If an application is providing a continuous 
# display and is running with root privileges, unauthorized users could 
# interrupt the process and gain root access to the system.
#
# Responsibility: System Administrator
# IAControls: PESL-1
#
# Check Content:
#
# If there is an application running on the system continuously in use 
# (such as a network monitoring application), ask the SA what the name of 
# the application is.
# Verify documentation exists for the requirement and justification of the 
# application. If no documentation exists, this is a finding.
# Execute "ps -ef | more" to determine which user owns the process(es) 
# associated with the application. If the owner is root, this is a finding.
#
# Fix Text: 
#
# Configure the system so the owner of a session requires a continuous 
# screen display, such as a network management display, is not root. Ensure 
# the display is also located in a secure, controlled access area. Document 
# and justify this requirement and ensure the terminal and keyboard for the 
# display (or workstation) are secure from all but authorized personnel by 
# maintaining them in a secure area, in a locked cabinet where a swipe 
# card, or other positive forms of identification, must be used to gain 
# entry.   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000520
	
# Start-Lockdown

#Up to the Admin. 

