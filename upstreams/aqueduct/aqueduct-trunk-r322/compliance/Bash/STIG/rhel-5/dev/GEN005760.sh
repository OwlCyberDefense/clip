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
# Group ID (Vulid): V-929
# Group Title: GEN005760
# Rule ID: SV-37943r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN005760
# Rule Title: The Network File System (NFS) export configuration file 
# must have mode 0644 or less permissive.
#
# Vulnerability Discussion: Excessive permissions on the NFS export 
# configuration file could allow unauthorized modification of the file, 
# which could result in Denial of Service to authorized NFS exports and the 
# creation of additional unauthorized exports.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2, ECLP-1
#
# Check Content:
#
# # ls -lL /etc/exports
# If the file has a mode more permissive than 0644, this is a finding.


#
# Fix Text: 
#
# # chmod 0644 /etc/exports     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005760
	
# Start-Lockdown

