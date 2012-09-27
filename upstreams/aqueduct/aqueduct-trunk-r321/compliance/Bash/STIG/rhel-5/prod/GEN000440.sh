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
# Group ID (Vulid): V-765
# Group Title: GEN000440
# Rule ID: SV-37178r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000440
# Rule Title: Successful and unsuccessful logins and logouts must be 
# logged.
#
# Vulnerability Discussion: Monitoring and recording successful and 
# unsuccessful logins assists in tracking unauthorized access to the 
# system.  Without this logging, the ability to track unauthorized activity 
# to specific user accounts may be diminished.
#
# Responsibility: System Administrator
# IAControls: ECAR-1, ECAR-2, ECAR-3
#
# Check Content:
#
# Determine if all logon attempts are being logged.

# Procedure:
# Verify successful logins are being logged:
# last -R | more 
# If the command does not return successful logins, this is a finding.

# Verify if unsuccessful logons are being logged: 
# lastb -R | more
# If the command does not return unsuccessful logins, this is a finding.
#
# Fix Text: 
#
# Make sure the collection files exist.
# Procedure:
# If there are no successful logins being returned from the "last" command, 
# create /var/log/wtmp:
# touch /var/log/wtmp

# If there are no unsuccessful logins being returned from the "lastb" 
# command, create /var/log/btmp:
# touch /var/log/btmp  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000440
	
# Start-Lockdown

if [ ! -e "/var/log/wtmp" ]
then
  touch /var/log/wtmp
  chown root:utmp /var/log/wtmp
  chmod 664 /var/log/wtmp
  chcon system_u:object_r:wtmp_t /var/log/wtmp 
fi

if [ ! -e "/var/log/btmp" ]
then
  touch /var/log/btmp
  chown root:utmp /var/log/btmp
  chmod 600 /var/log/btmp
  chcon system_u:object_r:faillog_t /var/log/btmp
fi

