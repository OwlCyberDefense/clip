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
#8.1 Remove .rhosts Support In PAM Configuration Files
#Description:
#Used in conjunction with the BSD-style "r-commands" (rlogin, rsh, rcp), 
#the .rhosts files implement a weak form of authentication based on the 
#network address or host name of the remote computer (which can be spoofed 
#by a potential attacker to exploit the local system). Disabling .rhosts 
#support helps prevent users from subverting the system's normal access 
#control mechanisms. On a system with RHEL5, PAM documentation can be 
#found under "/usr/share/doc/pam-0.99.7.1/txts".

#Force Deleteion...false positives from Nessus
sed -i 's/^auth       required     pam_rhosts_auth.so//g' /etc/pam.d/*
sed -i 's/#auth       required     pam_rhosts_auth.so//g' /etc/pam.d/*

chown -R root:root /etc/pam.d/*

chmod 644 /etc/pam.d/*





