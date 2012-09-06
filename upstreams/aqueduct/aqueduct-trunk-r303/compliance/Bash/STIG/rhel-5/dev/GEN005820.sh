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
# Group ID (Vulid): V-932
# Group Title: GEN005820
# Rule ID: SV-37854r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005820
# Rule Title: The Network File System (NFS) anonymous UID and GID must be 
# configured to values without permissions.
#
# Vulnerability Discussion: When an NFS server is configured to deny 
# remote root access, a selected UID and GID are used to handle requests 
# from the remote root user.  The UID and GID should be chosen from the 
# system to provide the appropriate level of non-privileged access.
#
# Responsibility: System Administrator
# IAControls: ECSC-1, IAIA-1, IAIA-2
#
# Check Content:
#
# Check if the 'anonuid' and 'anongid' options are set correctly for 
# exported file systems.
# List exported filesystems:
# exportfs -v 

# Each of the exported file systems should include an entry for the 
# 'anonuid=' and 'anongid=' options set to "-1" or an equivalent (60001, 
# 65534, or 65535). If appropriate values for 'anonuid' or 'anongid' are 
# not set, this is a finding.
#
# Fix Text: 
#
# Edit "/etc/exports" and set the "anonuid=-1" and "anongid=-1" options 
# for exports lacking it. Re-export the filesystems.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005820
	
# Start-Lockdown

