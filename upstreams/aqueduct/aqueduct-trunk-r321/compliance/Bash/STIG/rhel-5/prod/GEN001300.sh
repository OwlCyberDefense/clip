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
# Group ID (Vulid): V-793
# Group Title: GEN001300
# Rule ID: SV-37241r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001300
# Rule Title: Library files must have mode 0755 or less permissive.
#
# Vulnerability Discussion: Unauthorized access could destroy the 
# integrity of the library files.
#
# Responsibility: System Administrator
# IAControls: DCSL-1
#
# Check Content:
#
# Check the mode of library files.

# Procedure:
# DIRS="/usr/lib /lib";for DIR in $DIRS;do find $DIR -type f -perm +022 
# -exec stat -c %a:%n {} \;;done

# This will return the octal permissions and name of all  group or world 
# writable files.
# If any file listed is world or group writable (either or both of the 2 
# lowest order digits contain a 2, 3 or 6), this is a finding.


#
# Fix Text: 
#
# Change the mode of library files to 0755 or less permissive.

# Procedure (example):
# chmod go-w </path/to/library-file>

# Note: Library files should have an extension of ".a" or a ".so" 
# extension, possibly followed by a version number.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001300
	
# Start-Lockdown

for LIBDIR in /usr/lib /usr/lib64 /lib /lib64
do
  if [ -d $LIBDIR ]
  then
    for BADLIBFILE in `find $LIBDIR -type f -perm /7022 \( -name *.so* -o -name *.a* \)`
    do
      chmod o-s,g-ws,o-wt $BADLIBFILE
    done
  fi
done

