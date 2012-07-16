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
# on 05-Feb-2012 to add system accounts to the ftpusers file.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-841
#Group Title: The ftpusers file contents
#Rule ID: SV-28408r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004900
#Rule Title: The ftpusers file must contain account names not allowed to use FTP.
#
#Vulnerability Discussion: The ftpusers file contains a list of accounts that are not allowed to use FTP to transfer files. If the file does not contain the names of all accounts not authorized to use FTP, then unauthorized use of FTP may take place.
#
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Check the contents of the ftpusers file.
#For gssftp:
# more /etc/ftpusers
#
#For vsftp:
# more /etc/vsftpd.ftpusers /etc/vfsftpd/ftpusers
#If the system has accounts not allowed to use FTP that are not listed in the ftpusers file, this is a finding.
#
#Fix Text: 
#For gssftp:
#Add accounts not allowed to use FTP to the /etc/ftpusers file.
#For vsftp:
#Add accounts not allowed to use FTP to the /etc/vfsftpd.ftpusers or /etc/vfsftpd/ftpusers file (as appropriate). 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004900

#Start-Lockdown

# Lets assume that the system accounts shouldn't be able to log in by default.
# And leave it up to the users to add more and check as needed.
for SYSACCT in `awk -F':' '{if($3 < 500) print $1}' /etc/passwd`
do
  if [ -e /etc/vsftpd/ftpusers ]
  then
    grep "^$SYSACCT" /etc/vsftpd/ftpusers > /dev/null
    if [ $? -ne 0 ]
    then
      echo $SYSACCT >> /etc/vsftpd/ftpusers
    fi
  fi

  if [ -e /etc/vsftpd.ftpusers ]
  then
    grep "^$SYSACCT" /etc/vsftpd.ftpusers > /dev/null
    if [ $? -ne 0 ]
    then
      echo $SYSACCT >> /etc/vsftpd.ftpusers
    fi
  fi

  if [ -e /etc/ftpusers ]
  then
    grep "^$SYSACCT" /etc/ftpusers > /dev/null
    if [ $? -ne 0 ]
    then
      echo $SYSACCT >> /etc/ftpusers
    fi
  fi

done
