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
# Group ID (Vulid): V-4701
# Group Title: GEN003860
# Rule ID: SV-37445r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN003860
# Rule Title: The system must not have the finger service active.
#
# Vulnerability Discussion: The finger service provides information about 
# the system's users to network clients.  This information could expose 
# more information for potential used in subsequent attacks.
#
# Responsibility: System Administrator
# IAControls: DCPP-1, EBRU-1
#
# Check Content:
#
# # grep disable /etc/xinetd.d/finger
# If the finger service is not disabled, this is a finding.


#
# Fix Text: 
#
# Edit /etc/xinetd.d/finger and set "disable=yes"  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003860
	
# Start-Lockdown
if [ -e /etc/xinetd.d/finger ]
  then
    sed -i 's/[[:blank:]]*disable[[:blank:]]*=[[:blank:]]*no/        disable                 = yes/g' /etc/xinetd.d/finger
fi
