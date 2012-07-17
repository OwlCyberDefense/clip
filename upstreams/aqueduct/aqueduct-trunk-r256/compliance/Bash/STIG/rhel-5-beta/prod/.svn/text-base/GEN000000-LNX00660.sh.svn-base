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
#By Tummy a.k.a Vincent C. Passaro				     #
#Vincent[.]Passaro[@]gmail[.]com	         		     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#
#
#  - Updated by Shannon Mitchell shannon.mitchell@fusiontechnology-llc.com)
# on 28-dec-2011 to check the permissions before running the chmod command.
# Fixed the chmod command to allow for "less permissive" permissions.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-12040
#Group Title: /etc/securetty permissions
#Rule ID: SV-12541r2_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000000-LNX00660
#Rule Title: The /etc/securetty file must have mode 0640 or less permissive.
#
#Vulnerability Discussion: The securetty file contains the list of 
#terminals that permit direct root logins. It must be protected from 
#unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check /etc/securetty permissions.
#
#Procedure:
# ls -lL /etc/securetty
#
#If /etc/securetty has a mode more permissive than 0640, this is a finding.
#
#Fix Text: Change the mode of the /etc/securetty file to 0640.
#
#Procedure:
# chmod 0640 /etc/securetty  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000000-LNX00660

#Start-Lockdown

if [ -a "/etc/securetty" ]
  then
    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' /etc/securetty`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7137)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&3)) != "0" ] || [ $(($FILEOTHER&7)) != "0" ]
      then
        chmod u-xs,g-wxs,o-rwxt /etc/securetty
    fi
  else
    echo "------------------------------" > $PDI-error.log
    date >> $PDI-error.log
    echo " " >> $PDI-error.log
    echo "/etc/securetty does not exist." >> $PDI-error.log
    echo "Could not change permissions to 0640" >> $PDI-error.log
    echo "------------------------------" >> $PDI-error.log
fi

