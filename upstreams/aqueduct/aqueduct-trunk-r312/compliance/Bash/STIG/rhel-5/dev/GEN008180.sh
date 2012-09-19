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
# Group ID (Vulid): V-22565
# Group Title: GEN008180
# Rule ID: SV-37962r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN008180
# Rule Title: If the system is using LDAP for authentication or account 
# information, the TLS certificate authority file and/or directory (as 
# appropriate) must have mode 0644 (0755 for directories) or less 
# permissive.
#
# Vulnerability Discussion: LDAP can be used to provide user 
# authentication and account information, which are vital to system 
# security.  The LDAP client configuration must be protected from 
# unauthorized modification.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Determine the certificate authority file and/or directory.

# Procedure:
# grep -i '^tls_cacert' /etc/ldap.conf
# For each file or directory returned, check the permissions.

# Procedure:
# ls -lLd <certpath>

# If the mode of the file is more permissive than 0644 (or 0755 for 
# directories), this is a finding.


#
# Fix Text: 
#
# Change the mode of the file or directory.

# File Procedure:
# chmod 0644 <certpath> 

# Directory Procedure:
# chmod 0755 <certpath>     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN008180
	
# Start-Lockdown

