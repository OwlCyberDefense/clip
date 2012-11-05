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
# Group ID (Vulid): V-24384
# Group Title: GEN008050
# Rule ID: SV-37643r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN008050
# Rule Title: If the system is using LDAP for authentication or account 
# information, the /etc/ldap.conf file (or equivalent) must not contain 
# passwords.
#
# Vulnerability Discussion: The authentication of automated LDAP 
# connections between systems must not use passwords since more secure 
# methods are available, such as PKI and Kerberos. Additionally, the 
# storage of unencrypted passwords on the system is not permitted.
#
# Responsibility: System Administrator
# IAControls: IAIA-1, IAIA-2
#
# Check Content:
#
# Check for the "bindpw" option being used in the "/etc/ldap.conf" file.

# grep bindpw /etc/ldap.conf
# If an uncommented "bindpw" option is returned then a cleartext password 
# is in the file, this is a finding.


#
# Fix Text: 
#
# Edit the "/etc/ldap.conf" file to use anonymous binding by removing the 
# "bindpw" option.   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN008050
	
# Start-Lockdown

