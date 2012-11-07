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
# Group ID (Vulid): V-910
# Group Title: GEN001640
# Rule ID: SV-38154r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN001640
# Rule Title: Run control scripts must not execute world-writable 
# programs or scripts.

#
# Vulnerability Discussion: World-writable files could be modified 
# accidentally or maliciously to compromise system integrity.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# Check the permissions on the files or scripts executed from system 
# startup scripts to see if they are world-writable.
# Create a list of all potential run command level scripts.
# ls -l /sbin/init.d/* | tr '\011' ' ' | tr -s ' ' | cut -f 9,9 -d " "

# Create a list of world writeable files.
# find / -perm -002 -type f >> worldWriteableFileList

# Determine if any of the world writeable files in worldWriteableFileList 
# are called from the run command level scripts. Note: Depending upon the 
# number of scripts vs world writeable files, it may be easier to inspect 
# the scripts manually.
# more `ls -l /sbin/init.d/* | tr '\011' ' ' | tr -s ' ' | cut -f 9,9 -d "` 

# If any system startup script executes any file or script that is 
# world-writable, this is a finding.

#
# Fix Text: 
#
# Remove the world-writable permission from programs or scripts executed 
# by run control scripts.

# Procedure:
# chmod o-w <program or script executed from run control script>    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001640
	
# Start-Lockdown

# Turns out there shoudn't be any world writables files by default so the list
# should be small.  For each file in the list lets check the init scripts for 
# an entry.  If the entry exists than fix it.
for WWFILE in $(find / -xdev -path /proc -prune -o -perm -002 -type f | grep -v '/proc')
do
  COMMAND=`basename $WWFILE`
  grep -r "${COMMAND}" /etc/rc.d/* > /dev/null
  if [ $? == 0 ]
  then
    chmod o-w $WWFILE
  fi

  # Check the upstart init directory if its there
  if [ -d "/etc/init" ]
  then
    grep -r "${COMMAND}" /etc/init/* > /dev/null
    if [ $? == 0 ]
    then
      chmod o-w $WWFILE
    fi
  fi
done

