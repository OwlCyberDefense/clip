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
# Group ID (Vulid): V-4084
# Group Title: GEN000800
# Rule ID: SV-37323r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000800
# Rule Title: The system must prohibit the reuse of passwords within five 
# iterations.
#
# Vulnerability Discussion: If a user, or root, used the same password 
# continuously or was allowed to change it back shortly after being forced 
# to change it to something else, it would provide a potential intruder 
# with the opportunity to keep guessing at one user's password until it was 
# guessed correctly.
#
# Responsibility: System Administrator
# IAControls: IAIA-1, IAIA-2
#
# Check Content:
#
# # ls /etc/security/opasswd
# If /etc/security/opasswd does not exist, then this is a finding.

# grep password /etc/pam.d/system-auth| grep pam_unix.so | grep remember
# If the "remember" option in /etc/pam.d/system-auth is not 5 or greater, 
# this is a finding.

# Check for system-auth-ac inclusions.
# grep -c system-auth-ac /etc/pam.d/*

# If the system-auth-ac file is included anywhere
# more /etc/pam.d/system-auth-ac | grep password | grep pam_unix.so | 
# grep remember

# If in /etc/pam.d/system-auth-ac is referenced by another file and the 
# "remember" option is not set to 5 or greater this is a finding.
#
# Fix Text: 
#
# Create the password history file.
# touch /etc/security/opasswd
# chown root:root /etc/security/opasswd
# chmod 0600 /etc/security/opasswd

# Enable password history.
# If /etc/pam.d/system-auth references /etc/pam.d/system-auth-ac refer to 
# the man page for system-auth-ac for a description of how to add options 
# not configurable with authconfig. Edit /etc/pam.d/system-auth to include 
# the remember option on the "password pam_unix" lines set to at least 5.   
 
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000800
	
# Start-Lockdown

for PFPREFIX in system password smartcard fingerprint
do
  if [ -e "/etc/pam.d/${PFPREFIX}-auth-ac" ]
  then

    sed -i '/password    sufficient    pam_unix.so/ {/remember=5/! s/.*/& remember=5/}' /etc/pam.d/${PFPREFIX}-auth-ac

    if [ -a "/etc/security/opasswd" ]
    then
      touch /etc/security/opasswd
      chown root:root /etc/security/opasswd
      chmod 0600 /etc/security/opasswd
    fi
  fi
done

