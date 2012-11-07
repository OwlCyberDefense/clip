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
# Group ID (Vulid): V-775
# Group Title: GEN000920
# Rule ID: SV-37355r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000920
# Rule Title: The root account's home directory (other than /) must have 
# mode 0700.
#
# Vulnerability Discussion: Permissions greater than 0700 could allow 
# unauthorized users access to the root home directory.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# Check the mode of the root home directory.

# Procedure:
# grep "^root" /etc/passwd | awk -F":" '{print $6}'
# ls -ld <root home directory>

# If the mode of the directory is not equal to 0700, this is a finding. If 
# the home directory is /, this check will be marked "Not Applicable".
#
# Fix Text: 
#
# The root home directory will have permissions of 0700. Do not change 
# the protections of the / directory. Use the following command to change 
# protections for the root home directory: 
# chmod 0700 /rootdir.   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000920
	
# Start-Lockdown

if [ -e "/root" ]
then

  FILEPERMS=`stat -L --format='%04a' /root`
  if [ "$FILEPERMS" != "0700" ]
  then
    chmod 0700 /root
  fi

fi

