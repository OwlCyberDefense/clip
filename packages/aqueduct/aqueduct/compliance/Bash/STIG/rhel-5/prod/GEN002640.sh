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
# Group ID (Vulid): V-810
# Group Title: GEN002640
# Rule ID: SV-37903r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002640
# Rule Title: Default system accounts must be disabled or removed.
#
# Vulnerability Discussion: Vendor accounts and software may contain 
# backdoors allowing unauthorized access to the system. These backdoors are 
# common knowledge and present a threat to system security if the account 
# is not disabled.
#
# Responsibility: System Administrator
# IAControls: IAAC-1
#
# Check Content:
#
# Determine if default system accounts (such as those for sys, bin, uucp, 
# nuucp, daemon, smtp) have been disabled.

# cat /etc/shadow

# If an account's password field (which is the second field in the 
# /etc/shadow file) is "*", "*LK*", or is prefixed with a '!', the account 
# is locked or disabled.

# If there are any unlocked default system accounts this is a finding.
#
# Fix Text: 
#
# Lock the default system account(s).
# passwd -l <user>
  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002640
	
# Start-Lockdown

for NAME in `awk -F':' '!/^root/{if($3 < 500)print $1}' /etc/passwd`
do
  egrep "^${NAME}:(\!|\*|\*LK\*)" /etc/shadow > /dev/null
  if [ $? -ne 0 ]
  then
    usermod -L $NAME
  fi
done

