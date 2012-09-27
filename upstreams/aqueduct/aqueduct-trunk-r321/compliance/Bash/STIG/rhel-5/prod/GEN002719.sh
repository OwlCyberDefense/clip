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
# Group ID (Vulid): V-22374
# Group Title: GEN002719
# Rule ID: SV-26517r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN002719
# Rule Title: The audit system must alert the SA in the event of an audit 
# processing failure.
#
# Vulnerability Discussion: An accurate and current audit trail is 
# essential for maintaining a record of system activity.  If the system 
# fails, the SA must be notified and must take prompt action to correct the 
# problem.

# Minimally, the system must log this event and the SA will receive this 
# notification during the daily system log review.  If feasible, active 
# alerting (such as e-mail or paging) should be employed consistent with 
# the site’s established operations management systems and procedures.
#
# Responsibility: System Administrator
# IAControls: ECAT-1
#
# Check Content:
#
# Verify the /etc/audit/auditd.conf has the disk_full_action and 
# disk_error_action parameters set.

# Procedure:
# grep disk_full_action /etc/audit/audit.conf

# If the disk_full_action parameter is missing or set to "suspend" or 
# "ignore" this is a finding.

# grep disk_error_action /etc/audit/audit.conf

# If the disk_error_action parameter is missing or set to "suspend" or 
# "ignore" this is a finding.

#
# Fix Text: 
#
# Edit /etc/audit/auditd.conf and set the disk_full_action and/or 
# disk_error_action parameters to a valid setting of "syslog", "exec", 
# "single" or "halt", adding the parameters if necessary.   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002719
AUDITLOGFILE='/etc/audit/auditd.conf'
#Start-Lockdown

#So the breakdown is this:
#Suspend with suspend the system (bad if this is an Amazon image or something)
#Single will put the system into single usermode (bad again if AMI)
#Halt will halt the system (bad again)
#exec will execute a command (Thats ok..just don't know what everyone would want it to be)
#So were going to assume that people followed the STIG guidance and configured a syslog server (and actually watch the logs)

#Default is IGNORE
sed -i 's/disk_full_action = IGNORE/disk_full_action = SYSLOG/g' $AUDITLOGFILE
sed -i 's/disk_error_action = IGNORE/disk_error_action = SYSLOG/g' $AUDITLOGFILE
#Remove if set to SUSPEND since that's not allowed either. 
sed -i 's/disk_full_action = SUSPEND/disk_full_action = SYSLOG/g' $AUDITLOGFILE
sed -i 's/disk_error_action = SUSPEND/disk_error_action = SYSLOG/g' $AUDITLOGFILE