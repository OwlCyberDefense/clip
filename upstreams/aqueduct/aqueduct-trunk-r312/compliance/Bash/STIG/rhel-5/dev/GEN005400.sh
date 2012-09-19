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
# Group ID (Vulid): V-4393
# Group Title: GEN005400
# Rule ID: SV-37707r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005400
# Rule Title: The /etc/syslog.conf file must be owned by root.
#
# Vulnerability Discussion: If the /etc/syslog.conf file is not owned by 
# root, unauthorized users could be allowed to view, edit, or delete 
# important system messages handled by the syslog facility.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check /etc/syslog.conf ownership:

# ls -lL /etc/syslog.conf

# If /etc/syslog.conf is not owned by root, this is a finding.


#
# Fix Text: 
#
# Use the chown command to set the owner to root.
# chown root /etc/syslog.conf     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005400
	
# Start-Lockdown

