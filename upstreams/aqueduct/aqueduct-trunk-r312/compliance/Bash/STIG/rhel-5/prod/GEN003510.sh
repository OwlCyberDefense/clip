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
# Group ID (Vulid): V-22404
# Group Title: GEN003510
# Rule ID: SV-26604r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003510
# Rule Title: Kernel core dumps must be disabled unless needed.
#
# Vulnerability Discussion: Kernel core dumps may contain the full 
# contents of system memory at the time of the crash.  Kernel core dumps 
# may consume a considerable amount of disk space and may result in Denial 
# of Service by exhausting the available space on the target file system.  
# The kernel core dump process may increase the amount of time a system is 
# unavailable due to a crash.  Kernel core dumps can be useful for kernel 
# debugging.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Verify the kdump service is not running.

# Procedure:
# service kdump status
# If "Kdump is operational" is returned, this is a finding.
#
# Fix Text: 
#
# Disable kdump.
# service kdump stop
# chkconfig kdump off     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003510
	
# Start-Lockdown

chkconfig --list kdump | egrep '[2-5]:on'
if [ $? -eq 0 ]
then
    service kdump stop
    chkconfig --level 2345 kdump off
fi