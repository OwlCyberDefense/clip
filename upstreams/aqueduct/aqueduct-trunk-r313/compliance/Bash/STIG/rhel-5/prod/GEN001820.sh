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
# Group ID (Vulid): V-11984
# Group Title: GEN001820
# Rule ID: SV-37300r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001820
# Rule Title: All skeleton files and directories (typically in /etc/skel) 
# must be owned by root or bin.
#
# Vulnerability Discussion: If the skeleton files are not protected, 
# unauthorized personnel could change user startup parameters and possibly 
# jeopardize user files.  Failure to give ownership of sensitive files or 
# utilities to root or bin provides the designated owner and unauthorized 
# users with the potential to access sensitive information or change the 
# system configuration which could weaken the system's security posture.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check skeleton files ownership.
# ls -alL /etc/skel
# If a skeleton file is not owned by root or bin, this is a finding.
#
# Fix Text: 
#
# Change the ownership of skeleton files with incorrect mode:
# chown root <skeleton file>
# or
# ls -L /etc/skel|xargs stat -L -c %U:%n|egrep -v "^(root|bin):"|cut -d: 
# -f2|chown root 
# will change all files not owned by root or bin to root.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001820
	
# Start-Lockdown

find /etc/skel/ ! -user root ! -user bin -exec chown root {} \;
