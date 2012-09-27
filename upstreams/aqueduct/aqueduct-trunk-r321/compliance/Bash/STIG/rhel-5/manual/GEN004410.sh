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
# Group ID (Vulid): V-22440
# Group Title: GEN004410
# Rule ID: SV-37493r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN004410
# Rule Title: Files executed through a mail aliases file must be 
# group-owned by root, bin, sys, or system, and must reside within a 
# directory group-owned by root, bin, sys, or system.
#
# Vulnerability Discussion: If a file executed through a mail aliases 
# file is not group-owned by root or a system group, it may be subject to 
# unauthorized modification.  Unauthorized modification of files executed 
# through aliases may allow unauthorized users to attain root privileges.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Examine the contents of the /etc/aliases file.

# Procedure:
# more /etc/aliases
# Examine the aliases file for any utilized directories or paths.

# ls -lL <file referenced from aliases>
# Check the permissions for any paths referenced. 
# If the group owner of any file is not root, bin, sys, or system, this is 
# a finding.


#
# Fix Text: 
#
# Change the group ownership of the file referenced from /etc/aliases.

# Procedure:
# chgrp root <file referenced from aliases>     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004410
	
# Start-Lockdown

