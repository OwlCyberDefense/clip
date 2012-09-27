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
# Group ID (Vulid): V-802
# Group Title: GEN002440
# Rule ID: SV-37628r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002440
# Rule Title: The owner, group-owner, mode, ACL and location of files 
# with the setgid bit set must be documented using site-defined procedures.
#
# Vulnerability Discussion: All files with the setgid bit set will allow 
# anyone running these files to be temporarily assigned the GID of the 
# file. While many system files depend on these attributes for proper 
# operation, security problems can result if setgid is assigned to programs 
# allowing reading and writing of files, or shell escapes.
#
# Responsibility: System Administrator
# IAControls: ECPA-1
#
# Check Content:
#
# List all setgid files on the system.
# Procedure:
# find / -perm -2000 -exec ls -l {} \; | more

# Note: Executing these commands may result in large listings of files; the 
# output may be redirected to a file for easier analysis.

# Ask the SA or IAO if files with the setgid bit set have been documented.  
# Documentation must include owner, group-owner, mode, ACL, and location.  
# If any undocumented file has its setgid bit set, this is a finding.
#
# Fix Text: 
#
# Document the files with the sgid bit set or unset the sgid bit on the 
# executable.    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002440
	
# Start-Lockdown

find / -perm -2000 -exec ls -lZd {} \; > /root/initial_sgid_bit_findings.log 2>/dev/null
