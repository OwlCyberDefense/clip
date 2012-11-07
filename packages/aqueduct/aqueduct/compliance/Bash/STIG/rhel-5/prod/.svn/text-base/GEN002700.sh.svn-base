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
# Group ID (Vulid): V-813
# Group Title: GEN002700
# Rule ID: SV-37916r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002700
# Rule Title: System audit logs must have mode 0640 or less permissive.
#
# Vulnerability Discussion: If a user can write to the audit logs, audit 
# trails can be modified or destroyed and system intrusion may not be 
# detected.  System audit logs are those files generated from the audit 
# system and do not include activity, error, or other log files created by 
# application software.
#
# Responsibility: System Administrator
# IAControls: ECTP-1
#
# Check Content:
#
# Perform the following to determine the location of audit logs and then 
# check the mode of the files.
# Procedure:
# grep "^log_file" /etc/audit/auditd.conf|sed s/^[^\/]*//|xargs stat -c 
# %a:%n

# If any audit log file has a mode more permissive than 0640, this is a 
# finding.


#
# Fix Text: 
#
# Change the mode of the audit log directories/files.
# chmod 0750 <audit directory>
# chmod 0640 <audit file>
  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002700
	
# Start-Lockdown

if [ -e /etc/audit/audit.conf ]
then
  LOGFILES=$( grep "^log_file" /etc/audit/auditd.conf|sed s/^[^\/]*//|xargs stat -c %a:%n | cut -d ":" -f 2 )
  find $LOGFILES -perm /7137 -exec chmod u-xs,g-wxs,o-rwxt {} \;
fi
