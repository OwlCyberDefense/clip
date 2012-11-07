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
# Group ID (Vulid): V-23953
# Group Title: GEN007960
# Rule ID: SV-37621r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN007960
# Rule Title: The 'ldd' command must be disabled unless it protects 
# against the execution of untrusted files.
#
# Vulnerability Discussion: The 'ldd' command provides a list of 
# dependent libraries needed by a given binary, which is useful for 
# troubleshooting software.  Instead of parsing the binary file, some 'ldd' 
# implementations invoke the program with a special environment variable 
# set, which causes the system dynamic linker to display the list of 
# libraries.  Specially crafted binaries can specify an alternate dynamic 
# linker which may cause a program to be executed instead of examined.  If 
# the program is from an untrusted source, such as in a user home 
# directory, or a file suspected of involvement in a system compromise, 
# unauthorized software may be executed with the rights of the user running 
# 'ldd'.  

# Some 'ldd' implementations include protections that prevent the execution 
# of untrusted files.  If such protections exist, this requirement is not 
# applicable.

# An acceptable method of disabling 'ldd' is changing its mode to 0000.  
# The SA may conduct troubleshooting by temporarily changing the mode to 
# allow execution and running the 'ldd' command as an unprivileged user 
# upon trusted system binaries.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the system for the 'ldd' executable.

# Procedure:
# ls -lL /usr/bin/ldd

# If the returned line is set to "yes", this is a finding.

#
# Fix Text: 
#
# Remove the execute permissions from the 'ldd' executable.

# Procedure:
# chmod a-x /usr/bin/ldd     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN007960
	
# Start-Lockdown

