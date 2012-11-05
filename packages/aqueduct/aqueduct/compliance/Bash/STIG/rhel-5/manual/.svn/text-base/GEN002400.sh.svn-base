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
# Group ID (Vulid): V-803
# Group Title: GEN002400
# Rule ID: SV-37592r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002400
# Rule Title: The system must be checked weekly for unauthorized setuid 
# files as well as unauthorized modification to authorized setuid files.
#
# Vulnerability Discussion: Files with the setuid bit set will allow 
# anyone running these files to be temporarily assigned the UID of the 
# file. While many system files depend on these attributes for proper 
# operation, security problems can result if setuid is assigned to programs 
# allowing reading and writing of files, or shell escapes.
#
# Responsibility: System Administrator
# IAControls: DCSL-1
#
# Check Content:
#
# Ask the SA for the weekly automated or manual process used to generate 
# a list of setuid files on the system and compare it with the prior list.  
# If no such process is in place, this is a finding.

# Review the process.  If the process does not identify and report changes 
# in setuid files, this is a finding.
#
# Fix Text: 
#
# Establish a weekly automated or manual process to generate a list of 
# suid files on the system and compare it with the prior list. To create a 
# list of suid files:
# find / -perm -4000 > suid-file-list  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002400
	
# Start-Lockdown

