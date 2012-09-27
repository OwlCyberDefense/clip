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
# Group ID (Vulid): V-834
# Group Title: GEN004420
# Rule ID: SV-37494r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN004420
# Rule Title: Files executed through a mail aliases file must have mode 
# 0755 or less permissive.
#
# Vulnerability Discussion: If a file executed through a mail aliases 
# file has permissions greater than 0755, it can be modified by an 
# unauthorized user and may contain malicious code or instructions 
# potentially compromising the system.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Examine the contents of the /etc/aliases file.

# Procedure:
# more /etc/aliases
# Examine the aliases file for any referenced programs, which are specified 
# with the pipe (|) symbol.

# ls -lL <file referenced from aliases>
# Check the permissions for any paths referenced. 
# If any file referenced from the aliases file has a mode more permissive 
# than 0755, this is a finding.

#
# Fix Text: 
#
# Use the chmod command to change the access permissions for files 
# executed from the alias file. 

# For example:
# chmod 0755 filename  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004420
	
# Start-Lockdown

