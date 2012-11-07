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
# Group ID (Vulid): V-974
# Group Title: GEN002960
# Rule ID: SV-27320r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002960
# Rule Title: Access to the cron utility must be controlled using the 
# cron.allow and/or cron.deny file(s).
#
# Vulnerability Discussion: The cron facility allows users to execute 
# recurring jobs on a regular and unattended basis.  The cron.allow file 
# designates accounts allowed to enter and execute jobs using the cron 
# facility.  If neither cron.allow nor cron.deny exists, then any account 
# may use the cron facility.  This may open the facility up for abuse by 
# system intruders and malicious users.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check for the existence of the cron.allow and cron.deny files.
# ls -lL /etc/cron.allow
# ls -lL /etc/cron.deny
# If neither file exists, this is a finding.
#
# Fix Text: 
#
# Create /etc/cron.allow and/or /etc/cron.deny with appropriate content.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002960
	
# Start-Lockdown

if [ ! -f /etc/cron.allow ];
then
    touch /etc/cron.allow
fi

if [ ! -f /etc/cron.deny ];
then
    touch /etc/cron.deny
fi

