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
# Group ID (Vulid): V-22429
# Group Title: GEN003810
# Rule ID: SV-26662r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003810
# Rule Title: The portmap or rpcbind service must not be running unless 
# needed.
#
# Vulnerability Discussion: The portmap and rpcbind services increase the 
# attack surface of the system and should only be used when needed.  The 
# portmap or rpcbind services are used by a variety of services using 
# Remote Procedure Calls (RPCs).
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the status of the portmap service.
# service portmap status
# If the service is running, this is a finding.
#
# Fix Text: 
#
# Shutdown and disable the portmap service.
# service portmap stop; chkconfig portmap off  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003810
	
# Start-Lockdown
if [ ! -f /etc/rc.d/init.d/portmap ] && ! rpm -q portmap >/dev/null 2>&1 
	then
		exit 0
fi
chkconfig --list portmap | grep ':on' > /dev/null
if [ $? -eq 0 ]
then
  service portmap stop
  chkconfig --level 2345 portmap off
fi

