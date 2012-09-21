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
# Group ID (Vulid): V-22473
# Group Title: GEN005524
# Rule ID: SV-37866r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN005524
# Rule Title: The SSH daemon must not permit GSSAPI authentication unless 
# needed.
#
# Vulnerability Discussion: GSSAPI authentication is used to provide 
# additional authentication mechanisms to applications. Allowing GSSAPI 
# authentication through SSH exposes the system’s GSSAPI to remote hosts, 
# increasing the attack surface of the system.  GSSAPI authentication must 
# be disabled unless needed.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Ask the SA if GSSAPI authentication is used for SSH authentication to 
# the system. If so, this is not applicable.

# Check the SSH daemon configuration for the GSSAPIAuthentication setting.
# grep -i GSSAPIAuthentication /etc/ssh/sshd_config | grep -v '^#' 
# If no lines are returned, or the setting is set to "yes", this is a 
# finding.


#
# Fix Text: 
#
# Edit the SSH daemon configuration and set (add if necessary) a 
# "GSSAPIAuthentication" directive set to "no".     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005524
	
# Start-Lockdown

