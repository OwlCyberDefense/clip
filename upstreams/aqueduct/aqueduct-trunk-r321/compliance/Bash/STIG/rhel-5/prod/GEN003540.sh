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
# Group ID (Vulid): V-11999
# Group Title: GEN003540
# Rule ID: SV-27414r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003540
# Rule Title: The system must implement non-executable program stacks.
#
# Vulnerability Discussion: A common type of exploit is the stack buffer 
# overflow.  An application receives, from an attacker, more data than it 
# is prepared for and stores this information on its stack, writing beyond 
# the space reserved for it.  This can be designed to cause execution of 
# the data written on the stack.  One mechanism to mitigate this 
# vulnerability is for the system to not allow the execution of 
# instructions in sections of memory identified as part of the stack.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2, ECSC-1
#
# Check Content:
#
# Verify "exec_shield" and "randomize_va_space" have not been changed 
# from the default "1" settings.

# Procedure:
#sysctl kernel.exec-shield
# If the return value is not: 
# kernel.exec-shield = 1
# this is a finding.


#sysctl kernel.randomize_va_space
# If the return value is not: 
# kernel.randomize_va_space = 1
# this is a finding.
#
# Fix Text: 
#
# Examine /etc/sysctl.conf for "kernel.exec-shield" and 
# "kernel.randomize_va_space" entries and if found remove them. The system 
# default of "1" enables these modules.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003540
KERNEXEC=$( sysctl kernel.exec-shield | awk '{print $3}' )
KERNRAND=$( sysctl kernel.randomize_va_space | awk '{print $3}' )

#Start-Lockdown

if [ $KERNEXEC -ne 1 ]
  then
    echo " "  >> /etc/sysctl.conf
    echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
    echo "kernel.exec-shield = 1" >> /etc/sysctl.conf
    sysctl -p  > /dev/null
fi

if [ $KERNRAND -ne 1 ]
  then
    echo " "  >> /etc/sysctl.conf
    echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
    echo "kernel.randomize_va_space = 1" >> /etc/sysctl.conf
    sysctl -p > /dev/null
fi
