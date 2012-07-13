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
#7.3 Disable User-Mounted Removable File Systems
#Description:
#In Red Hat Enterprise Linux, the pam_console PAM module gives the user 
#at the console (the machine's true physical keyboard) temporarily enhanced 
#privileges. This is configured through the /etc/security/console.perms 
#file or console.perms.d/50-default.perms. Under the Red Hat-shipped settings, 
#the console user is given ownership of the floppy and CD-ROM drive, 
#along with a host of other devices.


awk '( $1 == "<console>" ) && ( $3 !~ /sound|fb|kbd|joystick|v4l|mainboard|gpm|scanner|memstick|diskonkey/ ) { $1 = "#<console>" }; { print }' /etc/security/console.perms.d/50-default.perms >> /etc/security/console.perms.d/50-default.perms.new

mv -f /etc/security/console.perms.d/50-default.perms.new /etc/security/console.perms.d/50-default.perms

chown root:root /etc/security/console.perms

chmod 0600 /etc/security/console.perms

chmod 0600 /etc/security/console.perms.d/50-default.perms





