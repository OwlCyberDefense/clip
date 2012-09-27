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
# Group ID (Vulid): V-4321
# Group Title: GEN006060
# Rule ID: SV-37867r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN006060
# Rule Title: The system must not run Samba unless needed.
#
# Vulnerability Discussion: Samba is a tool used for the sharing of files 
# and printers between Windows and UNIX operating systems.  It provides 
# access to sensitive files and, therefore, poses a security risk if 
# compromised.
#
# Responsibility: System Administrator
# IAControls: DCPD-1, ECSC-1
#
# Check Content:
#
# Check the system for a running Samba server.

# Procedure:
# ps -ef |grep smbd

# If the Samba server is running, ask the SA if the Samba server is 
# operationally required. If it is not, this is a finding.


#
# Fix Text: 
#
# If there is no functional need for Samba and the daemon is running, 
# disable the daemon by killing the process ID as noted from the output of 
# ps -ef |grep smbd. The samba package should also be removed or not 
# installed if there is no functional requirement.

# Procedure:
# rpm -qa |grep samba

# This will show whether "samba" or "samba3x" is installed. To remove:

# rpm --erase samba
# or
# rpm --erase samba3x
  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006060
	
# Start-Lockdown

