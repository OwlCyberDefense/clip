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
#SN.1 Create Symlinks For Dangerous Files
#Description:
#The /root/.rhosts, /root/.shosts, and /etc/hosts.equiv files enable a 
#weak form of access control (see the discussion of .rhosts files below). 
#Attackers will often target these files as part of their exploit scripts. 
#By linking these files to /dev/null, any data that an attacker writes to 
#these files is simply discarded (though an astute attacker can still 
#remove the link prior to writing their malicious data).

for FILE in /root/.rhosts /root/.shosts /etc/hosts.equiv /etc/shosts.equiv; do
  rm -f $FILE
  ln -s /dev/null $FILE
done