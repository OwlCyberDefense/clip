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
# Group ID (Vulid): V-22302
# Group Title: GEN000585
# Rule ID: SV-37261r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000585
# Rule Title: The system must enforce compliance of the entire password 
# during authentification.
#
# Vulnerability Discussion: Some common password hashing schemes only 
# process the first eight characters of a user's password, which reduces 
# the effective strength of the password.
#
# Responsibility: System Administrator
# IAControls: IAIA-1, IAIA-2
#
# Check Content:
#
# Verify no password hash in /etc/passwd or /etc/shadow begins with a 
# character other than an underscore (_) or dollar sign ($).

# cut -d ':' -f2 /etc/passwd
# cut -d ':' -f2 /etc/shadow

# If any password hash is present that does not have an initial underscore 
# (_) or dollar sign ($) character, this is a finding.

#
# Fix Text: 
#
# Change the passwords for all accounts using non-compliant password 
# hashes. 

# (This requires GEN000590 is already met.)   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000585
	
# Start-Lockdown

# Displan an error if password hashes start with anything other then _, $, !! or *
USERS_W_BAD_PASSWORDS=`awk -F ':' '{if($2 !~ /^_/ && $2 !~ /^\\$/ && $2 !~ /!!/ && $2 !~ /\*/) print $1}' /etc/shadow | tr "\n" " "`


if [ "$USERS_W_BAD_PASSWORDS" != "" ]
then
  echo "------------------------------" > $PDI-error.log
  date >> $PDI-error.log
  echo " " >> $PDI-error.log
  echo "${PDI}: The following accounts have a bad password hash that does not start with a '_' or a '$'" >> $PDI-error.log
  echo "$USERS_W_BAD_PASSWORDS" >> $PDI-error.log
  echo "Please review these accounts" >> $PDI-error.log
  echo "------------------------------" >> $PDI-error.log
fi
