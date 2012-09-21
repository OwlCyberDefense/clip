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
# Group ID (Vulid): V-24347
# Group Title: GEN009120
# Rule ID: SV-30004r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN009120
# Rule Title: The system, if capable, must be configured to require the 
# use of a CAC, PIV compliant hardware token, or Alternate Logon Token 
# (ALT) for authentication.
#
# Vulnerability Discussion: In accordance with CTO 07-015 PKI 
# authentication is required. This provides stronger, two-factor 
# authentication than using a username/password.

# NOTE: The following are exempt from this, however, they must meet all 
# password requirements and must be documented with the IAO:

# - SIPRNET systems.
# - Stand-alone systems.
# - Application Accounts.
# - Students or unpaid employees (such as, interns) who are not eligible to 
# receive or not in receipt of a CAC, PIV, or ALT.
# - Warfighters and support personnel located at operational tactical 
# locations conducting wartime operations that are not collocated with 
# RAPIDS workstations to issue CAC; are not eligible for CAC or do not have 
# the capability to use ALT.
# - Test systems that have an Interim Approval to Test (IATT) and provide 
# protection via separate VPN, firewall, or security measures preventing 
# access to network and system components from outside the protection 
# boundary documented in the IATT.
#
# Responsibility: System Administrator
# IAControls: IAIA-1, IAIA-2
#
# Check Content:
#
# Consult vendor documentation to determine if the system is capable of 
# CAC authentication. If it is not, this is not applicable.

# Interview the SA to determine if all accounts not exempted by policy are 
# using CAC authentication. If non-exempt accounts are not using CAC 
# authentication, this is a finding.

#
# Fix Text: 
#
# Consult vendor documentation to determine the procedures necessary for 
# configuring CAC authentication. Configure all accounts required by policy 
# to use CAC authentication.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN009120
	
# Start-Lockdown

