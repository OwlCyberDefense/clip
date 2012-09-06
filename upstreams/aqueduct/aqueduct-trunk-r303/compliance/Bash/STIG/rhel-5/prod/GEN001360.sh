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
# Group ID (Vulid): V-791
# Group Title: GEN001360
# Rule ID: SV-37272r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001360
# Rule Title: The NIS/NIS+/yp command files must have mode 0755 or less 
# permissive.
#
# Vulnerability Discussion: NIS/NIS+/yp files are part of the system's 
# identification and authentication processes and are critical to system 
# security.  Unauthorized modification of these files could compromise 
# these processes and the system.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Perform the following to check NIS file premissions.
# ls -la /var/yp/*;
# If the file's mode is more permissive than 0755, this is a finding.


#
# Fix Text: 
#
# Change the mode of NIS/NIS+/yp command files to 0755 or less permissive.

# Procedure (example):
# chmod 0755 <filename>     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001360
	
# Start-Lockdown

BADYPFILE=`find /var/yp/ -type f -perm /7022`
for BADFILE in $BADYPFILE
do
  chmod u-s,g-ws,o-wt $BADFILE
done

