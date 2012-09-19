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
# Group ID (Vulid): V-988
# Group Title: GEN003360
# Rule ID: SV-37519r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003360
# Rule Title: The "at" daemon must not execute group-writable or 
# world-writable programs.
#
# Vulnerability Discussion: If the "at" facility executes world-writable 
# or group-writable programs, it is possible for the programs to be 
# accidentally or maliciously changed or replaced without the owner's 
# intent or knowledge.  This would cause a system security breach.
#
# Responsibility: System Administrator
# IAControls: DCSL-1
#
# Check Content:
#
# List the "at" jobs on the system.

# Procedure:
# ls -la /var/spool/at

# For each "at" job file, determine which programs are executed.

# Procedure:
# more <at job file>

# Check the each program executed by "at" for group- or world-writable 
# permissions.
# Procedure:
# ls -la <at program file>

# If "at" executes group or world-writable programs, this is a finding.
#
# Fix Text: 
#
# Remove group-write and world-write permissions from files executed by 
# at jobs.

# Procedure:
# chmod go-w <file>     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003360
	
# Start-Lockdown

