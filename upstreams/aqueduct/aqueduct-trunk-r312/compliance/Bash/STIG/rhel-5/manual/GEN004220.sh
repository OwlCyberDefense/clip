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
# Group ID (Vulid): V-4382
# Group Title: GEN004220
# Rule ID: SV-37469r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN004220
# Rule Title: Administrative accounts must not run a web browser, except 
# as needed for local service administration.
#
# Vulnerability Discussion: If a web browser flaw is exploited while 
# running as a privileged user, the entire system could be compromised.

# Specific exceptions for local service administration should be documented 
# in site-defined policy.  These exceptions may include HTTP(S)-based tools 
# used for the administration of the local system, services, or attached 
# devices.  Examples of possible exceptions are HP’s System Management 
# Homepage (SMH), the CUPS administrative interface, and Sun's StorageTek 
# Common Array Manager (CAM) when these services are running on the local 
# system.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Look in the root account home directory for a .mozilla directory. If 
# none exists, this is not a finding. If there is one, verify with the root 
# users and the IAO the intent of the browsing.  If the browsing is not 
# limited to authorized local services administration, this is a finding.
#
# Fix Text: 
#
# Enforce policy requiring administrative accounts use web browsers only 
# for local service administration.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004220
	
# Start-Lockdown

