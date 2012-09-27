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
# Group ID (Vulid): V-11987
# Group Title: GEN001980
# Rule ID: SV-37435r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001980
# Rule Title: The .rhosts, .shosts, hosts.equiv, shosts.equiv, 
# /etc/passwd, /etc/shadow, and/or /etc/group files must not contain a plus 
# (+) without defining entries for NIS+ netgroups.
#
# Vulnerability Discussion: A plus (+) in system accounts files causes 
# the system to lookup the specified entry using NIS.  If the system is not 
# using NIS, no such entries should exist.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# Check system configuration files for plus (+) entries.

# Procedure:
# find / -name .rhosts
# grep + /<directorylocation>/.rhosts

# find / -name .shosts
# grep + /<directorylocation>/.shosts

# find / -name hosts.equiv
# grep + /<directorylocation>/hosts.equiv

# find / -name shosts.equiv
# grep + /<directorylocation>/shosts.equiv

# grep + /etc/passwd
# grep + /etc/shadow
# grep + /etc/group

# If the .rhosts, .shosts, hosts.equiv, shosts.equiv, /etc/passwd, 
# /etc/shadow, and/or /etc/group files contain a plus (+) and do not define 
# entries for NIS+ netgroups, this is a finding.
#
# Fix Text: 
#
# Edit the .rhosts, .shosts, hosts.equiv, shosts.equiv, /etc/passwd, 
# /etc/shadow, and/or /etc/group files and remove entries containing a plus 
# (+).  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001980
	
# Start-Lockdown

for ACF in `find / -fstype nfs -prune -o -name .rhosts -o -name .shosts -o -name hosts.equiv -o -name shosts.equiv 2> /dev/null` /etc/passwd /etc/shadow /etc/group
do
  grep '^+' $ACF > /dev/null
  if [ $? -eq 0 ]
  then
    sed -i -e '/^\+/d' $ACF
  fi
done


