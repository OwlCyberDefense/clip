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
# on 05-Feb-2012 to check ownership before running chown.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-842
#Group Title: The ftpusers file ownership
#Rule ID: SV-28411r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004920
#Rule Title: The ftpusers file must be owned by root.
#
#Vulnerability Discussion: If the file ftpusers is not owned by root, an unauthorized user may modify the file to allow unauthorized accounts to use FTP.
#
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of the ftpusers file.
#
#Procedure:
#For gssftp:
# ls -l /etc/ftpusers
#
#For vsftp:
# ls -l /etc/vsftpd.ftpusers /etc/vsftpd/ftpusers
#If the ftpusers file is not owned by root, this is a finding
#
#Fix Text: Change the owner of the ftpusers file to root.
#For gssftp:
# chown root /etc/ftpusers
#
#For vsftp:
# chown root /etc/vsftpd.ftpusers /etc/vsftpd/ftpusers
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004920

#Start-Lockdown

for FTPFILE in /etc/vsftpd/ftpusers /etc/vsftpd.ftpusers /etc/ftpusers
do

  if [ -a "$FTPFILE" ]
  then
    CUROWN=`stat -c %U $FTPFILE`;
    if [ "$CUROWN" != "root" ]
      then
        chown root $FTPFILE
    fi
  fi

done
