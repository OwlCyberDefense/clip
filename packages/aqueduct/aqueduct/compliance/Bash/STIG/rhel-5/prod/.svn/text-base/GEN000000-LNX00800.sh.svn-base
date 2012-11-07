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
# Group ID (Vulid): V-22584
# Group Title: GEN000000-LNX00800
# Rule ID: SV-26978r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN000000-LNX00800
# Rule Title: The system must use a Linux Security Module configured to 
# limit the privileges of system services.
#
# Vulnerability Discussion: Linux Security Modules such as SELinux and 
# AppArmor can be used to provide protection from software exploits by 
# explicitly defining the privileges permitted to each software package.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check if SELinux is enabled with at least a "targeted" policy.

# grep ^SELINUX /etc/sysconfig/selinux

# If the SELINUX option is not set to "enforcing", this is a finding.
# If the SELINUXTYPE option is not set to "targeted" or "strict", this is a 
# finding.

# If the use of the system is incompatible with the confines of SELinux 
# this rule may be waived.
#
# Fix Text: 
#
# Enable one of the SELinux prolicies.
# Edit /etc/sysconfig/selinux and set the value of the SELINUX option to 
# "enforcing" and SELINUXTYPE to "targeted" or "strict".
# Restart the system.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000000-LNX00800
	
# Start-Lockdown

grep '^SELINUX=disabled' /etc/sysconfig/selinux > /dev/null
if [ $? == 0 ]
then
  sed -i 's/SELINUX=disabled/SELINUX=permissive/g' /etc/sysconfig/selinux
fi
