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
#7.4 Verify passwd, shadow, and group File Permissions
#Description:
#These are the default owners and access permissions for these files. 
#It is worthwhile to periodically check these file permissions as there 
#have been package defects that changed /etc/shadow permissions to 0644. 
#Tripwire (http://www.tripwire.org/downloads/index.php) though it hasn't 
#been updated since 2001, AIDE (http://sourceforge.net/projects/aide) – 
#a successor to Tripwire, and zlister 
#(http://www.ibiblio.org/pub/linux/system/admin/zlisterProduction-1.7a) 
#are excellent products for alerting to changes in these files, and 
#others throughout the filesystem.

chown root:root /etc/group /etc/gshadow /etc/passwd /etc/shadow

chmod 0644 /etc/group /etc/passwd

chmod 0400 /etc/gshadow /etc/shadow