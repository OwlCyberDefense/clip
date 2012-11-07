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
# Group ID (Vulid): V-1062
# Group Title: GEN001080
# Rule ID: SV-37380r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN001080
# Rule Title: The root shell must be located in the / file system.

#
# Vulnerability Discussion: To ensure the root shell is available in 
# repair and administrative modes, the root shell must be located in the / 
# file system.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Determine if roots shell executable resides on a dedicated file system.

# Procedure:
# Find the location of the root users shell

# grep "^root" /etc/passwd|cut -d: -f7|cut -d/ -f2

# The result is the top level directory under / where the shell resides 
# (ie. usr)
# Check if it is on a dedicated file system.

# grep /<top level directory> /etc/fstab

# If /<top level directory> is on a dedicated file system, this is a 
# finding.
#
# Fix Text: 
#
# Change the root account's shell to one present on the / file system. 

# Procedure:
# Edit /etc/passwd and change the shell for the root account to one present 
# on the / file system (such as /bin/sh, assuming /bin is not on a separate 
# file system). If the system does not store shell configuration in the 
# /etc/passwd file, consult vendor documentation for the correct procedure 
# for the system.    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001080
	
# Start-Lockdown

