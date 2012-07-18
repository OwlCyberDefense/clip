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

#SN.7 Install and Configure sudo
#Description:
#sudo is a package that allows the SysAdmin to delegate 
#activities to groups of users. These activities are 
#normally beyond the administrative capability of that 
#user – restarting the web server, for example. If frequent 
#web server configuration changes are taking place (or the 
#system has a bug and the web server keeps crashing), it 
#becomes very cumbersome to continually engage the 
#SysAdmin just to restart the web server. sudo allows 
#the Administrator to delegate just that one task which 
#relies upon root authority without allowing that group 
#of users any other root capability.

sed -i '/#[[:blank:]]*%wheel[[:blank:]]*ALL=(ALL)[[:blank:]]*ALL/s/#//' /etc/sudoers

chown root:root /etc/sudoers

chmod 0440 /etc/sudoers
