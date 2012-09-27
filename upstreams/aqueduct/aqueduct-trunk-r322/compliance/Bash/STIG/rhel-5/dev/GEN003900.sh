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
# Group ID (Vulid): V-827
# Group Title: GEN003900
# Rule ID: SV-37447r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003900
# Rule Title: The hosts.lpd file (or equivalent) must not contain a ‘+’ 
# character.
#
# Vulnerability Discussion: Having the '+' character in the hosts.lpd (or 
# equivalent) file allows all hosts to use local system print resources.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# RHEL uses "cups" print service. Verify remote host access is limited.

# Procedure:
# grep -i Listen /etc/cups/cupsd.conf 
# The /etc/cups/cupsd.conf file must not contain a Listen *:<port> or 
# equivalent line.
# If the network address of the "Listen" line is unrestricted, this is a 
# finding.

# grep -i "Allow From" /etc/cups/cupsd.conf 
# The "Allow From" line within the "<Location />" element should limit 
# access to the printers to @LOCAL and specific hosts.
# If the "Allow From" line contains "All" this is a finding
#
# Fix Text: 
#
# Configure cups to use only the localhost or specified remote hosts.

# Procedure: 
# Modify the /etc/cups/cupsd.conf file to "Listen" only to the local 
# machine or a known set of hosts (i.e., Listen localhost:631).
# Modify the /etc/cups/cupsd.conf file "<Location />" element to "Deny From 
# All" and "Allow from 127.0.0.1" or allowed host addresses. 

# Restart cups:
# service cups restart

  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003900
	
# Start-Lockdown

