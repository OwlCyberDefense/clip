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
# Group ID (Vulid): V-808
# Group Title: GEN002560
# Rule ID: SV-37898r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002560
# Rule Title: The system and user default umask must be 077.
#
# Vulnerability Discussion: The umask controls the default access mode 
# assigned to newly created files.  An umask of 077 limits new files to 
# mode 700 or less permissive.  Although umask can be represented as a 
# 4-digit number, the first digit representing special access modes is 
# typically ignored or required to be 0.  This requirement applies to the 
# globally configured system defaults and the user defaults for each 
# account on the system.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# Check global initialization files for the configured umask value.
# Procedure:
# grep umask /etc/* 

# Check local initialization files for the configured umask value.
# Procedure: 
# cut -d: -f6 /etc/passwd |xargs -n1 -IDIR find DIR -name ".*" -type f 
# -maxdepth 1 -exec grep umask {} \;

# If the system and user default umask is not 077, this a finding. 

# Note: If the default umask is 000 or allows for the creation of 
# world-writable files this becomes a Severity Code I finding.


#
# Fix Text: 
#
# Edit local and global initialization files that contain "umask" and 
# change them to use 077 instead of the current value.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002560
	
# Start-Lockdown

#Might want to adjust this later
#etc/xinetd.conf:	umask		= 002

for INITFILE in /etc/bashrc /etc/csh.cshrc /etc/csh.login /etc/profile /etc/profile.d/* `find $(awk -F':' '{if($7 ~ /.*sh/)print $6}' /etc/passwd) -maxdepth 1 -type f`
do
  grep ^[^#]*umask $INITFILE > /dev/null
  if [ $? -eq 0 ]
  then
    grep ^[^#]*umask.*077 $INITFILE > /dev/null
    if [ $? -ne 0 ]
    then
      sed -i "/^[^#]*umask/ c\umask 077" $INITFILE
    fi
  fi
done
