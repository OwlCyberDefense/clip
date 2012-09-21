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
# Group ID (Vulid): V-983
# Group Title: GEN003180
# Rule ID: SV-27357r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003180
# Rule Title: The cronlog file must have mode 0600 or less permissive.
#
# Vulnerability Discussion: Cron logs contain reports of scheduled system 
# activities and must be protected from unauthorized access or manipulation.

#
# Responsibility: System Administrator
# IAControls: ECLP-1, ECTP-1
#
# Check Content:
#
# Check the mode of the cron log file.

# Procedure:
# Check the configured cron log file found in the cron entry in /etc/syslog 
# (normally /var/log/cron).
# grep cron /etc/syslog.conf
# ls -lL /var/log/cron

# If the mode is more permissive than 0600, this is a finding.
#
# Fix Text: 
#
# Change the mode of the cron log file.
# chmod 0600 /var/log/cron   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003180
	
# Start-Lockdown

find /var/log/cron -perm /7177 -exec chmod u-xs,g-rwxs,o-rwxt {} \;
