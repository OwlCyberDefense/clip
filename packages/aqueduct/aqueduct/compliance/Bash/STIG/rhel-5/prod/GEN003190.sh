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
# Group ID (Vulid): V-22388
# Group Title: GEN003190
# Rule ID: SV-37477r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003190
# Rule Title: The cron log files must not have extended ACLs.
#
# Vulnerability Discussion: Cron logs contain reports of scheduled system 
# activities and must be protected from unauthorized access or manipulation.
#
# Responsibility: System Administrator
# IAControls: ECLP-1, ECTP-1
#
# Check Content:
#
# Check the permissions of the file.

# Procedure:
# Check the configured cron log file found in the cron entry in /etc/syslog 
# (normally /var/log/cron).
# grep cron /etc/syslog.conf
# ls -lL /var/log/cron

# If the permissions include a '+', the file has an extended ACL. If the 
# file has an extended ACL and it has not been documented with the IAO, 
# this is a finding.
#
# Fix Text: 
#
# Remove the extended ACL from the file.
# setfacl --remove-all /var/log/cron   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003190
ACLOUT=`getfacl --skip-base /var/log/cron 2>/dev/null`;

# Start-Lockdown


if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all /var/log/cron
fi
