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
# Group ID (Vulid): V-923
# Group Title: GEN002260
# Rule ID: SV-37543r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN002260
# Rule Title: The system must be checked for extraneous device files at 
# least weekly.
#
# Vulnerability Discussion: If an unauthorized device is allowed to exist 
# on the system, there is the possibility the system may perform 
# unauthorized operations.
#
# Responsibility: Information Assurance Officer
# IAControls: DCSW-1, ECSC-1
#
# Check Content:
#
# Ask the SA for the automated or manual process used to check for 
# extraneous device files.  

# Review the process to determine if the system is checked for extraneous 
# device files on a weekly basis.  If no weekly automated or manual process 
# is in place, this is a finding.  If the process is not identifying 
# extraneous device files, this is a finding.
#
# Fix Text: 
#
# Establish a weekly automated or manual process to create a list of 
# device files on the system and determine if any files have been added, 
# moved, or deleted since the last list was generated. A list of device 
# files can be generated with this command:
# find / -type b -o -type c > device-file-list  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002260
	
# Start-Lockdown

