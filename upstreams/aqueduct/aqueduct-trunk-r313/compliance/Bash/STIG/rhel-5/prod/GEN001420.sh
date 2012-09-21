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
# Group ID (Vulid): V-800
# Group Title: GEN001420
# Rule ID: SV-37368r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001420
# Rule Title: The /etc/shadow (or equivalent) file must have mode 0400.
#
# Vulnerability Discussion: The /etc/shadow file contains the list of 
# local system accounts.  It is vital to system security and must be 
# protected from unauthorized modification.  The file also contains 
# password hashes which must not be accessible to users other than root.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the mode of the /etc/shadow file.
# ls -lL /etc/shadow
# If the /etc/shadow file has a mode more permissive than 0400, this is a 
# finding.


#
# Fix Text: 
#
# Change the mode of the /etc/shadow (or equivalent) file.
# chmod 0400 /etc/shadow     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001420
	
# Start-Lockdown

if [ -a "/etc/shadow" ]
then
  # Pull the actual permissions
  FILEPERMS=`stat -L --format='%04a' /etc/shadow`

  # Break the actual file octal permissions up per entity
  FILESPECIAL=${FILEPERMS:0:1}
  FILEOWNER=${FILEPERMS:1:1}
  FILEGROUP=${FILEPERMS:2:1}
  FILEOTHER=${FILEPERMS:3:1}

  # Run check by 'and'ing the unwanted mask(7377)
  if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&3)) != "0" ] || [ $(($FILEGROUP&7)) != "0" ] || [ $(($FILEOTHER&7)) != "0" ]
  then
    chmod u-wxs,g-rwxs,o-rwxt /etc/shadow
  fi
fi



