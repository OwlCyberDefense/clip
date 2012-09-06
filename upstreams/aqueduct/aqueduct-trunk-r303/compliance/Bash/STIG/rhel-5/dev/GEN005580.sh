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
# Group ID (Vulid): V-4398
# Group Title: GEN005580
# Rule ID: SV-37924r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005580
# Rule Title: A system used for routing must not run other network 
# services or applications.
#
# Vulnerability Discussion: Installing extraneous software on a system 
# designated as a dedicated router poses a security threat to the system 
# and the network. Should an attacker gain access to the router through the 
# unauthorized software, the entire network is susceptible to malicious 
# activity.
#
# Responsibility: System Administrator
# IAControls: DCSP-1
#
# Check Content:
#
# If the system is a VM host and acts as a router solely for the benefit 
# of its client systems, then this rule is not applicable.
# Ask the SA if the system is a designated router. If it is not, this is 
# not applicable.

# Check the system for non-routing network services.

# Procedure:
# netstat -a | grep -i listen
# ps -ef

# If non-routing services, including Web servers, file servers, DNS 
# servers, or applications servers, but excluding management services such 
# as SSH and SNMP, are running on the system, this is a finding.


#
# Fix Text: 
#
# Ensure only authorized software is loaded on a designated router. 
# Authorized software will be limited to the most current version of 
# routing protocols and SSH for system administration purposes.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005580
	
# Start-Lockdown

