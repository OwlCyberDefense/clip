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
# Group ID (Vulid): V-4696
# Group Title: GEN005280
# Rule ID: SV-37688r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005280
# Rule Title: The system must not have the UUCP service active.
#
# Vulnerability Discussion: The UUCP utility is designed to assist in 
# transferring files, executing remote commands, and sending e-mail between 
# UNIX systems over phone lines and direct connections between systems. The 
# UUCP utility is a primitive and arcane system with many security issues. 
# There are alternate data transfer utilities/products that can be 
# configured to more securely transfer data by providing for authentication 
# as well as encryption.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# # service uucp status
# if UUCP is "running", this is a finding.

#
# Fix Text: 
#
# # chkconfig uucp off
# service uucp stop
# service xinetd restart     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005280
	
# Start-Lockdown
chkconfig --list uucp 2>/dev/null | grep 'on' > /dev/null
if [ $? -eq 0 ]
then
  chkconfig uucp off
  service xinetd restart
fi

