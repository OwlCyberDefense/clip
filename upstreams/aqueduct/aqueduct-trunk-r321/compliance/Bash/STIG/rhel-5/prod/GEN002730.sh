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
# Group ID (Vulid): V-22375
# Group Title: GEN002730
# Rule ID: SV-26518r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002730
# Rule Title: The audit system must alert the SA when the audit storage 
# volume approaches its capacity.
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
# IAControls: ECSC-1
#
# Check Content:
#
# Check /etc/audit/auditd.conf for the space_left_action and 
# action_mail_accnt parameters. If the space_left_action or the 
# action_mail_accnt parameters are set to blanks, this is a finding.

# If the space_left_action is set to "syslog"the system logs the event, 
# this is not a finding.

# If the space_left_action is set to "exec"the system executes a designated 
# script. If this script informs the SA of the event, this is not a finding.

# If the space_left_action parameter is missing, this is a finding.
# If the space_left_action parameter is set to "ignore" or "suspend" no 
# logging would be performed after the event, this is a finding.
# If the space_left_action parameter is set to "single" or "halt" this 
# effectively stops the system causing a Denial of Service, this is a 
# finding.

# If the space_left_action is set to "email" and the action_mail_acct 
# parameter is not set to the e-mail address of the system administrator, 
# this is a finding. The action_mail_acct parameter, if missing, defaults 
# to "root". Note that if the email address of the system administrator is 
# on a remote system "sendmail" must be available.


#
# Fix Text: 
#
# Edit /etc/audit/auditd.conf and set the space_left_action parameter to 
# a valid setting other than "ignore". If the space_left_action parameter 
# is set to "email" set the action_mail_acct parameter to an e-mail address 
# for the system administrator.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002730
	
# Start-Lockdown

sed -i 's/space_left_action = IGNORE/space_left_action = SYSLOG/g' /etc/audit/auditd.conf
sed -i 's/space_left_action = SUSPEND/space_left_action = SYSLOG/g' /etc/audit/auditd.conf