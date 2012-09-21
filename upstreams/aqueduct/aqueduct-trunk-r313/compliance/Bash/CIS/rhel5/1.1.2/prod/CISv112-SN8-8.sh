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
#8.8 Require Authentication For Single-User Mode
#Description:
#By default on Red Hat Enterprise Linux, a SysAdmin can enter single 
#user mode simply by typing "linux single" at the GRUB boot-editing menu. 
#Some believe that this is left in to ease support of users with lost 
#root passwords. In any case, it represents a clear security risk – 
#authentication should always be required for root-level access. It 
#should be noted that it is extremely difficult to prevent compromise 
#by any attacker who has knowledge, tools, and full physical access 
#to a system.


if [ "`grep -l sulogin /etc/inittab`" = "" ]
  then
	awk '{ print }; /^id:[0123456sS]:initdefault:/ { print "~~:S:wait:/sbin/sulogin" }' /etc/inittab >> /etc/inittab.back

mv /etc/inittab.back /etc/inittab

fi
   
chown root:root /etc/inittab

chmod 0600 /etc/inittab
