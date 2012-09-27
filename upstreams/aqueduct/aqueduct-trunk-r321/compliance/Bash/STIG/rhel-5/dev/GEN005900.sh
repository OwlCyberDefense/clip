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
# Group ID (Vulid): V-936
# Group Title: GEN005900
# Rule ID: SV-37860r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005900
# Rule Title: The "nosuid" option must be enabled on all Network File 
# System (NFS) client mounts.
#
# Vulnerability Discussion: Enabling the nosuid mount option prevents the 
# system from granting owner or group-owner privileges to programs with the 
# suid or sgid bit set.  If the system does not restrict this access, users 
# with unprivileged access to the local system may be able to acquire 
# privileged access by executing suid or sgid files located on the mounted 
# NFS file system.
#
# Responsibility: Information Assurance Officer
# IAControls: ECPA-1
#
# Check Content:
#
# Check the system for NFS mounts not using the "nosuid" option.

# Procedure:
# mount -v | grep " type nfs " | egrep -v "nosuid"

# If the mounted file systems do not have the "nosuid" option, this is a 
# finding.


#
# Fix Text: 
#
# Edit "/etc/fstab" and add the "nosuid" option for all NFS file systems. 
# Remount the NFS file systems to make the change take effect.    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005900
	
# Start-Lockdown

