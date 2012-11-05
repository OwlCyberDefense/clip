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
# Group ID (Vulid): V-924
# Group Title: GEN002280
# Rule ID: SV-37553r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002280
# Rule Title: Device files and directories must only be writable by users 
# with a system account or as configured by the vendor.
#
# Vulnerability Discussion: System device files in writable directories 
# could be modified, removed, or used by an unprivileged user to control 
# system hardware.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2, ECLP-1
#
# Check Content:
#
# Find all world-writable device files existing anywhere on the system.

# Procedure:
# find / -perm -2 -a \( -type b -o -type c \) > devicelist
# Check the permissions on the directories above subdirectories containing 
# device files. If any of the device files or their parent directories are 
# world-writable, excepting device files specifically intended to be 
# world-writable such as /dev/null, this is a finding.
#
# Fix Text: 
#
# Remove the world-writable permission from the device file(s).

# Procedure:
# chmod o-w <device file>

# Document all changes.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002280
	
# Start-Lockdown

WWWFiles=$( find / -fstype nfs -prune -o -perm -2 -a \( -type b -o -type c \) 2>/dev/null | egrep -v '(/dev/full|/dev/random|/dev/zero|/dev/tty|/dev/ptmx|/dev/null|/dev/urandom|/selinux/null|/dev/fuse|/dev/net/tun)' )

#Known WWW Files contained under /dev dir are excluded (see comment above)
#/dev/full
#/dev/random
#/dev/zero
#/dev/tty
#/dev/ptmx
#/dev/null
#/dev/urandom
#/selinux/null


#Start-Lockdown

for file in $WWWFiles
do
  # Red Hat keeps most of the defaults secure so you may never need this
  # but just changing the dev file probably will not do the trick.  If we
  # need to fix a device file's permissions, we will probably have to change
  # the udev rule for that device so the permissions are set properly when
  # the device is created. 
  chmod o-w $file
done

