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
# Group ID (Vulid): V-12016
# Group Title: GEN005220
# Rule ID: SV-37684r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005220
# Rule Title: .Xauthority or X*.hosts (or equivalent) file(s) must be 
# used to restrict access to the X server.
#
# Vulnerability Discussion: If access to the X server is not restricted, 
# a user's X session may be compromised.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# Determine if the X server is running.
# Procedure:
# ps -ef |grep X

# Determine if xauth is being used.
# Procedure:
# xauth
# xauth> list

# If the above command sequence does not show any host other than the 
# localhost, then xauth is not being used.

# Search the system for an X*.hosts file, where "*" is a display number 
# used to limit X window connections. If no files are found, X*.hosts files 
# are not being used. If the X*.hosts files contain any unauthorized hosts, 
# this is a finding.

# If both xauth and X*.hosts files are not being used, this is a finding.
#
# Fix Text: 
#
# Create an X*.hosts file, where "*" is a display number used to limit X 
# window connections. Add the list of authorized X clients to the file.    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005220
	
# Start-Lockdown

