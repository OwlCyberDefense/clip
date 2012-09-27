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
# Group ID (Vulid): V-1058
# Group Title: GEN006180
# Rule ID: SV-41574r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN006180
# Rule Title: The smbpasswd file must be group-owned by root.
#
# Vulnerability Discussion: If the smbpasswd file is not group-owned by 
# root, the smbpasswd file may be maliciously accessed or modified, 
# potentially resulting in the compromise of Samba accounts.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check "smbpasswd" ownership:

# ls -lL /etc/samba/passdb.tdb /etc/samba/secrets.tdb

# If the "smbpasswd" file is not group-owned by root, this is a finding.
#
# Fix Text: 
#
# Use the chgrp command to ensure that the group owner of the smbpasswd 
# file is root.
 
# For instance:

# chgrp root /etc/samba/passdb.tdb /etc/samba/secrets.tdb  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006180
	
# Start-Lockdown

