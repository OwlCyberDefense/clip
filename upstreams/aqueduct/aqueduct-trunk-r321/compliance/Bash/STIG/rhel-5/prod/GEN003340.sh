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
# Group ID (Vulid): V-987
# Group Title: GEN003340
# Rule ID: SV-37518r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003340
# Rule Title: The at.allow file must have mode 0600 or less permissive.
#
# Vulnerability Discussion: Permissions more permissive than 0600 (read, 
# write and execute for the owner) may allow unauthorized or malicious 
# access to the at.allow and/or at.deny files.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the mode of the at.allow file.
# ls -lL /etc/at.allow
# If the at.allow file has a mode more permissive than 0600, this is a 
# finding.
#
# Fix Text: 
#
# Change the mode of the at.allow file.
# chmod 0600 /etc/at.allow     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003340
	
# Start-Lockdown

if [ -e "/etc/at.allow" ]
then
  find /etc/at.allow -perm /7177 -exec chmod u-xs,g-rwxs,o-rwxt {} \;
fi