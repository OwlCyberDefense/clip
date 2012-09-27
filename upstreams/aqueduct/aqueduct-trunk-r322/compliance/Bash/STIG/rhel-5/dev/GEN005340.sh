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
# Group ID (Vulid): V-995
# Group Title: GEN005340
# Rule ID: SV-37698r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005340
# Rule Title: Management Information Base (MIB) files must have mode 0640 
# or less permissive.
#
# Vulnerability Discussion: The ability to read the MIB file could impart 
# special knowledge to an intruder or malicious user about the ability to 
# extract compromising information about the system or network.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the modes for all Management Information Base (MIB) files on the 
# system.

# Procedure:
# find / -name *.mib 
# ls -lL <mib file>

# Any file returned with a mode 0640 or less permissive is a finding.
#
# Fix Text: 
#
# Change the mode of MIB files to 0640.

# Procedure:
# chmod 0640 <mib file>  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005340
	
# Start-Lockdown

