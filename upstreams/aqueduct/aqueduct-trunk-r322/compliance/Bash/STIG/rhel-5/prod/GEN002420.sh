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
# Group ID (Vulid): V-805
# Group Title: GEN002420
# Rule ID: SV-37607r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002420
# Rule Title: Removable media, remote file systems, and any file system 
# not containing approved setuid files must be mounted with the "nosuid" 
# option.
#
# Vulnerability Discussion: The "nosuid" mount option causes the system 
# to not execute setuid files with owner privileges. This option must be 
# used for mounting any file system not containing approved setuid files. 
# Executing setuid files from untrusted file systems, or file systems not 
# containing approved setuid files, increases the opportunity for 
# unprivileged users to attain unauthorized administrative access.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check /etc/mtab and verify the "nosuid" mount option is used on file 
# systems mounted from removable media, network shares, or any other file 
# system not containing approved setuid or setgid files. If any of these 
# files systems do not mount with the "nosuid" option, it is a finding.
#
# Fix Text: 
#
# Edit /etc/fstab and add the "nosuid" mount option to all file systems 
# mounted from removable media or network shares, and any file system not 
# containing approved setuid or setgid files.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002420
	
# Start-Lockdown

# This is full of unknowns.  So lets have an allow list and go from there.
# Anything that has a bin or sbin directory will be excluded by default.

EXCLUDE="/ /bin /sbin /usr /usr/bin /usr/sbin /usr/local /usr/local/bin /usr/local/sbin"

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
    egrep "$MOUNT.*nosuid" /etc/fstab > /dev/null
    if [ $? != 0 ]
    then
      MOUNT_OPTS=$( grep "$MOUNT" /etc/fstab | awk '{print $4}' )
      sed -i -e "s|\(${MOUNT}.*${MOUNT_OPTS}\)|\1,nosuid|g" /etc/fstab
    fi
  fi
done
