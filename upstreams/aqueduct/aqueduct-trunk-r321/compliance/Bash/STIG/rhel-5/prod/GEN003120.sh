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
# Group ID (Vulid): V-980
# Group Title: GEN003120
# Rule ID: SV-37474r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003120
# Rule Title: Cron and crontab directories must be owned by root or bin.
#
# Vulnerability Discussion: Incorrect ownership of the cron or crontab 
# directories could permit unauthorized users the ability to alter cron 
# jobs and run automated jobs as privileged users.  Failure to give 
# ownership of cron or crontab directories to root or to bin provides the 
# designated owner and unauthorized users with the potential to access 
# sensitive information or change the system configuration which could 
# weaken the system's security posture.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the owner of the crontab directories.
# Procedure:

# ls -ld /var/spool/cron

# ls -ld /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly 
# /etc/cron.monthly /etc/cron.weekly
# or 
# ls -ld /etc/cron*|grep -v deny


# If the owner of any of the crontab directories is not root or bin, this 
# is a finding.
#
# Fix Text: 
#
# Change the mode of the crontab directories.
# chown root <crontab directory>   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003120
	
# Start-Lockdown

for CRONDIR in /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly /var/spool/cron
do
  CUROWN=`stat -c %U $CRONDIR`;
  if [ "$CUROWN" != "root" -a "$CUROWN" != "bin" ]
    then
      chown root $CRONDIR
  fi
done
