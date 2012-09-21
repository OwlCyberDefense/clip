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
# Group ID (Vulid): V-12004
# Group Title: GEN003660
# Rule ID: SV-37404r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003660
# Rule Title: The system must log informational authentication data.
#
# Vulnerability Discussion: Monitoring and recording successful and 
# unsuccessful logins assists in tracking unauthorized access to the system.
#
# Responsibility: System Administrator
# IAControls: ECAR-1, ECAR-2, ECAR-3
#
# Check Content:
#
# Check /etc/syslog.conf and verify the authpriv facility is logging both 
# the "notice" and "info" priority messages.

# Procedure:
# For a given action all messages of a higher severity or "priority" are 
# logged. The three lowest priorities in ascending order are "debug","info" 
# and "notice". A priority of "info" will include "notice". A priority of 
# "debug" includes both "info" and "notice".

# Enter/Input:
# grep "authpriv.debug" /etc/syslog.conf
# grep "authpriv.info" /etc/syslog.conf
# grep "authpriv\.\*" /etc/syslog.conf

# If an "authpriv.*", "authpriv.debug", or "authpriv.info" entry is not 
# found, this is a finding.



#
# Fix Text: 
#
# Edit /etc/syslog.conf and add local log destinations for "authpriv.*", 
# "authpriv.debug" or "authpriv.info".     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003660
SYSLOGAUTH=$( egrep '(authpriv.*)' /etc/syslog.conf | grep -v authpriv.none | grep -cv '^#')
#Start-Lockdown

if [ $SYSLOGAUTH -eq 0 ]
  then
  echo " " >> /etc/syslog.conf
  echo "#Added for GEN003660" >> /etc/syslog.conf
    echo "authpriv.*                                               /var/log/secure" >> /etc/syslog.conf
	service syslog restart > /dev/null
fi
