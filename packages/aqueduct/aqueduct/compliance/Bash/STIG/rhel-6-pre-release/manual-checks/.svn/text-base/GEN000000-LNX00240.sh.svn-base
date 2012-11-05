#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com )
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

#!/bin/bash

######################################################################
#By Shannon Mitchell                                                 #
#shannon.mitchell@fusiontechnology-llc.com                           #
######################################################################
#
#   - Created by shannon.mitchell@fusiontechnology-llc.com on 08-apr-2012.
# RHEL 6 has a default filesystem of ext4.  Modified the text for the manual
# check to reflect ext4 in place of ext3.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-1015
#Group Title: Journaling
#Rule ID: SV-1015r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000000-LNX00240
#Rule Title: The ext4 filesystem type must be used for the primary 
#Linux file system partitions.
#
#Vulnerability Discussion: The ext4 type is most suitable for securing 
#a Linux installation. It also offers the immutable and append only 
#file attributes which are most useful in protecting system logs and 
#other files. A file with the append only attribute may only be 
#modified by appending data to the end of the file. The immutable 
#attribute protects a file from being modified, deleted, or renamed. 
#In addition, links may not be created to the file.
#
#Responsibility: System Administrator
#IAControls: ECAR-1, ECAR-2, ECAR-3
#
#Check Content: 
#Perform the following to check for ext4 filesystems:
#
# more /etc/fstab
#
#If a local filesystem on a Linux platform is not using ext4, this 
#is a finding.
#
#Note: The CD, floppy drives, proc, swap, tmp, dev and sys 
#entries do not support ext4.
#
#
#Fix Text: Use the ext4 filesystem type for Linux partitions.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000000-LNX00240

#Start-Lockdown



