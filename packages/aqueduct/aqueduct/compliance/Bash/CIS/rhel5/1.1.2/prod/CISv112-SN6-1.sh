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
#6.1 Capture Messages Sent To syslog AUTHPRIV Facility
#Description:
#A great deal of important security-related information is sent via 
#logging channels (e.g., network service startups, commands like usermod 
#and chage, etc). The below action causes this information to be captured 
#in the /var/log/secure file (which is only readable by the superuser). 
#This file should be reviewed and archived on a regular basis.


if [ `grep -v '^#' /etc/syslog.conf | grep -v authpriv\.none | grep -c \
  'authpriv'` -eq 0 ]
  then
  echo "Established the following record in /etc/syslog.conf"
  echo "authpriv.*\t\t\t\t/var/log/secure"
  echo -e "authpriv.*\t\t\t\t/var/log/secure" >> /etc/syslog.conf
else
  echo "syslog OK. Didn't have to change syslog.conf for authpriv; the"
  echo "following record is good:"
  grep "^authpriv" /etc/syslog.conf | grep '/var/log/secure'
fi

if [ `grep -v '^#' /etc/syslog.conf | grep -c 'auth.\*'` -eq 0 ]
  then
	echo "auth.*						/var/log/messages" >> /etc/syslog.conf
else
  echo "syslog OK. Didn't have to change syslog.conf for auth.*; the"
  echo "following record is good:"
  grep 'auth.\*' /etc/syslog.conf
fi

chmod 0600 /etc/syslog.conf

chown root:root /etc/syslog.conf



