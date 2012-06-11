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
# on 05-Feb-2012 to add the gssftp ftpusers file if installed.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-840
#Group Title: The ftpusers file
#Rule ID: SV-28405r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004880
#Rule Title: The ftpusers file must exist.
#
#Vulnerability Discussion: The ftpusers file contains a list of accounts that are not allowed to use FTP to transfer files. If this file does not exist, then unauthorized accounts can utilize FTP.
#
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Check for the existence of the ftpusers file.
#
#Procedure:
#For gssftp:
# ls -l /etc/ftpusers
#
#For vsftp:
# ls -l /etc/vsftpd.ftpusers
#or
# ls -l /etc/vsftpd/ftpusers
#
#If the appropriate ftpusers file for the running FTP service does not exist, this is a finding.
#
#Fix Text: Create an ftpusers file appropriate for the running FTP service.
#For gssftp:
#Create an /etc/ftpusers file containing a list of accounts not authorized for FTP.
#
#For vsftp:
#Create an /etc/vfsftpd.ftpusers or /etc/vfsftpd/ftpusers (as appropriate) file containing a list of accounts not authorized for FTP.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004880

ISINSTALLED=$( rpm -qa|grep -ci vsftpd )

#Start-Lockdown

#Check if vsftpd is installed

if [ $ISINSTALLED -eq 1 ]
  then
    if [ ! -f /etc/vsftpd/ftpusers ]
      then
        touch /etc/vsftpd/ftpusers
    fi
fi


if [ -e /etc/xinetd.d/gssftp ]
then
    if [ ! -f /etc/ftpusers ]
    then
        touch /etc/ftpusers
    fi
fi
