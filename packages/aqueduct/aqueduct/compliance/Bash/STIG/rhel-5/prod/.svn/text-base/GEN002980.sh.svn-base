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
# Group ID (Vulid): V-975
# Group Title: GEN002980
# Rule ID: SV-27326r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002980
# Rule Title: The cron.allow file must have mode 0600 or less permissive.
#
# Vulnerability Discussion: A readable and/or writable cron.allow file by 
# users other than root could allow potential intruders and malicious users 
# to use the file contents to help discern information, such as who is 
# allowed to execute cron programs, which could be harmful to overall 
# system and network security.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check mode of the cron.allow file.

# Procedure:
# ls -lL /etc/cron.allow

# If the file has a mode more permissive than 0600, this is a finding.
#
# Fix Text: 
#
# Change the mode of the cron.allow file to 0600.

# Procedure:
# chmod 0600 /etc/cron.allow  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002980
	
# Start-Lockdown
find /etc/cron.allow -perm /7177 -exec chmod u-xs,g-rwxs,o-rwxt {} \;
