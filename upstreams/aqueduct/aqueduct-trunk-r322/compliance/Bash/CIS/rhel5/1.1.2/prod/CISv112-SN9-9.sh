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

#9.9 Set Default umask For Users
#Description:
#With a default umask setting of 077 – a setting agreed to as part of 
#a security consensus/discussion process with DISA and NSA – files and 
#directories created by users should not be readable (by default) by 
#any other human user on the system. The user creating the file has 
#the discretion of making their files and directories readable by 
#others via the chmod command. Users who wish to allow their files and 
#directories to be readable by others by default may choose a different 
#default umask by inserting the umask command into the standard shell 
#configuration files (.profile, .cshrc, etc.) in their home directories. 
#A umask of 027 would make files and directories readable by users in 
#the same Unix group, while a umask of 022 would make files readable by 
#every user on the system. A gentler umask value that many institutions 
#use is 022, due to the problems within their applications when set to 077.
CISum='077'

sed -i "s/022/077/g" /etc/bashrc
sed -i "s/002/077/g" /etc/bashrc

sed -i "s/022/077/g" /etc/csh.cshrc
sed -i "s/002/077/g" /etc/csh.cshrc

sed -i "s/022/077/g" /etc/csh.login
sed -i "s/002/077/g" /etc/csh.login

sed -i "s/027/077/g" /etc/profile

echo "umask 077" >> /etc/skel/.bashrc

sed -i "s/027/077/g" /root/.bash_profile

echo "umask 077" >> /root/.bashrc

echo "umask 077" >> /root/.cshrc

echo "umask 077" >> /root/.tcshrc

chown root:root /etc/bashrc /etc/csh.cshrc /etc/csh.login /etc/profile

chmod 0444 /etc/bashrc /etc/csh.cshrc /etc/csh.login /etc/profile

chown root:root /root/.bash_profile /root/.bashrc /root/.cshrc /root/.tcshrc

chmod 0400 /root/.bash_profile /root/.bashrc /root/.cshrc /root/.tcshrc


