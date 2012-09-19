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
# Group ID (Vulid): V-4357
# Group Title: GEN002860
# Rule ID: SV-37945r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002860
# Rule Title: Audit logs must be rotated daily.
#
# Vulnerability Discussion: Rotate audit logs daily to preserve audit 
# file system space and to conform to the DoD/DISA requirement.  If it is 
# not rotated daily and moved to another location, then there is more of a 
# chance for the compromise of audit data by malicious users.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check for any crontab entries that rotate audit logs.
# Procedure:
# crontab -l
# If such a cron job is found, this is not a finding.

# Otherwise, query the SA. If there is a process automatically rotating 
# audit logs, this is not a finding. If the SA manually rotates audit logs, 
# this is a finding, because if the SA is not there, it will not be 
# accomplished. If the audit output is not archived daily, to tape or disk, 
# this is a finding. This can be ascertained by looking at the audit log 
# directory and, if more than one file is there, or if the file does not 
# have today's date, this is a finding.


#
# Fix Text: 
#
# Configure a cron job or other automated process to rotate the audit 
# logs on a daily basis.   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002860
WEEKLYON=$(cat /etc/logrotate.conf |grep -i -c '^weekly')
MONTHYLON=$(cat /etc/logrotate.conf |grep -i -c 'monthly')
#COMPRESSON=$(cat /etc/logrotate.conf |grep -c '^#compress')

#Start-Lockdown

if [ $WEEKLYON -eq 1 ]
  then
    sed -i 's/weekly/daily/g' /etc/logrotate.conf
fi

if [ $MONTHYLON -ne 0 ]
  then
      sed -i 's/monthly/daily/g' /etc/logrotate.conf
fi


#This isn't a requirement, but with the possibility a system could be halted due to /var/log becoming full, probably a good idea. Plus it makes it harder for someone to go back and modify the logs without being noticed. 
#if [ $COMPRESSON -eq 1]
#  then
#sed -i 's/#compress/compress/g' /etc/logrotate.conf
#fi
