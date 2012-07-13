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
#9.10 Disable Core Dumps
#Description:
#Core dumps can consume large volumes of disk space and may contain 
#sensitive data. On the other hand, developers using this system may 
#require core files in order to aid in debugging. The limits.conf file 
#can be used to grant core dump ability to individual users or groups 
#of users.
#It should be noted that user accounts get this applied to them 
#automatically, via /etc/profile. It sets this soft limit to zero,
#by default (via: ulimit -S -c 0).

#echo "* - core 0" >> /etc/security/limits.conf

echo "*                hard    core            0" >> /etc/security/limits.conf

echo "*                soft    core            0" >> /etc/security/limits.conf

chown root:root /etc/security/limits.conf

chmod 0644 /etc/security/limits.conf
