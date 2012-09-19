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
#9.11 Limit Access To The Root Account From su
#Description:
#The su (Switch User) command allows a user or SysAdmin to become other 
#users on the system when needed. This is commonly used to switch users 
#(su) to "root" and execute commands as the super-user. CIS recommends 
#that it is not desirable for general unconstrained users to have the 
#freedom to su to root; therefore uncomment the following line in 
#/etc/pam.d/su, by removing the leading pound sign:
# auth required /lib/security/$ISA/pam_wheel.so use_uid

sed -i '/#[[:blank:]]*auth[[:blank:]]*required[[:blank:]]*pam_wheel.so use_uid/s/#//' /etc/pam.d/su

usermod -G wheel tester

