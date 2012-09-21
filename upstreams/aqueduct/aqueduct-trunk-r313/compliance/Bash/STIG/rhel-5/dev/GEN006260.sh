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
# Group ID (Vulid): V-4273
# Group Title: GEN006260
# Rule ID: SV-37901r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN006260
# Rule Title: The /etc/news/incoming.conf (or equivalent) must have mode 
# 0600 or less permissive.
#
# Vulnerability Discussion: Excessive permissions on the "incoming.conf" 
# file may allow unauthorized modification which could lead to 
# Denial-of-Service to authorized users or provide access to unauthorized 
# users.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# RHEL uses the InternetNewsDaemon (innd) news server. The file 
# corresponding to "/etc/news/hosts.nntp" is "/etc/news/incoming.conf". 
# Check the permissions for "/etc/news/incoming.conf".

# ls -lL /etc/news/incoming.conf

# If "/etc/news/incoming.conf" has a mode more permissive than 0600, this 
# is a finding.


#
# Fix Text: 
#
# Change the mode of the "/etc/news/incoming.conf" file to 0600.

# chmod 0600 /etc/news/incoming.conf  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006260
	
# Start-Lockdown

