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
# Group ID (Vulid): V-925
# Group Title: GEN002300
# Rule ID: SV-37558r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002300
# Rule Title: Device files used for backup must only be readable and/or 
# writable by root or the backup user.
#
# Vulnerability Discussion: System backups could be accidentally or 
# maliciously overwritten and destroy the ability to recover the system if 
# a compromise should occur.  Unauthorized users could also copy system 
# files.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# Check the system for world-writable device files.

# Procedure:
# find / -perm -2 -a \( -type b -o -type c \) -exec ls -ld {} \;

# Ask the SA to identify any device files used for backup purposes.

# If any device file(s) used for backup are writable by users other than 
# root or the designated backup user, this is a finding.
#
# Fix Text: 
#
# Use the chmod command to remove the world-writable bit from the backup 
# device files. 

# Procedure:
# chmod o-w <back device filename>

# Document all changes.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002300
	
# Start-Lockdown

# Pretty much any device that can be written to can be some sort of a backup 
# device, so lets start out with the tape device section in the udev rules.
# I've just copied the section from the 50-udev.rules default ruleset and 
# placed them in a lower numbered file to override the defaults.
#
#
# I have removed write from the disk group and added the owner entry as
# root just in case.

# Note: This needs tested on RHEL6 to make sure it overrides the rules
# in /lib/udev/rules.d the same way.

if [ ! -e "/etc/udev/rules.d/10-GEN002300.rules" ]
then

    cat << EOF > /etc/udev/rules.d/10-GEN002300.rules
# tape devices
SUBSYSTEM=="ide", SYSFS{media}=="tape", ACTION=="add", \
                RUN+="modprobe $env{UDEV_MODPROBE_DBG} ide-scsi idescsi_nocd=1"
KERNEL=="ht*",                  OWNER=root, GROUP="disk", MODE="0640"
KERNEL=="nht*",                 OWNER=root, GROUP="disk", MODE="0640"
KERNEL=="pt[0-9]*",             OWNER=root, GROUP="disk", MODE="0640"
KERNEL=="npt*",                 OWNER=root, GROUP="disk", MODE="0640"
KERNEL=="st*",                  OWNER=root, GROUP="disk", MODE="0640"
KERNEL=="nst*",                 OWNER=root, GROUP="disk", MODE="0640"
KERNEL=="osst*",                OWNER=root, GROUP="disk", MODE="0640"
KERNEL=="nosst*",               OWNER=root, GROUP="disk", MODE="0640"

EOF

  chown root:root /etc/udev/rules.d/10-GEN002300.rules
  chmod 644 /etc/udev/rules.d/10-GEN002300.rules
  chcon system_u:object_r:etc_t /etc/udev/rules.d/10-GEN002300.rules
fi

