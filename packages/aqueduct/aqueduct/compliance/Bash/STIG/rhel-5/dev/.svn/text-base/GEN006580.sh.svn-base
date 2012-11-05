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
# Group ID (Vulid): V-940
# Group Title: GEN006580
# Rule ID: SV-37756r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN006580
# Rule Title: The system must use an access control program.
#
# Vulnerability Discussion: Access control programs (such as 
# TCP_WRAPPERS) provide the ability to enhance system security posture.
#
# Responsibility: System Administrator
# IAControls: EBRU-1
#
# Check Content:
#
# The tcp_wrappers package is provided with the RHEL distribution. Other 
# access control programs may be available but will need to be checked 
# manually. 

# Determine if tcp_wrappers is installed.
# rpm -qa | grep tcp_wrappers
# If no package is listed, this is a finding.


#
# Fix Text: 
#
# Install and configure the tcp_wrappers package.    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006580
	
# Start-Lockdown

