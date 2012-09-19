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
# Group ID (Vulid): V-22386
# Group Title: GEN003090
# Rule ID: SV-37467r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003090
# Rule Title: Crontab files must not have extended ACLs.
#
# Vulnerability Discussion: To protect the integrity of scheduled system 
# jobs and to prevent malicious modification to these jobs, crontab files 
# must be secured.  ACLs on crontab files may provide unauthorized access 
# to the files.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the permissions of the crontab files.
# Procedure:

# ls -lL /var/spool/cron

# ls -lL /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly 
# /etc/cron.monthly /etc/cron.weekly
# or 
# ls -lL /etc/cron*|grep -v deny

# If the permissions include a '+', the file has an extended ACL. If the 
# file has an extended ACL and it has not been documented with the IAO, 
# this is a finding.
#
# Fix Text: 
#
# Remove the extended ACL from the file.
# setfacl --remove-all [crontab file]     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003090
	
# Start-Lockdown

for CRONFILE in `find /var/spool/cron /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly -type f`
do
  ACLOUT=`getfacl --skip-base $CRONFILE 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all $CRONFILE
  fi
done
