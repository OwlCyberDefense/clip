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
# Group ID (Vulid): V-1010
# Group Title: GEN002480
# Rule ID: SV-37645r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002480
# Rule Title: Public directories must be the only world-writable 
# directories and world-writable files must be located only in public 
# directories.
#
# Vulnerability Discussion: World-writable files and directories make it 
# easy for a malicious user to place potentially compromising files on the 
# system.

# The only authorized public directories are those temporary directories 
# supplied with the system or those designed to be temporary file 
# repositories. The setting is normally reserved for directories used by 
# the system and by users for temporary file storage, (e.g., /tmp), and for 
# directories requiring global read/write access.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the system for world-writable files.

# Procedure:
# find / -perm -2 -a \( -type d -o -type f \) -exec ls -ld {} \;

# If any world-writable files are located, except those required for system 
# operation such as /tmp and /dev/null, this is a finding.
#
# Fix Text: 
#
# Remove or change the mode for any world-writable file on the system not 
# required to be world-writable.

# Procedure:
# chmod o-w <file>

# Document all changes  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002480
	
# Start-Lockdown

#Proc should have been called out in this check, so were going to exclude it 
#since its necessary for system operation.

#The files below are default out of RHEL 5 and are required, so well exclude them:
#/var/spool/vbox
#/var/tmp
#/var/cache/coolkey

#Global Variables#
PDI=GEN002480

WWWFILES=$( find / -fstype nfs -prune -o -perm -2 -a \( -type d -o -type f \) 2> /dev/null |egrep -v "^/proc|^/tmp|^/dev|^/var/spool/vbox|^/var/tmp|^/var/cache/coolkey|^/selinux" )

for line in $WWWFILES
do
  chmod o-w $line
done


