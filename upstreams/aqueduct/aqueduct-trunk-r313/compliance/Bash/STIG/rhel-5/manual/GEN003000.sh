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
# Group ID (Vulid): V-976
# Group Title: GEN003000
# Rule ID: SV-37384r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003000
# Rule Title: Cron must not execute group-writable or world-writable 
# programs.
#
# Vulnerability Discussion: If cron executes group-writable or 
# world-writable programs, there is a possibility that unauthorized users 
# could manipulate the programs with malicious intent.  This could 
# compromise system and network security.
#
# Responsibility: System Administrator
# IAControls: DCSL-1
#
# Check Content:
#
# List all cronjobs on the system. 
# Procedure:

# ls /var/spool/cron

# ls /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly 
# /etc/cron.monthly /etc/cron.weekly
# or 
# ls /etc/cron*|grep -v deny

# If cron jobs exist under any of the above directories, use the following 
# command to search for programs executed by cron:

# more <cron job file>

# Perform a long listing of each program file found in the cron file to 
# determine if the file is group-writable or world-writable.

# ls -la <cron program file>

# If cron executes group-writable or world-writable files, this is a 
# finding.
#
# Fix Text: 
#
# Remove the world-writable and group-writable permissions from the cron 
# program file(s) identified.
# chmod go-w <cron program file>    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003000
	
# Start-Lockdown

