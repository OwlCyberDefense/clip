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
# Group ID (Vulid): V-981
# Group Title: GEN003140
# Rule ID: SV-37476r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003140
# Rule Title: Cron and crontab directories must be group-owned by root, 
# sys, bin or cron.
#
# Vulnerability Discussion: To protect the integrity of scheduled system 
# jobs and to prevent malicious modification to these jobs, crontab files 
# must be secured.  Failure to give group-ownership of cron or crontab 
# directories to a system group provides the designated group and 
# unauthorized users with the potential to access sensitive information or 
# change the system configuration which could weaken the system's security 
# posture.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the group owner of cron and crontab directories.

# Procedure:
# ls -ld /var/spool/cron

# ls -ld /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly 
# /etc/cron.monthly /etc/cron.weekly
# or 
# ls -ld /etc/cron*|grep -v deny


# If a directory is not group-owned by root, sys, bin, or cron, this is a 
# finding.
#
# Fix Text: 
#
# Change the group owner of cron and crontab directories.
# chgrp root <crontab directory>   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003140
	
# Start-Lockdown
for CRONDIR in /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly /var/spool/cron
do
  CURGOWN=`stat -c %G $CRONDIR`;

  if [ "$CURGOWN" != "root" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "cron" ]
  then
    chgrp root $CRONDIR
  fi
done
