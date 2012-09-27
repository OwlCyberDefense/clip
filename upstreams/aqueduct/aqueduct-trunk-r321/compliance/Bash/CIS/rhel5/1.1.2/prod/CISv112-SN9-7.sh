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

#9.7 No User Dot-Files Should Be World-Writable
#Description:
#World-writable user configuration files may enable malicious users to 
#steal or modify other users' data or to gain another user's system 
#privileges. While the below modifications are relatively benign, making 
#global modifications to user home directories without alerting the 
#user community can result in unexpected outages and unhappy users.



for DIR in `awk -F: '($3 >= 500) { print $6 }' /etc/passwd`; do
  for FILE in $DIR/.[A-Za-z0-9]*; do
    if [ ! -h "$FILE" -a -f "$FILE" ]; then
      chmod go-w "$FILE"
    fi
  done
done