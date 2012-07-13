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
#By Tummy a.k.a Vincent C. Passaro							                     #
#Vincent[.]Passaro[@]gmail[.]com																     #
#www.vincentpassaro.com																					     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 29-Feb-2012|
#|	  	    |   Creation	          |                    |            |
#|__________|_______________________|____________________|____________|
#######################PCI INFORMATION###############################
#Risk =
#######################PCI INFORMATION###############################

#Global Variables#

#Start-Lockdown

#Might want to adjust this later
#etc/xinetd.conf:       umask           = 002

for INITFILE in /etc/bashrc /etc/csh.cshrc /etc/csh.login /etc/profile /etc/profile.d/* `find $(awk -F':' '{if($7 ~ /.*sh/)print $6}' /etc/passwd) -maxdepth 1 -type f`
do
  grep ^[^#]*umask $INITFILE > /dev/null
  if [ $? -eq 0 ]
  then
    grep ^[^#]*umask.*077 $INITFILE > /dev/null
    if [ $? -ne 0 ]
    then
      sed -i "/^[^#]*umask/ c\umask 077" $INITFILE
    fi
  fi
done
