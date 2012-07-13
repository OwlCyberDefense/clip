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
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 13-Feb-2012 to check permissions before running chmod and to allow for 
# "less permissive" permissions.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-1059
#Group Title: smbpasswd permissions
#Rule ID: SV-1059r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006200
#Rule Title: The /etc/samba/passdb.tdb and /etc/samba.secrets.tdb files must have mode 0600 or less permissive.
#
#Vulnerability Discussion: The smbpasswd command is used to maintain /etc/samba/passdb.tdb and /etc/samba.secrets.tdb. If either of these files has a mode more permissive than 0600, the file may be maliciously accessed or modified, potentially resulting in the compromise of Samba accounts.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the mode of files maintained using smbpasswd.
#
#Procedure:
# ls -lL /etc/samba/passdb.tdb /etc/samba.secrets.tdb
#
#If a smbpasswd maintained file has a mode more permissive than 0600, this is a finding.
#
#Fix Text: Change the mode of the files maintained through smbpasswd to 0600.
#
#Procedure:
# chmod 0600 /etc/samba/passdb.tdb and /etc/samba.secrets.tdb   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006200

#Start-Lockdown

if [ -a "/etc/samba/passdb.tdb" ]
  then

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' /etc/samba/passdb.tdb`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7177)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&7)) != "0" ] || [ $(($FILEOTHER&7)) != "0" ]
      then
        chmod u-xs,g-rwxs,o-rwxt /etc/samba/passdb.tdb
    fi
fi

if [ -a "/etc/samba.secrets.tdb" ]
  then

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' /etc/samba.secrets.tdb`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7177)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&7)) != "0" ] || [ $(($FILEOTHER&7)) != "0" ]
      then
        chmod u-xs,g-rwxs,o-rwxt /etc/samba.secrets.tdb
    fi
fi


