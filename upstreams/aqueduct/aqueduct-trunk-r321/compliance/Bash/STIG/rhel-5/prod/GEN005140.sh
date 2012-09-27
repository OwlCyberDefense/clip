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
# Group ID (Vulid): V-4695
# Group Title: GEN005140
# Rule ID: SV-37676r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN005140
# Rule Title: Any active TFTP daemon must be authorized and approved in 
# the system accreditation package.
#
# Vulnerability Discussion: TFTP is a file transfer protocol often used 
# by embedded systems to obtain configuration data or software.    The 
# service is unencrypted and does not require authentication of requests.  
# Data available using this service may be subject to unauthorized access 
# or interception.
#
# Responsibility: System Administrator
# IAControls: DCSW-1
#
# Check Content:
#
# Determine if the TFTP daemon is active.
# chkconfig --list | grep tftp

# If TFTP is found enabled ("on") and not documented using site-defined 
# procedures, it is a finding.
#
# Fix Text: 
#
# Document or Disable the TFTP daemon.

# If the TFTP daemon is necessary on the system, document and justify its 
# usage for approval from the IAO.

# If the TFTP daemon is not necessary on the system, turn it off.

# chkconfig tftp off
# service xinetd restart  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005140
	
# Start-Lockdown

chkconfig --list tftp 2>/dev/null | grep 'on' > /dev/null
if [ $? -eq 0 ]
then
  chkconfig tftp off
  service xinetd restart
fi
