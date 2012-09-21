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
# Group ID (Vulid): V-22506
# Group Title: GEN006565
# Rule ID: SV-37751r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN006565
# Rule Title: The system package management tool must be used to verify 
# system software periodically.
#
# Vulnerability Discussion: Verification using the system package 
# management tool can be used to determine that system software has not 
# been tampered with.

# This requirement is not applicable to systems not using package 
# management tools.
#
# Responsibility: System Administrator
# IAControls: ECAT-1
#
# Check Content:
#
# Check the root crontab (crontab -l) and the global crontabs in 
# "/etc/crontab", "/etc/cron.*" for the presence of an rpm verification 
# command such as:
# rpm -qVa | awk '$2!="c" {print $0}'
# If no such cron job is found, this is a finding.
# If the result of the cron job indicates packages which do not pass 
# verification exist, this is a finding.


#
# Fix Text: 
#
# Add a cron job to run an rpm verification command such as:
# rpm -qVa | awk '$2!="c" {print $0}'

# For packages which failed verification:
# If the package is not necessary for operations, remove it from the system.

# If the package is necessary for operations, re-install the package.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006565
	
# Start-Lockdown

