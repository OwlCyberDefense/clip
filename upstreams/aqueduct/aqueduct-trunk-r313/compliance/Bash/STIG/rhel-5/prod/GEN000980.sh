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
# Group ID (Vulid): V-778
# Group Title: GEN000980
# Rule ID: SV-37374r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000980
# Rule Title: The system must prevent the root account from directly 
# logging in except from the system console.
#
# Vulnerability Discussion: Limiting the root account direct logins to 
# only system consoles protects the root account from direct unauthorized 
# access from a non-console device.
#
# Responsibility: System Administrator
# IAControls: ECPA-1, ECSD-2
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
PDI=GEN000980
	
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

