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
# Group ID (Vulid): V-989
# Group Title: GEN003380
# Rule ID: SV-37520r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003380
# Rule Title: The "at" daemon must not execute programs in, or 
# subordinate to, world-writable directories.
#
# Vulnerability Discussion: If "at" programs are located in, or 
# subordinate, to world-writable directories, they become vulnerable to 
# removal and replacement by malicious users or system intruders.
#
# Responsibility: System Administrator
# IAControls: DCSL-1
#
# Check Content:
#
# List any "at" jobs on the system.
# Procedure:
# ls /var/spool/at

# For each "at" job, determine which programs are executed by "at."
# Procedure:
# more <at job file>

# Check the directory containing each program executed by "at" for 
# world-writable permissions.
# Procedure:
# ls -la <at program file directory>

# If "at" executes programs in world-writable directories, this is a 
# finding.
#
# Fix Text: 
#
# Remove the world-writable permission from directories containing 
# programs executed by "at".

# Procedure:
# chmod o-w <at program directory>     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003380
	
# Start-Lockdown

