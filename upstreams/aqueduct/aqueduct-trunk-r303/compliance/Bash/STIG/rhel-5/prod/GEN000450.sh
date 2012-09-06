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
# Group ID (Vulid): V-22298
# Group Title: GEN000450
# Rule ID: SV-37182r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN000450
# Rule Title: The system must limit users to 10 simultaneous system 
# logins, or a site-defined number, in accordance with operational 
# requirements.
#
# Vulnerability Discussion: Limiting simultaneous user logins can 
# insulate the system from denial of service problems caused by excessive 
# logins.  Automated login processes operating improperly or maliciously 
# may result in an exceptional number of simultaneous login sessions.

# If the defined value of 10 logins does not meet operational requirements, 
# the site may define the permitted number of simultaneous login sessions 
# based on operational requirements.

# This limit is for the number of simultaneous login sessions for EACH user 
# account.  This is NOT a limit on the total number of simultaneous login 
# sessions on the system.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check for a default maxlogins line in the /etc/security/limits.conf and 
# /etc/security/limits.d/* files.
#
# Procedure:
#grep maxlogins /etc/security/limits.conf /etc/security/limits.d/*
#
# The default maxlimits should be set to a max of 10 or a documented site 
# defined number:
#
# * - maxlogins 10
#
# If no such line exists, this is a finding.
#
# Fix Text: 
#
# Add a "maxlogins" line such as "* hard maxlogins 10" to 
# /etc/security/limits.conf or a file in /etc/security/limits.d. The 
# enforced maximum should be defined by site requirements and policy.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000450
	
# Start-Lockdown
grep '^[^#].*maxlogins' /etc/security/limits.conf /etc/security/limits.d/* > /dev/null 2>&1
if [ $? != 0 ]
then
  echo "#Configured to meet GEN000450" >> /etc/security/limits.d/99-GEN000450.conf
  echo "* hard maxlogins 10" >> /etc/security/limits.d/99-GEN000450.conf
fi

