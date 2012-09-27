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
# Group ID (Vulid): V-795
# Group Title: GEN001220
# Rule ID: SV-37216r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001220
# Rule Title: All system files, programs, and directories must be owned 
# by a system account.
#
# Vulnerability Discussion: Restricting permissions will protect the 
# files from unauthorized modification.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the ownership of system files, programs, and directories.

# Procedure:
# ls -lLa /etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin

# If any of the system files, programs, or directories are not owned by a 
# system account, this is a finding.


#
# Fix Text: 
#
# Change the owner of system files, programs, and directories to a system 
# account.

# Procedure:
# chown root /some/system/file

# (A different system user may be used in place of root.)     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001220
	
# Start-Lockdown

# Global Functions
function is_system_user {

  CURUSER=$1

  # Check that the user belongs to a system account(UID<500)
  for SYSUSER in `awk -F ':' '{if($3 < 500) print $1}' /etc/passwd`
  do
    if [ "$SYSUSER" = "$CURUSER" ]
    then
      return 0
    fi
  done

  return 1
}

# Lets go through all of the files and if they are not owned by an account
# with a uid < 500,  make the owner root.
for CHKDIR in /etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin
do

  if [ -d "$CHKDIR" ]
  then
    for FILENAME in `find $CHKDIR ! -type l`
    do

      if [ -e "$FILENAME" ]
      then
        CUROWN=`stat -c %U $FILENAME`;
        is_system_user $CUROWN
        if [ $? -ne 0 ]
        then
          chown root $FILENAME
        fi
      fi

    done  # End "for FILENAME ..." loop

  fi  # End "if [ -d $CHKDIR..." conditional

done  # End "for CHKDIR ..." for loop
