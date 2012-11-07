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
# Group ID (Vulid): V-24624
# Group Title: GEN008710
# Rule ID: SV-37938r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN008710
# Rule Title: The system boot loader must protect passwords using an MD5 
# or stronger cryptographic hash.
#
# Vulnerability Discussion: If system boot loader passwords are 
# compromised, users with console access to the system may be able to alter 
# the system boot configuration or boot the system into single user or 
# maintenance mode, which could result in Denial of Service or unauthorized 
# privileged access to the system.
#
# Responsibility: System Administrator
# IAControls: IAIA-1, IAIA-2
#
# Check Content:
#
# Check GRUB for password configuration.

# Procedure:
# Check the /boot/grub/grub.conf or /boot/grub/menu.lst files.
# grep "password" /boot/grub/grub.conf /boot/grub/menu.lst

# Check for a password configuration line, such as:
# password --md5 <password-hash>

# If the boot loader passwords are not protected using an MD5 hash or 
# stronger, this is a finding.
#
# Fix Text: 
#
# Consult vendor documentation for procedures concerning the system's 
# boot loader.  Configure the boot loader to hash boot loader passwords 
# using MD5 or a stronger hash.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN008710
	
# Start-Lockdown

