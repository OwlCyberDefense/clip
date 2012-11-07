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
# Group ID (Vulid): V-4702
# Group Title: GEN004840
# Rule ID: SV-37528r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN004840
# Rule Title: If the system is an anonymous FTP server, it must be 
# isolated to the DMZ network.
#
# Vulnerability Discussion: Anonymous FTP is a public data service which 
# is only permitted in a server capacity when located on the DMZ network.
#
# Responsibility: System Administrator
# IAControls: EBBD-1, EBBD-2, EBBD-3, ECSC-1
#
# Check Content:
#
# Use the command "ftp" to connect the system's FTP service. Attempt to 
# log into this host with a user name of anonymous and a password of guest 
# (also try the password of guest@mail.com). If the logon is not 
# successful, this check is Not Applicable.

# Ask the SA if the system is located on a DMZ network. If the system is 
# not located on a DMZ network, this is a finding.


#
# Fix Text: 
#
# Remove anonymous ftp capability or move the system to a DMZ network.    
 
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004840
	
# Start-Lockdown

