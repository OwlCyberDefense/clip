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
#4.14 Only Enable Printer Daemon Processes, If Absolutely Necessary
#Description:
#If users will never print files from this machine and the system will 
#never be used as a print server by other hosts on the network, then it 
#is safe to disable the print daemon, lpd or cupsd, and removed the 
#relevant packages from the system. The Unix print servers have generally 
#had a poor security record be sure to keep up-to-date on vendor 
#patches, if such services are required.


CUPSRPM=$(rpm -qa|grep cups-libs)

chown root:lp /etc/cups/client.conf

chmod 0644    /etc/cups/client.conf

 chown lp:sys /etc/cups/cupsd.conf

chmod 0600   /etc/cups/cupsd.conf

rpm -e bluez-utilz-cups --nodeps

rpm -e bluez-cups --nodeps

rpm -e cups --nodeps

rpm -e libgnomecups --nodeps

for line in $CUPSRPM
  do
    rpm -e $line --nodeps
done

#rpm -e cups-libs --nodeps

rpm -e hal-cups-utils --nodeps
