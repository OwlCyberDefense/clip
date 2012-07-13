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

#9.1 Block Login of System Accounts
#Description:
#These accounts are non-human system accounts that should be made less 
#useful to an attacker by locking them and setting the shell to a shell 
#not in /etc/shells. They can even be deleted if the machines does not 
#use the daemon/service that each is responsible for, though it is safest 
#to simply deactivate them as is done here. To deactivate them, lock 
#the password and set the login shell to an invalid shell. /dev/null 
#is a good choice because it is not a valid login shell, and should an 
#attacker attempt to replace it with a copy of a valid shell the system 
#will not operate properly. In the remediation, 'sdiff' is used to 
#display differences side-by-side.

for NAME in `cut -d: -f1 /etc/passwd`; do
  MyUID=`id -u $NAME`
    if [ $MyUID -lt 500 -a $NAME != 'root' ]; then
    usermod -L -s /dev/null $NAME
  fi
done

chown root:root /etc/passwd

chmod 0644 /etc/passwd

chown root:root /etc/shadow

chmod 0400 /etc/shadow