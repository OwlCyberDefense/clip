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
# Group ID (Vulid): V-12006
# Group Title: GEN004540
# Rule ID: SV-37504r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN004540
# Rule Title: The SMTP service HELP command must not be enabled.
#
# Vulnerability Discussion: The HELP command should be disabled to mask 
# version information.  The version of the SMTP service software could be 
# used by attackers to target vulnerabilities present in specific software 
# versions.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check if Help is disabled. This rule is for "sendmail" only and not 
# applicable to "Postfix".

# Procedure:
# telnet localhost 25
# > help

# If the help command returns any sendmail version information, this is a 
# finding.


#
# Fix Text: 
#
# To disable the SMTP HELP command, remove /etc/mail/helpfile.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004540
	
# Start-Lockdown

if [ -e /etc/mail/helpfile ]
then
  rm -f /etc/mail/helpfile
fi
