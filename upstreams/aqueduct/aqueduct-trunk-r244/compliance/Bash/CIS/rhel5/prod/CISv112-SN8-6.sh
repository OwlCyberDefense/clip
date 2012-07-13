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
#8.6 Restrict Root Logins To System Console
#Description:
#Anonymous root logins should never be allowed, except on the system 
#console, and then, ONLY in emergency situations. At all other times, 
#every administrator should access the system via an unprivileged account 
#and use some authorized mechanism (such as the su command, or the 
#freely-available sudo package) to gain additional privileges. These 
#mechanisms provide an audit trail in the event of errors, problems 
#and/or compromise.


echo console > /etc/securetty

# These are acceptable for the GUI and runlevel 3, when trimmed down to 6
  for i in `seq 1 6`; do
    echo vc/$i >> /etc/securetty
  done

chown root:root /etc/securetty

chmod 0400 /etc/securetty
