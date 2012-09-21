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
# Group ID (Vulid): V-12028
# Group Title: GEN006560
# Rule ID: SV-37747r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN006560
# Rule Title: The system vulnerability assessment tool, host-based 
# intrusion detection tool, and file integrity tool must notify the SA and 
# the IAO of a security breach or a suspected security breach.
#
# Vulnerability Discussion: Timely notifications of potential security 
# compromises minimize the potential damage.

# Minimally, the system must log these events and the SA and the IAO will 
# receive the notifications during the daily system log review.  If 
# feasible, active alerting (such as e-mail or paging) should be employed 
# consistent with the site’s established operations management systems and 
# procedures.
#
# Responsibility: System Administrator
# IAControls: ECAT-1, ECAT-2
#
# Check Content:
#
# For each security tool on the system, determine if the tool is 
# configured to notify the IAO and SA of any detected security problem. If 
# such notifications are not configured, this is a finding.


#
# Fix Text: 
#
# Configure the security tools on the system to notify the IAO and SA 
# when any security issues are detected.   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006560
	
# Start-Lockdown

