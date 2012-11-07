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
#By Tummy a.k.a Vincent C. Passaro                                   #
#Vincent[.]Passaro[@]gmail[.]com                                     #
#www.vincentpassaro.com                                              #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 06-dec-2011|
#|          |   Creation            |                    |            |
#|__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################
#8.2 Create ftpusers Files
#Description:
#/etc/ftpusers and /etc/vsftp.ftpusers contain a list of users who are 
#not allowed to access the system via WU-FTPd and vsftpd, respectively. 
#Generally, only normal users should ever access the system via FTP-there 
#should be no reason for "system" type accounts to be transferring information 
#via this mechanism. Certainly the root account should never be allowed 
#to transfer files directly via FTP.

VSFTP_CONF="/etc/vsftpd/vsftpd.conf"
ALT_CONF="/etc/vsftpd/vsftpd.conf"

  if [ -f /etc/ftpaccess ]; then
    for NAME in `cut -d: -f1 /etc/passwd`
	do
      if [ `id -u $NAME` -lt 500 ]
	  then
      echo $NAME >> /etc/ftpusers
      fi
   done
  fi
  
chown root:root /etc/ftpusers

chmod 0600 /etc/ftpusers

if [ -e $VSFTP_CONF ] && ! grep -q "^userlist_deny=NO" $VSFTP_CONF
  then
   /bin/cp -fp /etc/ftpusers /etc/vsftpd.ftpusers
   chown root:root /etc/vsftpd/vsftpd.conf
   chmod 0600 /etc/vsftpd/vsftpd.conf
fi