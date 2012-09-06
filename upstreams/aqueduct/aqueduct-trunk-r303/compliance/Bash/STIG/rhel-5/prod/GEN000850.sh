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
# Group ID (Vulid): V-22308
# Group Title: GEN000850
# Rule ID: SV-37345r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN000850
# Rule Title: The system must restrict the ability to switch to the root 
# user to members of a defined group.
#
# Vulnerability Discussion: Configuring a supplemental group for users 
# permitted to switch to the root user prevents unauthorized users from 
# accessing the root account, even with knowledge of the root credentials.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check /etc/pam.d/su uses pam_wheel.
# grep pam_wheel /etc/pam.d/su
# If pam_wheel is not present, or is commented out, this is a finding.
#
# Fix Text: 
#
# Edit /etc/pam.d/su and uncomment or add a line such as "auth required 
# pam_wheel.so". If necessary, create a "wheel" group and add 
# administrative users to the group.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000850
	
# Start-Lockdown

grep '#auth.*pam_wheel.so use_uid' /etc/pam.d/su > /dev/null
if [ $? == 0 ]
then
  sed -i -e 's/#\(auth.*required.*pam_wheel.so use_uid\)/\1/g' /etc/pam.d/su
fi
