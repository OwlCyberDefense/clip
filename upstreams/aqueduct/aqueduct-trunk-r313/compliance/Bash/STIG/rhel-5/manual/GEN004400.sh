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
# Group ID (Vulid): V-833
# Group Title: GEN004400
# Rule ID: SV-37491r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN004400
# Rule Title: Files executed through a mail aliases file must be owned by 
# root and must reside within a directory owned and writable only by root.
#
# Vulnerability Discussion: If a file executed through a mail aliases 
# file is not owned and writable only by root, it may be subject to 
# unauthorized modification.  Unauthorized modification of files executed 
# through aliases may allow unauthorized users to attain root privileges.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Verify the ownership of files referenced within the sendmail aliases 
# file.

# Procedure:
# more /etc/aliases
# Examine the aliases file for any utilized directories or paths.

# ls -lL <directory or file path>
# Check the owner for any paths referenced. 
# Check if the file or parent directory is owned by root. If not, this is a 
# finding.


#
# Fix Text: 
#
# Edit the /etc/aliases file (alternatively, /usr/lib/sendmail.cf). 
# Locate the entries executing a program. They will appear similar to the 
# following line:

# Aliasname: : /usr/local/bin/ls (or some other program name)

# Ensure root owns the programs and the directory(ies) they reside in by 
# using the chown command to change owner to root.
# Procedure:
# chown root <file or directory name>     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004400
	
# Start-Lockdown

