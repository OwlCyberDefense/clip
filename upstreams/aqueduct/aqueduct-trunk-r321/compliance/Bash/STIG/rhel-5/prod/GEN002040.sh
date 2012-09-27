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
# Group ID (Vulid): V-11988
# Group Title: GEN002040
# Rule ID: SV-37370r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN002040
# Rule Title: There must be no .rhosts, .shosts, hosts.equiv, or 
# shosts.equiv files on the system.
#
# Vulnerability Discussion: The .rhosts, .shosts, hosts.equiv, and 
# shosts.equiv files are used to configure host-based authentication for 
# individual users or the system.  Host-based authentication is not 
# sufficient for preventing unauthorized access to the system.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# Check for the existence of the files.

# find / -name .rhosts
# find / -name .shosts
# find / -name hosts.equiv
# find / -name shosts.equiv

# If .rhosts, .shosts, hosts.equiv, or shosts.equiv are found and their use 
# has not been documented and approved by the IAO, this is a finding.
#
# Fix Text: 
#
# Remove all the r-commands access control files.

# Procedure:
# find / -name .rhosts -exec rm {} \;
# find / -name .shosts -exec rm {} \;
# find / -name hosts.equiv -exec rm {} \;
# find / -name shosts.equiv -exec rm {} \;  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002040
	
# Start-Lockdown

find / \( -fstype nfs -prune -o -name .rhosts -o -name  .shosts -o -name  hosts.equiv -o -name shosts.equiv \)  -exec rm -f {} \; 2> /dev/null
