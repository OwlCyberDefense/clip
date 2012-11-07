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
# Group ID (Vulid): V-4368
# Group Title: GEN003480
# Rule ID: SV-37535r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003480
# Rule Title: The at.deny file must be owned by root, bin, or sys.
#
# Vulnerability Discussion: If the owner of the at.deny file is not set 
# to root, bin, or sys, unauthorized users could be allowed to view or edit 
# sensitive information contained within the file.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# # ls -lL /etc/at.deny
# If the at.deny file is not owned by root, sys, or bin, this is a finding.
#
# Fix Text: 
#
# Change the owner of the at.deny file.
# chown root /etc/at.deny     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003480
	
# Start-Lockdown

find /etc/at.deny ! -user root ! -user bin -exec chown root {} \; > /dev/null 2>&1
