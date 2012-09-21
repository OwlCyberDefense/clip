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
# Group ID (Vulid): V-783
# Group Title: GEN000120
# Rule ID: SV-27059r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000120
# Rule Title: Vendor-recommended software patches and updates, and system 
# security patches and updates, must be installed and up-to-date.
#
# Vulnerability Discussion: Timely patching is critical for maintaining 
# the operational availability, confidentiality, and integrity of 
# information technology (IT) systems.  However, failure to keep operating 
# system and application software patched is a common mistake made by IT 
# professionals. New patches are released daily, and it is often difficult 
# for even experienced system administrators to keep abreast of all the new 
# patches.  When new weaknesses in an operating system exist, patches are 
# usually made available by the vendor to resolve the problems.  If the 
# most recent recommended updates and security patches are not installed, 
# unauthorized users may take advantage of weaknesses present in the 
# unpatched software.  The lack of prompt attention to patching could 
# result in a system compromise.
#
# Responsibility: System Administrator
# IAControls: VIVM-1
#
# Check Content:
#
# Obtain the list of available package updates from Red Hat. Check the 
# available package updates have been installed on the system.

# Use the "rpm" command to list the packages installed on the system.
# Example:
# rpm -qa -last

# If updated packages are available and applicable to the system and have 
# not been installed, this is a finding.

# One source for the list of Red Hat updates is available at 
# https://access.redhat.com/security/updates/active/
#
# Fix Text: 
#
# Install the patches or updated packages available from the vendor.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000120
	
# Start-Lockdown

