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
# Group ID (Vulid): V-22500
# Group Title: GEN006230
# Rule ID: SV-37894r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN006230
# Rule Title: Samba must be configured to use encrypted passwords.
#
# Vulnerability Discussion: Samba must be configured to protect 
# authenticators.  If Samba passwords are not encrypted for storage, 
# plain-text user passwords may be read by those with access to the Samba 
# password file.
#
# Responsibility: System Administrator
# IAControls: IAIA-1, IAIA-2
#
# Check Content:
#
# Check the encryption setting of Samba.
# grep -i 'encrypt passwords' /etc/samba/smb.conf 
# If the setting is not present, or not set to 'yes', this is a finding.


#
# Fix Text: 
#
# Edit the "/etc/samba/smb.conf" file and change the "encrypt passwords" 
# setting to "yes".     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006230
	
# Start-Lockdown

