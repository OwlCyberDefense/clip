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
# Group ID (Vulid): V-12014
# Group Title: GEN005180
# Rule ID: SV-37679r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005180
# Rule Title: All .Xauthority files must have mode 0600 or less 
# permissive.
#
# Vulnerability Discussion: .Xauthority files ensure the user is 
# authorized to access specific X Windows host. Excessive permissions may 
# permit unauthorized modification of these files, which could lead to 
# Denial of Service to authorized access or allow unauthorized access to be 
# obtained.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the file permissions for the .Xauthority files.

# Procedure:
# ls -la |egrep "(\.Xauthority|\.xauth)"

# If the file mode is more permissive than 0600, this is finding.


#
# Fix Text: 
#
# Change the mode of the .Xauthority files.

# Procedure:
# chmod 0600 .Xauthority     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005180
	
# Start-Lockdown

find / -name *.xauth -o -name *.Xauthority -perm /7177 -exec chmod u-xs,g-rwxs,o-rwxt {} \;
