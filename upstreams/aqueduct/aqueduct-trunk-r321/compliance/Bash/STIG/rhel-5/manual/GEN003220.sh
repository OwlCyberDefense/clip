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
# Group ID (Vulid): V-4360
# Group Title: GEN003220
# Rule ID: SV-37489r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN003220
# Rule Title: Cron programs must not set the umask to a value less 
# restrictive than 077.
#
# Vulnerability Discussion: The umask controls the default access mode 
# assigned to newly created files.  A umask of 077 limits new files to mode 
# 700 or less permissive.  Although umask is often represented as a 4-digit 
# octal number, the first digit representing special access modes is 
# typically ignored or required to be 0.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# Determine if there are any crontabs by viewing a long listing of the 
# directory. If there are crontabs, examine them to determine what cron 
# jobs exist. Check for any programs  specifying an umask more permissive 
# than 077:

# Procedure:

# ls -lL /var/spool/cron

# ls -lL /etc/cron.d /etc/cron.daily /etc/cron.hourly /etc/cron.monthly 
# /etc/cron.weekly
# or 
# ls -lL /etc/cron.*|grep -v deny

# cat <crontab file>
# grep umask <cron program>

# If there are no cron jobs present, this vulnerability is not applicable. 
# If any cron job contains an umask more permissive than 077, this is a 
# finding.
#
# Fix Text: 
#
# Edit cron script files and modify the umask to 077.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003220
	
# Start-Lockdown

