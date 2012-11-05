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
# Group ID (Vulid): V-22524
# Group Title: GEN007260
# Rule ID: SV-26887r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN007260
# Rule Title: The AppleTalk protocol must be disabled or not installed.
#
# Vulnerability Discussion: The AppleTalk suite of protocols is no longer 
# in common use.  Binding this protocol to the network stack increases the 
# attack surface of the host.  Unprivileged local processes may be able to 
# cause the system to dynamically load a protocol handler by opening a 
# socket using the protocol.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Verify the AppleTalk protocol handler is prevented from dynamic loading.
# grep 'install appletalk'  /etc/modprobe.conf /etc/modprobe.d/*
# If anything is returned check that appletalk is disabled by having the 
# executable set to  '/bin/true'. If an uncommented line containing 
# "appletalk" is found which has not been disabled, this is a finding.
#
# Fix Text: 
#
# Prevent the AppleTalk protocol handler for dynamic loading.
# echo "install appletalk /bin/true" >> /etc/modprobe.conf  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN007260
	
# Start-Lockdown

