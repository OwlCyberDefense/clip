#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  Vincent C. Passaro (vincent.passaro@gmail.com)
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

#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro							                     #
#Vincent[.]Passaro[@]gmail[.]com																     #
#www.vincentpassaro.com																					     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 29-Feb-2012|
#|	  	    |   Creation	          |                    |            |
#|__________|_______________________|____________________|____________|
#######################PCI INFORMATION###############################
#Risk =
#######################PCI INFORMATION###############################

#Global Variables#

#Start-Lockdown
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





