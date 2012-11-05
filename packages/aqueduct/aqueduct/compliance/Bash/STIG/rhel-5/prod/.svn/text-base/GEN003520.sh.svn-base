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

###################### Fotis Networks LLC ###############################
# By Vincent C. Passaro                                                 #
# Fotis Networks LLC	                                                #
# Vincent[.]Passaro[@]fotisnetworks[.]com                               #
# www.fotisnetworks.com	                                                #
###################### Fotis Networks LLC ###############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Vincent C. Passaro | 1-Aug-2012 |
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-11997
# Group Title: GEN003520
# Rule ID: SV-37570r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN003520
# Rule Title: The kernel core dump data directory must be owned by root.
#
# Vulnerability Discussion: Kernel core dumps may contain the full 
# contents of system memory at the time of the crash.  As the system memory 
# may contain sensitive information, it must be protected accordingly. If 
# the kernel core dump data directory is not owned by root, the core dumps 
# contained in the directory may be subject to unauthorized access.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the ownership of the kernel core dump data directory.
# ls -ld /var/crash
# If the kernel core dump data directory is not owned by root, this is a 
# finding.
#
# Fix Text: 
#
# Change the owner of the kernel core dump data directory to root. 
# chown root /var/crash   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003520
	
# Start-Lockdown

if [ -d "/var/crash" ]
then
  CUROWN=`stat -c %U /var/crash`;
  if [ "$CUROWN" != "root" ]
    then
      chown root /var/crash
  fi
fi