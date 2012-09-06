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
# Group ID (Vulid): V-906
# Group Title: GEN001580
# Rule ID: SV-37192r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001580
# Rule Title: All run control scripts must have mode 0755 or less 
# permissive.
#
# Vulnerability Discussion: If the startup files are writable by other 
# users, they could modify the startup files to insert malicious commands 
# into the startup files.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check run control script modes.
# cd /etc
# ls -lL rc*
# cd /etc/init.d
# ls -l
# If any run control script has a mode more permissive than 0755, this is a 
# finding.


#
# Fix Text: 
#
# Ensure all system startup files have mode 0755 or less permissive. 
# Examine the "rc" files, and all files in the rc1.d (rc2.d, and so on) 
# directories, and in the /etc/init.d directory to ensure they are not 
# world-writable. If they are world-writable, use the chmod command to 
# correct the vulnerability and research why they are world-writable.

# Procedure: 
# chmod 755 <startup file>   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001580
	
# Start-Lockdown

find /etc/rc.d/ -type f -perm /7022 -exec chmod u-s,g-ws,o-wt {} \;

