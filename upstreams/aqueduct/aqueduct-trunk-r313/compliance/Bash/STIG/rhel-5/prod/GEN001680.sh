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
# Group ID (Vulid): V-4090
# Group Title: GEN001680
# Rule ID: SV-37269r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001680
# Rule Title: All system start-up files must be group-owned by root, sys, 
# bin, other, or system.
#
# Vulnerability Discussion: If system start-up files do not have a group 
# owner of root or a system group, the files may be modified by malicious 
# users or intruders.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check run control scripts' group ownership.

# Procedure:
# ls -lL /etc/rc* /etc/init.d

# Alternatively:
# find /etc -name "[SK][0-9]*"|xargs stat -L -c %G:%n|egrep -v 
# "^(root|sys|bin|other):"
# If any run control script is not group-owned by root, sys, bin, or other 
# system groups, this is a finding.
#
# Fix Text: 
#
# Change the group ownership of the run control script(s) with incorrect 
# group ownership.

# Procedure:
# chgrp root <run control script>
# find /etc -name "[SK][0-9]*"|xargs stat -L -c %G:%n|egrep -v 
# "^(root|sys|bin|other):"|cut -d: -f2|xargs chgrp root   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001680
	
# Start-Lockdown

find /etc/rc* /etc/init.d /etc/init -not -group root -not -group bin -not -group sys -exec chgrp root {} \; 2>/dev/nll

