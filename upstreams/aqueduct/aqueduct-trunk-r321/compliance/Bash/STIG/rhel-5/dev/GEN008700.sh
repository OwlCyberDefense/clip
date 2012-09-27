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
# Group ID (Vulid): V-4249
# Group Title: GEN008700
# Rule ID: SV-37933r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN008700
# Rule Title: The system boot loader must require authentication.
#
# Vulnerability Discussion: If the system's boot loader does not require 
# authentication, users with console access to the system may be able to 
# alter the system boot configuration or boot the system into single user 
# or maintenance mode, which could result in Denial of Service or 
# unauthorized privileged access to the system.
#
# Responsibility: System Administrator
# IAControls: IAIA-1, IAIA-2
#
# Check Content:
#
# Check the "/boot/grub/grub.conf" or "/boot/grub/menu.lst" files.
# more /boot/grub/menu.lst

# Check for a password configuration line, such as:
# password --md5 <password-hash>

# This line should be just below the line beginning with "timeout". Please 
# note <password-hash> will be replaced by the actual MD5 encrypted 
# password. If the password line is not in either of the files, this is a 
# finding.

# For any bootloader other than GRUB which has been authorized, justified 
# and documented for use on the system refer to the vendor documentation on 
# password support. If the bootloader does not support encrypted passwords, 
# this is a finding.
#
# Fix Text: 
#
# The GRUB console boot loader can be configured to use an MD5 encrypted 
# password by adding password --md5 password-hash to the 
# "/boot/grub/grub.conf" file. Use "/sbin/grub-md5-crypt" to generate MD5 
# passwords from the command line.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN008700
	
# Start-Lockdown

