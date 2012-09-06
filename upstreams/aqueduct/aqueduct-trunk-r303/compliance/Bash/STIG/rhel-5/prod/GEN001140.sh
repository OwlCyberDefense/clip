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
# Group ID (Vulid): V-784
# Group Title: GEN001140
# Rule ID: SV-37159r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001140
# Rule Title: System files and directories must not have uneven access 
# permissions.
#
# Vulnerability Discussion: Discretionary access control is undermined if 
# users, other than a file owner, have greater access permissions to system 
# files and directories than the owner.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# Check system directories for uneven file permissions.

# Procedure:
# ls -lL /etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin

# Uneven file permissions exist if the file owner has less permissions than 
# the group or other user classes. If any of the files in the above listed 
# directories contain uneven file permissions, this is a finding.


#
# Fix Text: 
#
# Change the mode of files with uneven permissions so owners do not have 
# less permission than group or world users.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001140
	
# Start-Lockdown

for CHKDIR in /etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin
do
  if [ -d "$CHKDIR" ]
  then
    for FILENAME in `find $CHKDIR`
    do

      if [ -e "$FILENAME" ]
      then
        # Pull the actual permissions
        FILEPERMS=`stat -L --format='%04a' $FILENAME`

        # Break the actual file octal permissions up per entity
        FILESPECIAL=${FILEPERMS:0:1}
        FILEOWNER=${FILEPERMS:1:1}
        FILEGROUP=${FILEPERMS:2:1}
        FILEOTHER=${FILEPERMS:3:1}

        # If 'read' is NOT set on the owner and set on 'group' turn it off
        if [ $(($FILEOWNER&4)) -eq 0 -a $(($FILEGROUP&4)) -ne 0 ]
        then
	  chmod g-r $FILENAME
        fi

        # If 'read' is NOT set on the owner and set on 'other' turn it off
        if [ $(($FILEOWNER&4)) -eq 0 -a $(($FILEOTHER&4)) -ne 0 ]
        then
	  chmod o-r $FILENAME
        fi

        # If 'write' is NOT set on the owner and set on 'group' turn it off
        if [ $(($FILEOWNER&2)) -eq 0 -a $(($FILEGROUP&2)) -ne 0 ]
        then
	  chmod g-w $FILENAME
        fi

        # If 'write' is NOT set on the owner and set on 'other' turn it off
        if [ $(($FILEOWNER&2)) -eq 0 -a $(($FILEOTHER&2)) -ne 0 ]
        then
	  chmod o-w $FILENAME
        fi

        # If 'exec' is NOT set on the owner and set on 'group' turn it off
        if [ $(($FILEOWNER&1)) -eq 0 -a $(($FILEGROUP&1)) -ne 0 ]
        then
	  chmod g-x $FILENAME
        fi

        # If 'exec' is NOT set on the owner and set on 'other' turn it off
        if [ $(($FILEOWNER&1)) -eq 0 -a $(($FILEOTHER&1)) -ne 0 ]
        then
	  chmod o-x $FILENAME
        fi

      fi

    done
  fi
done
