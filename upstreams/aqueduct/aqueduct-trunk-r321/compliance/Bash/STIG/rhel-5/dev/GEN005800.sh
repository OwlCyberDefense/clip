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
# Group ID (Vulid): V-931
# Group Title: GEN005800
# Rule ID: SV-37849r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005800
# Rule Title: All Network File System (NFS) exported system files and 
# system directories must be owned by root.
#
# Vulnerability Discussion: Failure to give ownership of sensitive files 
# or directories  to root provides the designated owner and possible 
# unauthorized users with the potential to access sensitive information or 
# change system configuration which could weaken the system's security 
# posture.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check for NFS exported file systems.

# Procedure:
# cat /etc/exports
# For each file system displayed, check the ownership.

# ls -lLa <exported file system path>

# If the files and directories are not owned by root, this is a finding.
#
# Fix Text: 
#
# Change the ownership of exported file systems not owned by root.

# Procedure:
# chown root <path>     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005800
	
# Start-Lockdown

