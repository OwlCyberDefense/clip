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

##################### Fusion Technology LLC #############################
# By Shannon Mitchell                                                   #
# Fusion Technology LLC                                                 #
# Shannon[.]Mitchell[@]fusiontechnology-llc[.]com                       #
# www.fusiontechnology-llc.com                                          #
##################### Fusion Technology LLC #############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Shannon Mitchell   | 15-jul-2012|
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-4268
# Group Title: GEN000000-LNX00320
# Rule ID: SV-37181r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN000000-LNX00320
# Rule Title: The system must not have special privilege accounts, such 
# as shutdown and halt.
#
# Vulnerability Discussion: If special privilege accounts are 
# compromised, the accounts could provide privileges to execute malicious 
# commands on a system.
#
# Responsibility: System Administrator
# IAControls: IAAC-1
#
# Check Content:
#
# Perform the following to check for unnecessary privileged accounts:

# grep "^shutdown" /etc/passwd
# grep "^halt" /etc/passwd
# grep "^reboot" /etc/passwd

# If any unnecessary privileged accounts exist this is a finding.
#
# Fix Text: 
#
# Remove any special privilege accounts, such as shutdown and halt, from 
# the /etc/passwd and /etc/shadow files using the "userdel" or 
# "system-config-users" commands.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000000-LNX00320
	
#Start-Lockdown

HALTACCOUNT=`grep -c '^halt' /etc/passwd`
SHUTDOWNACCOUNT=`grep -c '^shutdown' /etc/passwd`
REBOOTACCOUNT=`grep -c '^reboot' /etc/passwd`

if [ $HALTACCOUNT -ne 0	]
then
  userdel halt 
fi

if [ $SHUTDOWNACCOUNT -ne 0 ]
then
  userdel shutdown 
fi

if [ $REBOOTACCOUNT -ne 0 ]
then
  userdel reboot 
fi
