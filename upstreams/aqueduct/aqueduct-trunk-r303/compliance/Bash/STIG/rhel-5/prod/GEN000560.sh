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
# Group ID (Vulid): V-770
# Group Title: GEN000560
# Rule ID: SV-37259r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN000560
# Rule Title: The system must not have accounts configured with blank or 
# null passwords.
#
# Vulnerability Discussion: If an account is configured for password 
# authentication but does not have an assigned password, it may be possible 
# to log into the account without authentication.  If the root user is 
# configured without a password, the entire system may be compromised.  For 
# user accounts not using password authentication, the account must be 
# configured with a password lock value instead of a blank or null value.  
#
# Responsibility: System Administrator
# IAControls: IAIA-1, IAIA-2
#
# Check Content:
#
# Verify the system will not log in accounts with blank passwords.
# grep nullok /etc/pam.d/system-auth /etc/pam.d/system-auth-ac
# If an entry for nullok is found, this is a finding on Linux.
#
# Fix Text: 
#
# Edit /etc/pam.d/system-auth and remove the "nullok" setting.    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000560
	
# Start-Lockdown

grep 'nullok' /etc/pam.d/* > /dev/null
if [ $? == 0 ]
then
  sed -i 's/ nullok//g' /etc/pam.d/*
fi
