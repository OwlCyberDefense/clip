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

##################### Fusion Technology LLC #############################
# By Shannon Mitchell                                                   #
# Fusion Technology LLC                                                 #
# Shannon[.]Mitchell[@]fusiontechnology-llc[.]com                       #
# www.fusiontechnology-llc.com                                          #
##################### Fusion Technology LLC #############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Shannon Mitchell   | 15-jul-2012|
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-11940
# Group Title: GEN000100
# Rule ID: SV-27049r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN000100
# Rule Title: The operating system must be a supported release.
#
# Vulnerability Discussion: An operating system release is considered 
# "supported" if the vendor continues to provide security patches for the 
# product.  With an unsupported release, it will not be possible to resolve 
# security issues discovered in the system software.
#
# Responsibility: System Administrator
# IAControls: VIVM-1
#
# Check Content:
#
# Check the version of the operating system.

# Example:
# cat /etc/redhat-release

# Vendor End-of-Support Information:
# Red Hat Enterprise 5: 31 Mar 2014

# Check with the vendor for additional information.

# If the version installed is not supported, this is a finding.
#
# Fix Text: 
#
# Upgrade to a supported version of the operating system.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000100
	
# Start-Lockdown

