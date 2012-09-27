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
# Group ID (Vulid): V-22320
# Group Title: GEN001363
# Rule ID: SV-37286r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001363
# Rule Title: The /etc/resolv.conf file must be group-owned by root, bin, 
# or sys.
#
# Vulnerability Discussion: The resolv.conf (or equivalent) file 
# configures the system's DNS resolver.  DNS is used to resolve host names 
# to IP addresses.  If DNS configuration is modified maliciously, host name 
# resolution may fail or return incorrect information.  DNS may be used by 
# a variety of system security functions such as time synchronization, 
# centralized authentication, and remote system logging.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the group ownership of the resolv.conf file.

# Procedure:
# ls -lL /etc/resolv.conf

# If the file is not group-owned by root, bin, or sys, this is a finding.
#
# Fix Text: 
#
# Change the group-owner of the /etc/resolv.conf file to root, bin, or 
# sys.

# Procedure:
# chgrp root /etc/resolv.conf     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001363
	
# Start-Lockdown

if [ -a "/etc/resolv.conf" ]
then

  CURGOWN=`stat -c %G /etc/resolv.conf`;
  if [ "$CURGOWN" != "root" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "system" ]
  then
    chgrp root /etc/resolv.conf
  fi
fi


