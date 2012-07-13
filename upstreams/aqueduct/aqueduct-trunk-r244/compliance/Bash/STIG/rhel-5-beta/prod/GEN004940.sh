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
# on 05-Feb-2012 to check permissions before running chmod and to allow for 
# "less permissive" permissions.

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-843
#Group Title: The ftpusers file permissions
#Rule ID: SV-28414r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004940
#Rule Title: The ftpusers file must have mode 0640 or less permissive.
#
#Vulnerability Discussion: Excessive permissions on the ftpusers file could permit unauthorized modification. Unauthorized modification could result in denial of service to authorized FTP users or permit unauthorized users to access the FTP service.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the ftpusers file.
#
#Procedure:
#For gssftp:
# ls -l /etc/ftpusers
#
#For vsftp:
# ls -l /etc/vsftpd.ftpusers /etc/vsftpd/ftpusers
#If the ftpusers file has a mode more permissive than 0640, this is a finding.
#
#Fix Text: Change the mode of the ftpusers file to 0640.
#
#Procedure:
#For gssftp:
# chmod 0640 /etc/ftpusers
#
#For vsftp:
# chmod 0640 /etc/vsftpd.ftpusers /etc/vsftpd/ftpusers
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004940

#Start-Lockdown

for FTPFILE in /etc/ftpusers /etc/vsftpd.ftpusers /etc/vsftpd/ftpusers
do

  if [ -a "$FTPFILE" ]
  then

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' $FTPFILE`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7137)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&3)) != "0" ] || [ $(($FILEOTHER&7)) != "0" ]
      then
        chmod u-xs,g-wxs,o-rwxt $FTPFILE
    fi
  fi
done
