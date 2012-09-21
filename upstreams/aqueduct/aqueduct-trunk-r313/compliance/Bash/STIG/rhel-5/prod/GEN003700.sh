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
# Group ID (Vulid): V-12005
# Group Title: GEN003700
# Rule ID: SV-27424r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003700
# Rule Title: Inetd and xinetd must be disabled or removed if no network 
# services utilizing them are enabled.
#
# Vulnerability Discussion: Unnecessary services should be disabled to 
# decrease the attack surface of the system.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# # ps -ef |grep xinetd
# If xinetd is not running, this check is not a finding.
# grep -v "^#" /etc/xinetd.conf
# grep disable /etc/xinetd.d/* |grep no
# If no active services are found, and the inetd daemon is running, this is 
# a finding.
#
# Fix Text: 
#
# # service xinetd stop ; chkconfig xinetd off  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003700
#Start-Lockdown
chkconfig --list xinetd | grep ':on' > /dev/null
if [ $? -eq 0 ]
then
  # Only turn off xined if all on demand services are disabled
  grep disable /etc/xinetd.d/* | grep no > /dev/null
  if [ $? -ne 0 ]
  then
    service xinetd stop
    chkconfig --level 2345 xinetd off
  fi
fi
