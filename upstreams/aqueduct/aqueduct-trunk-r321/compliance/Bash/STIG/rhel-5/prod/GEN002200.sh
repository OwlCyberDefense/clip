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
# Group ID (Vulid): V-921
# Group Title: GEN002200
# Rule ID: SV-37396r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002200
# Rule Title: All shell files must be owned by root or bin.
#
# Vulnerability Discussion: If shell files are owned by users other than 
# root or bin, they could be modified by intruders or malicious users to 
# perform unauthorized actions.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the ownership of the system shells.
# cat /etc/shells | xargs -n1 ls -l
# If any shell is not owned by root or bin, this is a finding.
#
# Fix Text: 
#
# Change the ownership of the shell with incorrect ownership.
# chown root <shell>     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002200
	
# Start-Lockdown

find /bin/bash /sbin/nologin /bin/tcsh /bin/csh /bin/ksh /bin/sync /sbin/shutdown /sbin/halt ! -user root ! -user bin -exec chown root {} \; 2> /dev/null
