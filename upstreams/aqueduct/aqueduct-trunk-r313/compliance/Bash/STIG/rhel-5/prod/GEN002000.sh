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
# Group ID (Vulid): V-913
# Group Title: GEN002000
# Rule ID: SV-37436r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002000
# Rule Title: There must be no .netrc files on the system.

#
# Vulnerability Discussion: Unencrypted passwords for remote FTP servers 
# may be stored in .netrc files. Policy requires passwords be encrypted in 
# storage and not used in access scripts.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2, IAIA-1, IAIA-2
#
# Check Content:
#
# Check the system for the existence of any .netrc files.

# Procedure:
# find / -name .netrc

# If any .netrc file exists, this is a finding.
#
# Fix Text: 
#
# Remove the .netrc file(s).

# Procedure:
# find / -name .netrc
# rm <.netrc file>     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002000
	
# Start-Lockdown

find / -fstype nfs -prune -o -name .netrc -exec rm -f {} \; 2> /dev/null

