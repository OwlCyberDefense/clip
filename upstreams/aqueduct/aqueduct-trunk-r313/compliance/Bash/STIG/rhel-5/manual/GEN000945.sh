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
# Group ID (Vulid): V-22310
# Group Title: GEN000945
# Rule ID: SV-37363r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000945
# Rule Title: The root account's library search path must be the system 
# default and must contain only absolute paths.
#
# Vulnerability Discussion: The library search path environment 
# variable(s) contain a list of directories for the dynamic linker to 
# search to find libraries.  If this path includes the current working 
# directory or other relative paths, libraries in these directories may be 
# loaded instead of system libraries.  This variable is formatted as a 
# colon-separated list of directories.  If there is an empty entry, such as 
# a leading or trailing colon or two consecutive colons, this is 
# interpreted as the current working directory.  Entries starting with a 
# slash (/) are absolute paths.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the LD_LIBRARY_PATH environment variable is empty or not defined 
# for the root user.
# echo $LD_LIBRARY_PATH
# If a path list is returned, this is a finding.
#
# Fix Text: 
#
# Edit the root user initialization files and remove any definition of 
# LD_LIBRARY_PATH.   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000945
	
# Start-Lockdown

#Off my default.  If this is set, someone did it for a reason.  Which means THEY can fix it or POA&M it. 

