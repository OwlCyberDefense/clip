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
# Group ID (Vulid): V-978
# Group Title: GEN003080
# Rule ID: SV-37466r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003080
# Rule Title: Crontab files must have mode 0600 or less permissive, and 
# files in cron script directories must have mode 0700 or less permissive.
#
# Vulnerability Discussion: To protect the integrity of scheduled system 
# jobs and prevent malicious modification to these jobs, crontab files must 
# be secured.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the mode of the crontab files.
# ls -lL /var/spool/cron/
# ls -lL /etc/cron.d/
# ls -lL /etc/crontab
# If any crontab file has a mode more permissive than 0600, this is a 
# finding.
#
# Fix Text: 
#
# Change the mode of the crontab files.
# chmod 0600 /var/spool/cron/* /etc/cron.d/* /etc/crontab  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003080
	
# Start-Lockdown

find /var/spool/cron /etc/cron.d /etc/crontab -type f -perm /7177 -exec chmod u-xs,g-rwxs,o-rwxt {} \;

find /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly -type f -perm /7077 -exec chmod u-s,g-rwxs,o-rwxt {} \;


