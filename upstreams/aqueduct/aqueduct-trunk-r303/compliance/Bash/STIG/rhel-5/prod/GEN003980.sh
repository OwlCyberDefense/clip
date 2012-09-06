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
# Group ID (Vulid): V-4370
# Group Title: GEN003980
# Rule ID: SV-37464r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003980
# Rule Title: The traceroute command must be group-owned by sys, bin, 
# root, or system.
#
# Vulnerability Discussion: If the group owner of the traceroute command 
# has not been set to a system group, unauthorized users could have access 
# to the command and use it to gain information regarding a network's 
# topology inside of the firewall.  This information may allow an attacker 
# to determine trusted routers and other network information potentially 
# leading to system and network compromise.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the group ownership of the traceroute file.

# Procedure:
# ls -lL /bin/traceroute

# If the traceroute command is not group-owned by root, sys, bin, or 
# system, this is a finding.


#
# Fix Text: 
#
# Change the group-owner of the traceroute command to root.

# Procedure:
# chgrp root /bin/traceroute     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003980
	
# Start-Lockdown

if [ -a "/bin/traceroute" ]
then
  CURGROUP=`stat -c %G /bin/traceroute`;
  if [  "$CURGROUP" != "root" -a "$CURGROUP" != "bin" -a "$CURGROUP" != "sys" -a "$CURGROUP" != "system" ]
  then
      chgrp root /bin/traceroute
  fi
fi
