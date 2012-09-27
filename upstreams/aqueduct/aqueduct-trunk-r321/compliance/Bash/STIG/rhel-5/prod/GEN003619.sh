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
# Group ID (Vulid): V-22421
# Group Title: GEN003619
# Rule ID: SV-37639r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003619
# Rule Title: The system must not be configured for network bridging.
#
# Vulnerability Discussion: Some systems have the ability to bridge or 
# switch frames (link-layer forwarding) between multiple interfaces.  This 
# can be useful in a variety of situations but, if enabled when not needed, 
# has the potential to bypass network partitioning and security.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Verify the system is not configured for bridging.
# ls /proc/sys/net/bridge
# If the directory exists, this is a finding.
# lsmod | grep '^bridge '
# If any results are returned, this is a finding.

# Fix Text: Configure the system to not use bridging.

#
# Fix Text: 
#
#  Configure the system to not use bridging.
# rmmod bridge
# Edit /etc/modprobe.conf and add a line such as "install bridge 
# /bin/false" to prevent the loading of the bridge module.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003619

#Check if bridge is disabled
NOBRIDGE=$( cat /etc/modprobe.conf |egrep -i '(install|bridge|/bin/false)' | wc -l )
#Start-Lockdown

if [ -d /proc/sys/net/bridge ]
  then
    rmmod bridge
fi

if [ $NOBRIDGE -lt 1 ]
  then
    echo " " >> /etc/modprobe.conf
    echo "#Added for GEN003619.  Disable install of bridge" >> /etc/modprobe.conf
    echo "install bridge /bin/false" >> /etc/modprobe.conf
fi
