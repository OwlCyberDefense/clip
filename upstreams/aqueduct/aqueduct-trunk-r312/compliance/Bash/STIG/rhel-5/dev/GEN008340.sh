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
# Group ID (Vulid): V-22573
# Group Title: GEN008340
# Rule ID: SV-37973r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN008340
# Rule Title: If the system is using LDAP for authentication or account 
# information, the LDAP TLS key file must have mode 0600 or less permissive.
#
# Vulnerability Discussion: LDAP can be used to provide user 
# authentication and account information, which are vital to system 
# security.  The LDAP client configuration must be protected from 
# unauthorized modification.

# Note:  Depending on the particular implementation, group and other read 
# permission may be necessary for unprivileged users to successfully 
# resolve account information using LDAP.  This will still be a finding, as 
# these permissions provide users with access to system authenticators.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Determine the key file.
# grep -i '^tls_key' /etc/ldap.conf
# Check the permissions.
# ls -lL <keypath>
# If the mode of the file is more permissive than 0600, this is a finding.


#
# Fix Text: 
#
# Change the mode of the file.
# chmod 0600 <keypath>   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN008340
	
# Start-Lockdown

