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
# Group ID (Vulid): V-12030
# Group Title: GEN006620
# Rule ID: SV-37758r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN006620
# Rule Title: The system's access control program must be configured to 
# grant or deny system access to specific hosts.
#
# Vulnerability Discussion: If the system's access control program is not 
# configured with appropriate rules for allowing and denying access to 
# system network resources, services may be accessible to unauthorized 
# hosts.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2, ECSC-1
#
# Check Content:
#
# Check for the existence of the "/etc/hosts.allow" and "/etc/hosts.deny" 
# files.

# Procedure:
# ls -la /etc/hosts.allow
# ls -la /etc/hosts.deny

# If either file does not exist, this is a finding.

# Check for the presence of a "default deny" entry.

# Procedure:
# grep "ALL: ALL" /etc/hosts.deny

# If the "ALL: ALL" entry is not present the "/etc/hosts.deny" file, any 
# TCP service from a host or network not matching other rules will be 
# allowed access. If the entry is not in "/etc/hosts.deny", this is a 
# finding.


#
# Fix Text: 
#
# Edit the "/etc/hosts.all" and "/etc/hosts.deny" files to configure 
# access restrictions.
  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006620
	
# Start-Lockdown

