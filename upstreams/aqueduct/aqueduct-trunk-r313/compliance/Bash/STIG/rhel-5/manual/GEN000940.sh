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
# Group ID (Vulid): V-776
# Group Title: GEN000940
# Rule ID: SV-37360r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000940
# Rule Title: The root account's executable search path must be the 
# vendor default and must contain only absolute paths.
#
# Vulnerability Discussion: The executable search path (typically the 
# PATH environment variable) contains a list of directories for the shell 
# to search to find executables.  If this path includes the current working 
# directory or other relative paths, executables in these directories may 
# be executed instead of system commands.  This variable is formatted as a 
# colon-separated list of directories.  If there is an empty entry, such as 
# a leading or trailing colon or two consecutive colons, this is 
# interpreted as the current working directory.  Entries starting with a 
# slash (/) are absolute paths.

#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2, ECSC-1
#
# Check Content:
#
# To view the root user's PATH, log in as the root user, and execute:
# env | grep PATH

# This variable is formatted as a colon-separated list of directories. If 
# there is an empty entry, such as a leading or trailing colon, or two 
# consecutive colons, this is a finding. If an entry starts with a 
# character other than a slash (/), this is a finding. If directories 
# beyond those in the vendor's default root path are present. This is a 
# finding.
#
# Fix Text: 
#
# Edit the root user's local initialization files ~/.profile,~/.bashrc 
# (assuming root shell is bash). Change any found PATH variable settings to 
# the vendor's default path for the root user. Remove any empty path 
# entries or references to relative paths.    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000940
	
# Start-Lockdown

