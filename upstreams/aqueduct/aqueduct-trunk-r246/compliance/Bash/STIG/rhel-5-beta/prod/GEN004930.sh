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
# on 05-Feb-2012 to check group ownership before running chgrp.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22444
#Group Title: The ftpusers file ownership
#Rule ID: SV-26704r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004930
#Rule Title: The ftpusers file must be group-owned by root, bin, sys, or system.
#
#Vulnerability Discussion: If the ftpusers file is not group-owned by root or a system group, an unauthorized user may modify the file to allow unauthorized accounts to use FTP.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the ftpusers file.
#
#Procedure:
# ls -lL /etc/ftpusers /etc/vsftpd.ftpusers /etc/vsftpd/ftpusers
#
#If the file is not group-owned by root, bin, sys, or system, this is a finding.
#
#Fix Text: Change the group-owner of the ftpusers file.
#
#Procedure:
# chgrp root /etc/ftpusers /etc/vsftpd.ftpusers /etc/vsftpd/ftpusers   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004930

#Start-Lockdown

for FTPFILE in /etc/vsftpd/ftpusers /etc/vsftpd.ftpusers /etc/ftpusers
do

  if [ -a "$FTPFILE" ]
  then
    CURGROUP=`stat -c %G $FTPFILE`;
    if [  "$CURGROUP" != "root" -a "$CURGROUP" != "bin" -a "$CURGROUP" != "sys" -a "$CURGROUP" != "system" ]
    then
      chgrp root $FTPFILE
    fi
  fi

done

