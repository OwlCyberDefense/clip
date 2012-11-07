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
# Group ID (Vulid): V-22299
# Group Title: GEN000452
# Rule ID: SV-37187r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN000452
# Rule Title: The system must display the date and time of the last 
# successful account login upon login.
#
# Vulnerability Discussion: Providing users with feedback on when account 
# accesses last occurred facilitates user recognition and reporting of 
# unauthorized account use.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check that pam_lastlog is used and not silent, or that the SSH daemon 
# is configured to display last login information.

# grep pam_lastlog /etc/pam.d/sshd
# If pam_lastlog is present, and does not have the "silent" option, this is 
# not a finding.

# grep -i PrintLastLog /etc/ssh/sshd_config

# If PrintLastLog is not present in the configuration, this is not a 
# finding. This is the default setting.
# If PrintLastLog is present in the configuration and set to "yes" (case 
# insensitive), this is not a finding.
# Otherwise, this is a finding.
#
# Fix Text: 
#
# Implement pam_lastlog, or enable PrintLastLog in the SSH daemon.

# To enable pam_lastlog, add a line such as "session required 
# pam_lastlog.so" to /etc/pam.d/sshd.

# To enable PrintLastLog in the SSH daemon, remove any lines disabling this 
# option from /etc/ssh/sshd_config.   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000452
	
# Start-Lockdown

grep "^PrintLastLog yes" /etc/ssh/sshd_config > /dev/null
if [ $? != 0 ]
then
  echo "# Adding entry for GEN000452" >> /etc/ssh/sshd_config
  echo "PrintLastLog yes" >> /etc/ssh/sshd_config
fi

# Prints a duplicate message if you have both configs.
#grep "session    required     pam_lastlog.so" /etc/pam.d/sshd > /dev/null
#if [ $? != 0 ]
#then
#  echo "# Adding entry for GEN000452" >> /etc/pam.d/sshd
#  echo "session    required     pam_lastlog.so" >> /etc/pam.d/sshd
#fi


