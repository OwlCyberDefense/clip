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
# Group ID (Vulid): V-22358
# Group Title: GEN001830
# Rule ID: SV-37237r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001830
# Rule Title: All skeleton files (typically in /etc/skel) must be 
# group-owned by root, bin, sys, system, or other.
#
# Vulnerability Discussion: If the skeleton files are not protected, 
# unauthorized personnel could change user startup parameters and possibly 
# jeopardize user files.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Verify the skeleton files are group-owned by root.

# Procedure:
# ls -alL /etc/skel
# If a skeleton file is not group-owned by root, bin, sys, system, or other 
# this is a finding.
#
# Fix Text: 
#
# Change the group-owner of the skeleton file to root, bin, sys, system, 
# or other.

# Procedure:
# chgrp <group> /etc/skel/[skeleton file]
# or:
# ls -L /etc/skel|xargs stat -L -c %G:%n|egrep -v 
# "^(root|bin|sy|sytem|other):"|cut -d: -f2|chgrp root
# will change the group of all files not already one of the approved group 
# to root.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001830
	
# Start-Lockdown

# find fails with bad groups.  Lets make the filter dynamic and check for 
# existing groups.
GRPFILTER=''
for GRP in root bin sys system other
do
  getent group $GRP > /dev/null
  if [ $? == 0 ]
  then
    GRPFILTER="$GRPFILTER ! -group $GRP"
  fi
done

find /etc/skel/ ${GRPFILTER} -exec chgrp root {} \; 



