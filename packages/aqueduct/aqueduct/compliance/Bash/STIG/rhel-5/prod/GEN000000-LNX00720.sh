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
# Group ID (Vulid): V-22598
# Group Title: GEN000000-LNX00720
# Rule ID: SV-27001r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN000000-LNX00720
# Rule Title: Auditing must be enabled at boot by setting a kernel 
# parameter.
#
# Vulnerability Discussion: If auditing is enabled late in the boot 
# process, the actions of startup scripts may not be audited.  Some audit 
# systems also maintain state information only available if auditing is 
# enabled before a given process is created.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check for the audit=1 kernel parameter.
# grep 'audit=1' /proc/cmdline
# If no results are returned, this is a finding.
#
# Fix Text: 
#
# Edit the grub bootloader file /boot/grub/grub.conf or 
# /boot/grub/menu.lst by appending the "audit=1" parameter to the kernel 
# boot line.
# Reboot the system for the change to take effect.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000000-LNX00720
	
# Start-Lockdown

sed -i '/^[^#].*kernel/ {/audit/! s/.*/& audit=1/}' /boot/grub/grub.conf
