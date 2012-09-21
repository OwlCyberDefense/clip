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
# Group ID (Vulid): V-12039
# Group Title: GEN000000-LNX00640
# Rule ID: SV-37341r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000000-LNX00640
# Rule Title: The /etc/securetty file must be owned by root.
#
# Vulnerability Discussion: The securetty file contains the list of 
# terminals permitting direct root logins.  It must be protected from 
# unauthorized modification.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check /etc/securetty ownership.

# Procedure:
# ls -lL /etc/securetty

# If /etc/securetty is not owned by root, this is a finding.
#
# Fix Text: 
#
# Change the owner of the /etc/securetty file to root.

# Procedure:
# chown root /etc/securetty  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000000-LNX00640
	
# Start-Lockdown

if [ -a "/etc/securetty" ]
then
  CUROWN=`stat -c %U /etc/securetty`;
  if [ "$CUROWN" != "root" ]
  then
    chown root /etc/securetty
  fi
fi


