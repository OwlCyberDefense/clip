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
# Group ID (Vulid): V-760
# Group Title: GEN000280
# Rule ID: SV-37419r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000280
# Rule Title: Direct logins must not be permitted to shared, default, 
# application, or utility accounts.
#
# Vulnerability Discussion: Shared accounts (accounts where two or more 
# people log in with the same user identification) do not provide 
# identification and authentication.  There is no way to provide for 
# non-repudiation or individual accountability.
#
# Responsibility: Information Assurance Officer
# IAControls: ECSC-1, IAIA-1
#
# Check Content:
#
# Use the last command to check for multiple accesses to an account from 
# different workstations/IP addresses.

# last -R

# If users log directly onto accounts, rather than using the switch user 
# (su) command from their own named account to access them, this is a 
# finding (such as logging directly on to oracle).

# Verify with the SA or the IAO on documentation for users/administrators 
# to log into their own accounts first and then switch user (su) to the 
# account to be shared has been maintained including requirements and 
# procedures. If no such documentation exists, this is a finding. 
#
# Fix Text: 
#
# Use the switch user (su) command from a named account login to access 
# shared accounts. Document requirements and procedures for 
# users/administrators to log into their own accounts first and then switch 
# user (su) to the account to be shared.       
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000280
	
# Start-Lockdown

#Can't do this one, up to the Admin. 

