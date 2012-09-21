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
# Group ID (Vulid): V-782
# Group Title: GEN006480
# Rule ID: SV-37746r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN006480
# Rule Title: The system must have a host-based intrusion detection tool 
# installed.
#
# Vulnerability Discussion: Without a host-based intrusion detection 
# tool, there is no system-level defense when an intruder gains access to a 
# system or network.  Additionally, a host-based intrusion detection tool 
# can provide methods to immediately lock out detected intrusion attempts.
#
# Responsibility: System Administrator
# IAControls: ECID-1
#
# Check Content:
#
# Ask the SA or IAO if a host-based intrusion detection application is 
# loaded on the system. The preferred intrusion detection system is McAfee 
# HBSS available through Cybercom. 

# Procedure:
# Examine the system to see if the Host Intrusion Prevention System (HIPS) 
# is installed

#rpm -qa | grep MFEhiplsm

# If the MFEhiplsm package is installed, HBSS is being used on the system.

# If another host-based intrusion detection system is loaded on the system

# find / -name <daemon name> 

# Where <daemon name> is the name of the primary application daemon to 
# determine if the application is loaded on the system. 

# Determine if the application is active on the system.

# Procedure:
# ps -ef | grep <daemon name> 

# If no host-based intrusion detection system is installed on the system, 
# this is a finding.


#
# Fix Text: 
#
# Install a host-based intrusion detection tool.
  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006480
	
# Start-Lockdown

