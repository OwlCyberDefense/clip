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
# Group ID (Vulid): V-4392
# Group Title: GEN005380
# Rule ID: SV-37708r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005380
# Rule Title: If the system is a Network Management System (NMS) server, 
# it must only run the NMS and any software required by the NMS.
#
# Vulnerability Discussion: Installing extraneous software on a system 
# designated as a dedicated Network Management System (NMS) server poses a 
# security threat to the system and the network. Should an attacker gain 
# access to the NMS through unauthorized software, the entire network may 
# be susceptible to malicious activity.
#
# Responsibility: System Administrator
# IAControls: DCPA-1
#
# Check Content:
#
# Ask the SA if this is an NMS server. If it is an NMS server, then ask 
# what other applications run on it. If there is anything other than 
# network management software and DBMS software used only for the storage 
# and inquiry of NMS data, this is a finding.
#
# Fix Text: 
#
# Ensure only authorized software is loaded on a designated NMS server. 
# Authorized software is limited to the NMS software itself, a database 
# management system for the NMS server if necessary, and network management 
# software.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005380
	
# Start-Lockdown

