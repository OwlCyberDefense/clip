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
# Group ID (Vulid): V-12003
# Group Title: GEN003620
# Rule ID: SV-37640r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN003620
# Rule Title: A separate file system must be used for user home 
# directories (such as /home or an equivalent).
#
# Vulnerability Discussion: The use of separate file systems for 
# different paths can protect the system from failures resulting from a 
# file system becoming full or failing.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Determine if the /home path is a separate filesystem.
# grep "/home " /etc/fstab
# If no result is returned, /home is not on a separate filesystem this is a 
# finding.
#
# Fix Text: 
#
# Migrate the /home (or equivalent) path onto a separate file system.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003620
	
# Start-Lockdown

