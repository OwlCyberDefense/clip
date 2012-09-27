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

#SN.3 Enable TCP SYN Cookie Protection
#Description:
#A "SYN Attack" is a denial of service (DoS) attack that consumes 
#resources on the system forcing a reboot. This particular attack is 
#performed by beginning the TCP connection handshake (sending the SYN 
#packet), and then never completing the process to open the connection. 
#This leaves the system with several (hundreds or thousands) of half-open 
#connections. This is a fairly simple attack and should be blocked.

#CIS SHOULD be doing it like this, but thats not what the scripts check for
#Dumb.....

#echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf

#sysctl -p

#They want it done like this:

echo "echo 1 > /proc/sys/net/ipv4/tcp_syncookies" >> /etc/rc.d/rc.local

chown root:root /etc/rc.d/rc.local

chmod 0600 /etc/rc.d/rc.local


