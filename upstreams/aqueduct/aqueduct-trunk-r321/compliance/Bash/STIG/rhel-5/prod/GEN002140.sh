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
# Group ID (Vulid): V-917
# Group Title: GEN002140
# Rule ID: SV-37393r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002140
# Rule Title: All shells referenced in /etc/passwd must be listed in the 
# /etc/shells file, except any shells specified for the purpose of 
# preventing logins.
#
# Vulnerability Discussion: The shells file lists approved default 
# shells. It helps provide layered defense to the security approach by 
# ensuring users cannot change their default shell to an unauthorized 
# unsecure shell.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Confirm the login shells referenced in the /etc/passwd file are listed 
# in the /etc/shells file.

# Procedure:
# for USHELL in `cut -d: -f7 /etc/passwd`; do if [ $(grep -c "${USHELL}" 
# /etc/shells) == 0 ]; then echo "${USHELL} not in /etc/shells"; fi; done

# The /usr/bin/false, /bin/false, /dev/null, /sbin/nologin, /bin/sync, 
# /sbin/halt, /sbin/shutdown, (and equivalents), and sdshell will be 
# considered valid shells for use in the /etc/passwd file, but will not be 
# listed in the /etc/shells file.

# If a shell referenced in /etc/passwd is not listed in the shells file, 
# excluding the above mentioned shells, this is a finding.
#
# Fix Text: 
#
# Use the "chsh" utility or edit the /etc/passwd file and correct the 
# error by changing the default shell of the account in error to an 
# acceptable shell name contained in the /etc/shells file.

# Example:
# chsh -s /bin/bash testuser  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002140
	
# Start-Lockdown

for CURSHELL in `awk -F':' '{print $7}' /etc/passwd | sort | uniq`
do
  if [ "$CURSHELL" != "/usr/bin/false" -a "$CURSHELL" != "/bin/false" -a "$CURSHELL" != "/bin/null" -a "$CURSHELL" != "/sbin/nologin" -a "$CURSHELL" != "/bin/sync" -a "$CURSHELL" != "/bin/halt" -a "$CURSHELL" != "/bin/shutdown" -a "$CURSHELL" != "/bin/sdshell" ]
  then
    grep "$CURSHELL" /etc/shells > /dev/null
    if [ $? -ne 0 ]
    then
      echo $CURSHELL >> /etc/shells
    fi
  fi
done

# remove any that don't belong
for BADSHELL in /usr/bin/false /bin/false /dev/null /sbin/nologin /bin/sync /sbin/halt /sbin/shutdown sdshell
do

  grep "$BADSHELL" /etc/shells > /dev/null
  if [ $? -eq 0 ]
  then
    sed -i -e "\:${BADSHELL}:d" /etc/shells
  fi
done
