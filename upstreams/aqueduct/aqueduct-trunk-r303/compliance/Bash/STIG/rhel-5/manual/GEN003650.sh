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

###################### Fotis Networks LLC ###############################
# By Vincent C. Passaro                                                 #
# Fotis Networks LLC	                                                #
# Vincent[.]Passaro[@]fotisnetworks[.]com                               #
# www.fotisnetworks.com	                                                #
###################### Fotis Networks LLC ###############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Vincent C. Passaro | 1-Aug-2012 |
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-22422
# Group Title: GEN003650
# Rule ID: SV-37401r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN003650
# Rule Title: All local file systems must employ journaling or another 
# mechanism ensuring file system consistency.
#
# Vulnerability Discussion: File system journaling, or logging, can allow 
# reconstruction of file system data after a system crash preserving the 
# integrity of data that may have otherwise been lost.  Journaling file 
# systems typically do not require consistency checks upon booting after a 
# crash, which can improve system availability.  Some file systems employ 
# other mechanisms to ensure consistency also satisfying this requirement.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Verify local filesystems use journaling.
# mount | grep '^/dev/' | egrep -v 'type 
# (ext3|ext4|jfs|reiserfs|xfs|iso9660|udf)'
# If a mount is listed, this is a finding.


#
# Fix Text: 
#
# Convert local file systems to use journaling or another mechanism 
# ensuring file system consistency.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003650
	
# Start-Lockdown

