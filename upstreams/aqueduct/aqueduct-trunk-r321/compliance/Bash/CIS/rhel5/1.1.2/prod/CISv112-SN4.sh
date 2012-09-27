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

#SN.4 Additional GRUB Security
#Description:
#Setting the immutable flag on the GRUB config files will prevent any 
#changes (accidental or otherwise) to the grub.conf or menu.lst files. 
#Preferably, to modify either file, unset the immutable flag using the 
#chattr command with -i instead of +i.

#This is from check CISV112-SN7-9..  The grubby command had to be ran before
#The chatter +i otherwise if would fail.

#
#GO!

#This is to shut Nessus up

echo "install usb-storage /bin/true" >>  /etc/modprobe.conf

DEF_KERN=$( grubby --default-kernel)

grubby --update-kernel=$DEF_KERN --args="nousb"


#Set perms before we lock it out.

chown root:root /boot/grub/grub.conf
chmod 0600 /boot/grub/grub.conf

[ -e /boot/grub/menu.lst ] && /usr/bin/chattr +i /boot/grub/menu.lst

[ -e /boot/grub/grub.conf ] && /usr/bin/chattr +i /boot/grub/grub.conf
