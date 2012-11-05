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
# Group ID (Vulid): V-27275
# Group Title: GEN000290-2
# Rule ID: SV-34574r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000290-2
# Rule Title: The system must not have the unnecessary "news" account.
#
# Vulnerability Discussion: Accounts that provide no operational purpose 
# provide additional opportunities for system compromise. Unnecessary 
# accounts include user accounts for individuals not requiring access to 
# the system and application accounts for applications not installed on the 
# system.
#
# Responsibility: System Administrator
# IAControls: IAAC-1
#
# Check Content:
#
# Check the system for the unnecessary "news" accounts.

# Procedure:
# rpm -q inn
# If the "inn" is installed the "news" user is necessary and this is not a 
# finding.

# grep ^news /etc/passwd
# If this account exists and "inn" is not installed, this is a finding.
#
# Fix Text: 
#
# Remove the "news" account from the /etc/passwd file before connecting a 
# system to the network.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000290-2
	
# Start-Lockdown

rpm -q inn > /dev/null
if [ $? != 0 ]
then
  grep '^news' /etc/passwd > /dev/null
  if [ $? == 0 ]
  then
    userdel -r news
  fi 

  if [ -d "/usr/lib/news" ]
  then
    rm -rf /usr/lib/news
  fi

  if [ -d "/var/log/news" ]
  then
    rm -rf /var/log/news
  fi

  sed -i -e 's/^\(news.*\)/#\1/g' /etc/syslog.conf

fi
