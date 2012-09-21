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
# Group ID (Vulid): V-4397
# Group Title: GEN005560
# Rule ID: SV-37918r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005560
# Rule Title: The system must be configured with a default gateway for 
# IPv4 if the system uses IPv4, unless the system is a router.
#
# Vulnerability Discussion: If a system has no default gateway defined, 
# the system is at increased risk of man-in-the-middle, monitoring, and 
# Denial of Service attacks.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the system for an IPv4 default route. If the system is a VM host 
# and acts as a router solely for the benefit of its client systems, then 
# this rule is not applicable.

# Procedure:
# netstat -r |grep default

# If a default route is not defined, this is a finding.


#
# Fix Text: 
#
# Set a default gateway for IPv4.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005560
	
# Start-Lockdown

