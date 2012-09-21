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

##################### Fusion Technology LLC #############################
# By Shannon Mitchell                                                   #
# Fusion Technology LLC                                                 #
# Shannon[.]Mitchell[@]fusiontechnology-llc[.]com                       #
# www.fusiontechnology-llc.com                                          #
##################### Fusion Technology LLC #############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Shannon Mitchell   | 15-jul-2012|
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-4298
# Group Title: GEN001000
# Rule ID: SV-37376r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001000
# Rule Title: Remote consoles must be disabled or protected from 
# unauthorized access.
#
# Vulnerability Discussion: The remote console feature provides an 
# additional means of access to the system which could allow unauthorized 
# access if not disabled or properly secured.  With virtualization 
# technologies, remote console access is essential as there is no physical 
# console for virtual machines.  Remote console access must be protected in 
# the same manner as any other remote privileged access method.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check /etc/securetty
# more /etc/securetty
# If the file does not exist, or contains more than "console" or a single 
# "tty" device this is a finding.
#
# Fix Text: 
#
# Create if needed and set the contents of /etc/securetty to a "console" 
# or "tty" device.
# echo console > /etc/securetty
# or 
# echo tty1 > /etc/securetty     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001000
	
# Start-Lockdown

# If multiple lines exist default to console
TTYCOUNT=`cat /etc/securetty | wc -l`
if [ $TTYCOUNT -gt 1 ]
then
  echo tty1 > /etc/securetty
else
  # Check the value of the single entry and if its not console or tty1 then fix
  CURTTY=`cat /etc/securetty`
  if [ "$CURTTY" != "console" -a "$CURTTY" != "tty1" ]
  then
    echo tty1 > /etc/securetty
  fi
fi


