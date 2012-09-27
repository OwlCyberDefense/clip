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
# Group ID (Vulid): V-4687
# Group Title: GEN003820
# Rule ID: SV-37441r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN003820
# Rule Title: The rsh daemon must not be running.
#
# Vulnerability Discussion: The rshd process provides a typically 
# unencrypted, host-authenticated remote access service.  SSH should be 
# used in place of this service.
#
# Responsibility: System Administrator
# IAControls: EBRU-1
#
# Check Content:
#
# Check to see if rshd is configured to run on startup.

# Procedure:
# grep disable /etc/xinetd.d/rsh

# If /etc/xinetd.d/rsh exists and rsh is found to be enabled, this is a 
# finding.

#
# Fix Text: 
#
# Edit /etc/xinetd.d/rsh and set "disable=yes".     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003820
	
#Start-Lockdown

#Check if rsh installed
if [ -e /etc/xinetd.d/rsh ]
  then
    sed -i 's/[[:blank:]]*disable[[:blank:]]*=[[:blank:]]*no/        disable                 = yes/g' /etc/xinetd.d/rsh 
fi
