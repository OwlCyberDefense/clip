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
# Group ID (Vulid): V-22507
# Group Title: GEN006570
# Rule ID: SV-37752r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN006570
# Rule Title: The file integrity tool must be configured to verify ACLs.
#
# Vulnerability Discussion: ACLs can provide permissions beyond those 
# permitted through the file mode and must be verified by file integrity 
# tools.
#
# Responsibility: System Administrator
# IAControls: ECAT-1
#
# Check Content:
#
# If using an Advanced Intrusion Detection Environment (AIDE), verify 
# that the configuration contains the "ACL" option for all monitored files 
# and directories.

# Procedure:
# Check for the default location /etc/aide/aide.conf
# or:
# find / -name aide.conf

# egrep "[+]?acl" <aide.conf file>
# If the option is not present. This is a finding.

# If using a different file integrity tool, check the configuration per 
# tool documentation.


#
# Fix Text: 
#
# If using AIDE, edit the configuration and add the "ACL" option for all 
# monitored files and directories.

# If using a different file integrity tool, configure ACL checking per the 
# tool's documentation.    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006570
	
# Start-Lockdown

