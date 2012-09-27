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
# Group ID (Vulid): V-1054
# Group Title: GEN000000-LNX00420
# Rule ID: SV-37227r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000000-LNX00420
# Rule Title: The /etc/access.conf file must have a privileged group 
# owner.
#
# Vulnerability Discussion: Depending on the access restrictions of the 
# /etc/access.conf file, if the group owner were not a privileged group, it 
# could endanger system security.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check access configuration group ownership:

# ls -lL /etc/security/access.conf

# If this file exists and has a group-owner that is not a privileged user, 
# this is a finding.
#
# Fix Text: 
#
# Use the chgrp command to ensure the group owner is root, sys, or bin.
# (for example:
# chgrp root /etc/security/access.conf
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000000-LNX00420
	
# Start-Lockdown

if [ -a "/etc/security/access.conf" ]
then
  CURGOWN=`stat -c %G /etc/security/access.conf`;

  if [ "$CURGOWN" != "root" ]
  then
    chgrp root /etc/security/access.conf
  fi
fi

