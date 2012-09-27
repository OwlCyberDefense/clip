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
# Group ID (Vulid): V-22368
# Group Title: GEN002430
# Rule ID: SV-37623r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002430
# Rule Title: Removable media, remote file systems, and any file system 
# not containing approved device files must be mounted with the "nodev" 
# option.
#
# Vulnerability Discussion: The "nodev" (or equivalent) mount option 
# causes the system to not handle device files as system devices. This 
# option must be used for mounting any file system not containing approved 
# device files. Device files can provide direct access to system hardware 
# and can compromise security if not protected.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check /etc/mtab and verify the "nodev" mount option is used on any 
# filesystems mounted from removable media or network shares. If any 
# filesystem mounted from removable media or network shares does not have 
# this option, this is a finding.
#
# Fix Text: 
#
# Edit /etc/fstab and add the "nodev" option to any filesystems mounted 
# from removable media or network shares.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002430
	
# Start-Lockdown

# This is full of unknowns.  So lets have an allow list and go from there.
# Anything that has a bin or sbin directory will be excluded by default.

EXCLUDE="/ /dev /dev/shm /dev/pts /selinux"

for MOUNT in `awk '!/^#/{print $2}' /etc/fstab`
do
  MOUNT=$(printf '%q' "$MOUNT")
  EXC=0
  for EXCL in $EXCLUDE
  do
    if [ "$EXCL" == "$MOUNT" ]
    then
      EXC=1
    fi
  done

  if [ $EXC == 0 ]
  then
    egrep "$MOUNT.*nodev" /etc/fstab > /dev/null
    if [ $? != 0 ]
    then
      MOUNT_OPTS=$( grep "$MOUNT" /etc/fstab | awk '{print $4}' )
      sed -i -e "s|\(${MOUNT}.*${MOUNT_OPTS}\)|\1,nodev|g" /etc/fstab
    fi
  fi
done
