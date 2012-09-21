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
# Group ID (Vulid): V-22319
# Group Title: GEN001362
# Rule ID: SV-37280r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001362
# Rule Title: The /etc/resolv.conf file must be owned by root.
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
# Verify the /etc/resolv.conf file is owned by root.
# ls -l /etc/resolv.conf
# If the file is not owned by root, this is a finding.


#
# Fix Text: 
#
# Change the owner of the /etc/resolv.conf file to root.
# chown root /etc/resolv.conf     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001362
	
# Start-Lockdown

if [ -a "/etc/resolv.conf" ]
then
  CUROWN=`stat -c %U /etc/resolv.conf`;
  if [ "$CUROWN" != "root" ]
  then
    chown root /etc/resolv.conf
  fi
fi


