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
# Group ID (Vulid): V-22434
# Group Title: GEN003845
# Rule ID: SV-26673r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003845
# Rule Title: The rexecd service must not be installed.
#
# Vulnerability Discussion: The rexecd process provides a typically 
# unencrypted, host-authenticated remote access service.  SSH should be 
# used in place of this service.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check if the rsh-server package is installed.

# Procedure:
# rpm -qa | grep rsh-server

# If a package is found, this is a finding.
#
# Fix Text: 
#
# Remove the rsh-server package.

# Procedure:
# rpm -e rsh-server  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003845
	
# Start-Lockdown
rpm -q rsh-server > /dev/null
if [ $? -eq 0 ]
then
  yum -y remove rsh-server
fi
