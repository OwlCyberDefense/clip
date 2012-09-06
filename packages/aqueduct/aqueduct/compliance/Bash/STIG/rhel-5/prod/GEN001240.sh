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
# Group ID (Vulid): V-796
# Group Title: GEN001240
# Rule ID: SV-37220r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001240
# Rule Title: System files, programs, and directories must be group-owned 
# by a system group.
#
# Vulnerability Discussion: Restricting permissions will protect the 
# files from unauthorized modification.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the group-ownership of system files, programs, and directories.

# Procedure:
# ls -lLa /etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin

# If any system file, program, or directory is not owned by a system group, 
# this is a finding.

#
# Fix Text: 
#
# Change the group-owner of system files to a system group.

# Procedure:
# chgrp root /path/to/system/file

# (System groups other than root may be used.)     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001240
	
# Start-Lockdown

function is_system_group {

  CURGROUP=$1

  # Check that the group belongs to a system group(GID<500)
  for SYSGROUP in `awk -F ':' '{if($3 < 500) print $1}' /etc/group`
  do
    if [ "$SYSGROUP" = "$CURGROUP" ]
    then
      return 0
    fi
  done

  return 1
}

#Start-Lockdown

# Lets go through all of the files and if they are not owned by a group
# with a gid < 500,  make the group-owner root.
for CHKDIR in /etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin
do

  if [ -d "$CHKDIR" ]
  then
    for FILENAME in `find $CHKDIR ! -type l`
    do

      if [ -e "$FILENAME" ]
      then
        CURGROUP=`stat -c %G $FILENAME`;
        is_system_group $CURGROUP
        if [ $? -ne 0 ]
        then
          chgrp root $FILENAME
        fi
      fi

    done  # End "for FILENAME ..." loop

  fi  # End "if [ -d $CHKDIR..." conditional

done  # End "for CHKDIR ..." for loop
