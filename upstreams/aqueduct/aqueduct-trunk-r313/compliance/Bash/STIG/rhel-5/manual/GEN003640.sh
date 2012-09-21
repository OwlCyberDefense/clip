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
# Group ID (Vulid): V-4304
# Group Title: GEN003640
# Rule ID: SV-37398r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003640
# Rule Title: The root file system must employ journaling or another 
# mechanism ensuring file system consistency.
#
# Vulnerability Discussion: File system journaling, or logging, can allow 
# reconstruction of file system data after a system crash,  preserving the 
# integrity of data that may have otherwise been lost.  Journaling file 
# systems typically do not require consistency checks upon booting after a 
# crash, which can improve system availability.  Some file systems employ 
# other mechanisms to ensure consistency also satisfying this requirement.
#
# Responsibility: System Administrator
# IAControls: ECAR-1, ECAR-2, ECAR-3
#
# Check Content:
#
# Logging should be enabled for those types of file systems not turning 
# on logging by default. 

# Procedure:
# mount

# JFS, VXFS, HFS, XFS, reiserfs, EXT3 and EXT4 all turn logging on by 
# default and will not be a finding. The ZFS file system uses other 
# mechanisms to provide for file system consistency, and will not be a 
# finding. For other file systems types, if the root file system does not 
# support journaling this is a finding. If the 'nolog' option is set on the 
# root file system that does support journaling, this is a finding.


#
# Fix Text: 
#
# Implement file system journaling for the root file system, or use a 
# file system with other mechanisms to ensure file system consistency. If 
# the root file system supports journaling, enable it. If the file system 
# does not support journaling or another mechanism to ensure file system 
# consistency, a migration to a different file system will be necessary.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003640
	
# Start-Lockdown

