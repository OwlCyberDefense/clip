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
# Group ID (Vulid): V-4428
# Group Title: GEN002060
# Rule ID: SV-37385r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002060
# Rule Title: All .rhosts, .shosts, .netrc, or hosts.equiv files must be 
# accessible by only root or the owner.
#
# Vulnerability Discussion: If these files are accessible by users other 
# than root or the owner, they could be used by a malicious user to set up 
# a system compromise.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# 
# Procedure:
# ls -l /etc/hosts.equiv

# ls -l /etc/ssh/shosts.equiv

# find / -name .rhosts
# ls -al <home directory>/.rhosts

# find / -name .shosts
# ls -al <home directory>/.shosts

# find / -name .netrc
# ls -al <home directory>/.netrc

# If the .rhosts, .shosts, hosts.equiv, or shosts.equiv files have 
# permissions greater than 600, then this is a finding.
# If the /etc/hosts.equiv, or /etc/ssh/shosts.equiv files are not owned by 
# root, this is a finding.

# Any .rhosts, .shosts and .netrc files outside of home directories have no 
# meaning and are not subject to this rule
# If the ~/.rhosts or ~/.shosts are not owned by the owner of the home 
# directory where they are immediately located or by root, this is a 
# finding.
#
# Fix Text: 
#
# Ensure the permission for these files is set to 600 or more restrictive 
# and their owner is root or the same as the owner of the home directory in 
# which they reside.

# Procedure:
# chmod 600 /etc/hosts.equiv
# chmod 600 /etc/ssh/shosts.equiv
# chown root /etc/hosts.equiv
# chown root /etc/ssh/shosts.equiv

# find / -name .rhosts
# chmod 600 /<home directory>/.rhosts
# chown <home directory owner> <home directory>/.rhosts

# find / -name .shosts
# chmod 600 <directory location>/.shosts
# chown <home directory owner> <home directory>/.shosts

# find / -name .netrc
# chmod 600 <directory location>/.netrc
# chown <home directory owner> <home directory>/.netrc  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002060
	
# Start-Lockdown

find / \( -fstype nfs -prune -o -name .rhosts -o -name  .shosts -o -name  hosts.equiv -o -name shosts.equiv \) -exec chmod 600 {} \; 2> /dev/null

