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
# Group ID (Vulid): V-22328
# Group Title: GEN001372
# Rule ID: SV-37330r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001372
# Rule Title: The /etc/nsswitch.conf file must be group-owned by root, 
# bin, or sys.
#
# Vulnerability Discussion: The nsswitch.conf file (or equivalent) 
# configures the source of a variety of system security information 
# including account, group, and host lookups.  Malicious changes could 
# prevent the system from functioning or compromise system security.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the group ownership of the nsswitch.conf file.

# Procedure:
# ls -lL /etc/nsswitch.conf

# If the file is not group-owned by root, bin or sys, this is a finding.


#
# Fix Text: 
#
#  Change the group-owner of the /etc/nsswitch.conf file to root, bin or 
# sys.

# Procedure:
# chgrp root /etc/nsswitch.conf     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001372
	
# Start-Lockdown

if [ -a "/etc/nsswitch.conf" ]
then
  CURGOWN=`stat -c %G /etc/nsswitch.conf`;

  if [ "$CURGOWN" != "root" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "system" ]
  then
    chgrp root /etc/nsswitch.conf
  fi
fi


