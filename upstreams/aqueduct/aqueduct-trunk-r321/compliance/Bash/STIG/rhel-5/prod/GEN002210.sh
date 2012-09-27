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
# Group ID (Vulid): V-22365
# Group Title: GEN002210
# Rule ID: SV-37399r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002210
# Rule Title: All shell files must be group-owned by root, bin, sys, or 
# system.
#
# Vulnerability Discussion: If shell files are group-owned by users other 
# than root or a system group, they could be modified by intruders or 
# malicious users to perform unauthorized actions.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# If /etc/shells exists, check the group ownership of each shell 
# referenced.

# Procedure:
# cat /etc/shells | xargs -n1 ls -l

# Otherwise, check any shells found on the system.
# Procedure:
# find / -name "*sh" | xargs -n1 ls -l

# If a shell is not group-owned by root, bin, sys, or system, this is a 
# finding.
#
# Fix Text: 
#
# Change the group-owner of the shell to root, bin, sys, or system.

# Procedure:
# chgrp root <shell>     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002210
	
# Start-Lockdown

find $( cat /etc/shells ) ! -group root ! -group bin ! -group sys -exec chgrp root {} \; 2> /dev/null
