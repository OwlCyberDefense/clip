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
#3.2 Configure TCP Wrappers and Firewall to Limit Access

#CIS Benchmark script is WRONG!
# We use this...

xyz="`tail -1 /etc/hosts.deny`"
GOODIP=$( route -n | tail -n +3 | grep -vE "^(0|169)" | awk '{print "ALL: localhost, 127.0.0., " $1 "/" $3}' )

echo "#Added for CIS Benchmark" >> /etc/hosts.allow
echo $GOODIP >> /etc/hosts.allow
echo " " >> /etc/hosts.allow

if [ "$xyz" != "ALL: ALL" ]; then
	# Only make the change once
	echo "ALL: ALL" >> /etc/hosts.deny
fi

chown root:root /etc/hosts.deny

chmod 0644 /etc/hosts.deny
