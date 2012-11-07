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
# Group ID (Vulid): V-11977
# Group Title: GEN000740
# Rule ID: SV-37302r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000740
# Rule Title: All non-interactive/automated processing account passwords 
# must be changed at least once per year or be locked.
#
# Vulnerability Discussion: Limiting the lifespan of authenticators 
# limits the period of time an unauthorized user has access to the system 
# while using compromised credentials and reduces the period of time 
# available for password-guessing attacks to run against a single password. 
#  Locking the password for non-interactive and automated processing 
# accounts is preferred as it removes the possibility of accessing the 
# account by a password.  On some systems, locking the passwords of these 
# accounts may prevent the account from functioning properly.  Passwords 
# for non-interactive/automated processing accounts must not be used for 
# direct logon to the system.
#
# Responsibility: System Administrator
# IAControls: IAIA-1, IAIA-2
#
# Check Content:
#
# Ask the SA if there are any automated processing accounts on the 
# system. If there are automated processing accounts on the system, ask the 
# SA if the passwords for those automated accounts are changed at least 
# once a year or are locked. If SA indicates passwords for automated 
# processing accounts are not changed once per year or are not locked, this 
# is a finding.
#
# Fix Text: 
#
#  Implement or establish procedures to change the passwords of automated 
# processing accounts at least once per year or lock them.   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000740

#This could be set, but would probably end up locking out account after a year.  Not a great idea.  Admin tasking to sort this out. 
	
# Start-Lockdown

