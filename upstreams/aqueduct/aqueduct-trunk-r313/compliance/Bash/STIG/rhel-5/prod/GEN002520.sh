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
# Group ID (Vulid): V-807
# Group Title: GEN002520
# Rule ID: SV-37888r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002520
# Rule Title: All public directories must be owned by root or an 
# application account.
#
# Vulnerability Discussion: If a public directory has the sticky bit set 
# and is not owned by a privileged UID, unauthorized users may be able to 
# modify files created by others.

# The only authorized public directories are those temporary directories 
# supplied with the system or those designed to be temporary file 
# repositories. The setting is normally reserved for directories used by 
# the system and by users for temporary file storage, (e.g., /tmp), and for 
# directories requiring global read/write access.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the ownership of all public directories.

# Procedure:
# find / -type d -perm -1002 -exec ls -ld {} \;

# If any public directory is not owned by root or an application user, this 
# is a finding.


#
# Fix Text: 
#
# Change the owner of public directories to root or an application 
# account.

# Procedure:
# chown root /tmp

# (Replace root with an application user and/or /tmp with another public 
# directory as necessary.)     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002520
	
# Start-Lockdown

find / -type d -perm -1002 ! -user root -exec chown root {} \; 2>/dev/null
