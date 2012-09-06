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
#3 Minimize xinetd network services

for SERVICE in \
amanda \
chargen \
chargen-udp \
cups \
cups-lpd \
daytime \
daytime-udp \
echo \
echo-udp \
eklogin \
ekrb5-telnet \
finger \
gssftp \
imap \
imaps \
ipop2 \
ipop3 \
klogin \
krb5-telnet \
kshell \
ktalk \
ntalk \
rexec \
rlogin \
rsh \
rsync \
talk \
tcpmux-server \
telnet \
tftp \
time-dgram \
time-stream \
uucp;
do
if [ -e /etc/xinetd.d/$SERVICE ]; then
echo "Disabling SERVICE($SERVICE) - `ls -la /etc/xinetd.d/$SERVICE`."
chkconfig ${SERVICE} off
else
echo "OK. SERVICE doesn't exist on this system ($SERVICE)."
fi
done