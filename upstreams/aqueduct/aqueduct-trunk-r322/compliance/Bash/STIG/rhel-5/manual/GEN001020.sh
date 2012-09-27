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
# Group ID (Vulid): V-11979
# Group Title: GEN001020
# Rule ID: SV-37377r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001020
# Rule Title: The root account must not be used for direct log in.
#
# Vulnerability Discussion: Direct login with the root account prevents 
# individual user accountability.  Acceptable non-routine uses of the root 
# account for direct login are limited to emergency maintenance, the use of 
# single-user mode for maintenance, and situations where individual 
# administrator accounts are not available.
#
# Responsibility: System Administrator
# IAControls: ECPA-1
#
# Check Content:
#
# Check if root is used for direct logins.

# Procedure:
# last root | grep -v reboot

# If any direct login records for root are listed, this is a finding.
#
# Fix Text: 
#
# Enforce policy requiring all root account access is attained by first 
# logging into a user account and then becoming root preferably through the 
# use of "sudo" which provides traceability to the command level. If that 
# is not workable then using "su" to access the root account will provide 
# traceability to the login user.    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001020
	
# Start-Lockdown

#This is up to the admin.  Some people restict by sudo, some by su.  Up to the Admin. 

