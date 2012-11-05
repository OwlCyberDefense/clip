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
# Group ID (Vulid): V-4427
# Group Title: GEN002020
# Rule ID: SV-37437r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002020
# Rule Title: All .rhosts, .shosts, or host.equiv files must only contain 
# trusted host-user pairs.
#
# Vulnerability Discussion: If these files are not properly configured, 
# they could allow malicious access by unknown malicious users from 
# untrusted hosts who could compromise the system.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# Locate and examine all r-commands access control files.

# Procedure:
# find / -name .rhosts
# more /<directorylocation>/.rhosts

# find / -name .shosts
# more /<directorylocation>/.shosts

# find / -name hosts.equiv
# more /<directorylocation>/hosts.equiv

# find / -name shosts.equiv
# more /<directorylocation>/shosts.equiv

# If any .rhosts, .shosts, hosts.equiv, or shosts.equiv file contains other 
# than host-user pairs, this is a finding.
#
# Fix Text: 
#
# If possible, remove the .rhosts, .shosts, hosts.equiv, and shosts.equiv 
# files. If the files are required, remove any content from the files 
# except for necessary host-user pairs.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002020
	
# Start-Lockdown

# We are just going to remove these for the initial security run, but users
# may not want to run this if they are using the old rhosts.  If you are 
# still using these, you may want to look into using the secure ssh 
# alternatives.
find / \( -fstype nfs -prune -o -name '.rhosts' -o -name '.shosts' -o -name 'hosts.equiv' -o -name 'shosts.equiv' \) -exec rm -f {} \; 2>/dev/null


