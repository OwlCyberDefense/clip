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
# Group ID (Vulid): V-22579
# Group Title: GEN008480
# Rule ID: SV-37982r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN008480
# Rule Title: The system must have USB Mass Storage disabled unless 
# needed.
#
# Vulnerability Discussion: USB is a common computer peripheral 
# interface. USB devices may include storage devices with the potential to 
# install malicious software on a system or exfiltrate data
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# If the system needs USB storage, this vulnerability is not applicable.
# Check if usb-storage is prevented from loading.
# grep 'install usb-storage /bin/true' /etc/modprobe.conf 
# /etc/modprobe.d/*
# If no results are returned, this is a finding.


#
# Fix Text: 
#
# Prevent the usb-storage module from loading.
# echo 'install usb-storage /bin/true' >> /etc/modprobe.conf     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN008480
	
# Start-Lockdown

