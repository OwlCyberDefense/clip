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
# Group ID (Vulid): V-1046
# Group Title: GEN001100
# Rule ID: SV-37150r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN001100
# Rule Title: Root passwords must never be passed over a network in clear 
# text form.
#
# Vulnerability Discussion: If a user accesses the root account (or any 
# account) using an unencrypted connection, the password is passed over the 
# network in clear text form and is subject to interception and misuse.  
# This is true even if recommended procedures are followed by logging on to 
# a named account and using the su command to access root.
#
# Responsibility: System Administrator
# IAControls: ECNK-1, ECNK-2, IAIA-1, IAIA-2
#
# Check Content:
#
# Determine if root has logged in over an unencrypted network connection.

# First determine if root has logged in over a network.
# Procedure:
# last | grep "^root " | egrep -v "reboot|console" | more

# Next determine if the SSH daemon is running.
# Procedure:
# ps -ef |grep sshd

# If root has logged in over the network and sshd is not running, this is a 
# finding.


#
# Fix Text: 
#
# Enable SSH on the system and use it for all remote connections used to 
# attain root access  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001100
	
# Start-Lockdown

