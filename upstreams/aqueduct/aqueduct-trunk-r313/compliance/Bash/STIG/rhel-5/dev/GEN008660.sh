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
# Group ID (Vulid): V-4248
# Group Title: GEN008660
# Rule ID: SV-42186r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN008660
# Rule Title: For systems capable of using GRUB, the system must be 
# configured with GRUB as the default boot loader unless another boot 
# loader has been authorized, justified, and documented using site-defined 
# procedures.

#
# Vulnerability Discussion: GRUB is a versatile boot loader used by 
# several platforms that can provide authentication for access to the 
# system or boot loader.
#
# Responsibility: System Administrator
# IAControls: ECAR-1, ECAR-2, ECAR-3
#
# Check Content:
#
# Determine if the system uses the GRUB boot loader;

# ls -l /boot/grub/grub.conf

# If no grub.conf file exists, and the bootloader on the system has not 
# been authorized, justified, and documented, this is a finding.
#
# Fix Text: 
#
# Configure the system to use the GRUB bootloader or document, justify, 
# and authorize the alternate bootloader.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN008660
	
# Start-Lockdown

