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
# Group ID (Vulid): V-4346
# Group Title: GEN000000-LNX00600
# Rule ID: SV-37339r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000000-LNX00600
# Rule Title: The Linux PAM system must not grant sole access to admin 
# privileges to the first user who logs into the console.
#
# Vulnerability Discussion: If an unauthorized user has been granted 
# privileged access while logged in at the console, the security posture of 
# a system could be greatly compromised.  Additionally, such a situation 
# could deny legitimate root access from another terminal.
#
# Responsibility: System Administrator
# IAControls: ECPA-1
#
# Check Content:
#
# Ensure the pam_console.so module is not configured in any files in 
# /etc/pam.d by:
#
# 	#  cd /etc/pam.d
# 	#  grep pam_console.so *
#
# Or
#
# 	# 	ls -la /etc/security/console.perms
#
# If either the pam_console.so entry or the file 
# /etc/security/console.perms is found then this is a finding.
#
# Fix Text: 
#
# Configure PAM to not grant sole access of administrative privileges to 
# the first user logged in at the console.  
#
# Identify any instances of pam_console.
#
# cd /etc/pam.d
# grep pam_console.so *
#
# For any files containing an un-commented reference to pam_console.so, 
# edit the file and remove or comment out the reference.
#
# Remove the console.perms file if it exists:
# rm /etc/security/console.perms  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000000-LNX00600
	
# Start-Lockdown

for PAMFILE in `ls -lah /etc/pam.d/ | awk '{print $9}'`
  do sed -i '/pam_console.so/d' /etc/pam.d/*
done 

if [ -a "/etc/security/console.perms" ]
then
  rm -f /etc/security/console.perms
fi

find /etc/security/console.perms.d/ -type f -name '*.perms' -exec rm -f {} \;



