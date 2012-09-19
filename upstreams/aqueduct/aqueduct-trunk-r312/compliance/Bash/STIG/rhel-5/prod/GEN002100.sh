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
# Group ID (Vulid): V-11989
# Group Title: GEN002100
# Rule ID: SV-37389r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002100
# Rule Title: The .rhosts file must not be supported in PAM.
#
# Vulnerability Discussion: .rhosts files are used to specify a list of 
# hosts permitted remote access to a particular account without 
# authenticating. The use of such a mechanism defeats strong identification 
# and authentication requirements.
#
# Responsibility: Information Assurance Officer
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# Check the PAM configuration for rhosts_auth.

# Example:
# grep rhosts_auth /etc/pam.d/*

# If a rhosts_auth entry is found, this is a finding.
#
# Fix Text: 
#
# Edit the file(s) in /etc/pam.d referencing the rhosts_auth module, and 
# remove the references to the rhosts_auth module.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002100
	
# Start-Lockdown

sed -i -e 's/^[^#].*pam_rhosts_auth.*/#&/' $( grep rhost /etc/pam.d/* -l )
