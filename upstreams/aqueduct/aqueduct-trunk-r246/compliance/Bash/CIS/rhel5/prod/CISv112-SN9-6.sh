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

#9.6 User Home Directories Should Be Mode 0750 or More Restrictive
#Description:
#Group or world-writable user home directories may enable malicious 
#users to steal or modify other users' data or to gain another user's 
#system privileges. Disabling "read" and "execute" access for users 
#who are not members of the same group (the "other" access category) 
#allows for appropriate use of discretionary access control by each 
#user. While the below modifications are relatively benign, making 
#global modifications to user home directories without alerting the 
#user community can result in unexpected outages and unhappy users. 
#Also, consider special case home directories such as the sftp / ftp 
#accounts used to transfer web content to a web server, typically 
#need to be world readable (r) and searchable (x) as they contain 
#documents for the web server.


for DIR in `awk -F: '( $3 >= 500 ) { print $6 }' /etc/passwd`; do
  if [ $DIR != /var/lib/nfs ]; then
    chmod -R g-w $DIR
    chmod -R o-rwx $DIR
  fi
done