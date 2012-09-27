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
# Group ID (Vulid): V-777
# Group Title: GEN000960
# Rule ID: SV-37372r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000960
# Rule Title: The root account must not have world-writable directories 
# in its executable search path.
#
# Vulnerability Discussion: If the root search path contains a 
# world-writable directory, malicious software could be placed in the path 
# by intruders and/or malicious users and inadvertently run by root with 
# all of root's privileges.

#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# Check for world-writable permissions on all directories in the root 
# user's executable search path.

# Procedure:
# ls -ld `echo $PATH | sed "s/:/ /g"`

# If any of the directories in the PATH variable are world-writable, this 
# is a finding.
#
# Fix Text: 
#
# For each world-writable path in root's executable search path, do one 
# of the following:

# 1. Remove the world-writable permission on the directory.
# Procedure:
# chmod o-w <path>

# 2. Remove the world-writable directory from the executable search path.
# Procedure:
# Identify and edit the initialization file referencing the world-writable 
# directory and remove it from the PATH variable.   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000960
	
# Start-Lockdown

for BADDIR in `echo $PATH | sed "s/:/ /g"`
do
  if [ -d "$BADDIR" ]
  then
    find -H $BADDIR -maxdepth 1 -type f -perm /0002 -exec chmod o-w {} \;
  fi
done



