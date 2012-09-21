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
# Group ID (Vulid): V-22470
# Group Title: GEN005521
# Rule ID: SV-37843r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005521
# Rule Title: The SSH daemon must restrict login ability to specific 
# users and/or groups.
#
# Vulnerability Discussion: Restricting SSH logins to a limited group of 
# users, such as system administrators, prevents password-guessing and 
# other SSH attacks from reaching system accounts and other accounts not 
# authorized for SSH access.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# There are two ways in which access to SSH may restrict users or groups.

# Check if /etc/pam.d/sshd is configured to require daemon style login 
# control.
# grep pam_access.so /etc/pam.d/sshd|grep "required"|grep "account"| grep 
# -v '^#' 
# If no lines are returned, sshd is not configured to use pam_access.

# Check the SSH daemon configuration for the AllowGroups setting.
# egrep -i "AllowGroups|AllowUsers" /etc/ssh/sshd_config | grep -v '^#' 
# If no lines are returned, sshd is not configured to limit access to 
# users/groups.

# If sshd is not configured to limit access either through pam_access or 
# the use "AllowUsers" or "Allowgroups", this is a finding.


#
# Fix Text: 
#
# Edit the SSH daemon configuration and add an "AllowGroups" or 
# "AllowUsers" directive specifying the groups and users allowed to have 
# access.

# Alternatively, modify the /etc/pam.d/sshd file to include the line 

# account required pam_access.so accessfile=<path to access.conf for sshd>

# If the "accessfile" option is not specified the default "access.conf" 
# file will be used. The "access.conf" file must contain the user 
# restriction definitions.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005521
	
# Start-Lockdown

