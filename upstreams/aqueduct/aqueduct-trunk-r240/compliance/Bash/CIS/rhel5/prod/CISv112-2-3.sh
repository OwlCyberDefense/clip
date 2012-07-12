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

#This check will always fail if you dont have pub key setup properly...


#First the ssh config

sed -i 's/#   Port 22/   Port 22/g' /etc/ssh/ssh_config

echo 'Protocol 2' >> /etc/ssh/ssh_config


#Next, the SSHD Config


if [ `grep -c "^Protocol" /etc/ssh/sshd_config` -gt 0 ]
then
        sed -i "/^#Protocol/ c\Protocol 2" /etc/ssh/sshd_config
else
        echo "Protocol 2" >> /etc/ssh/sshd_config
fi

sed -i "s/#PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
	sed -i "s/#PermitRootLogin no/PermitRootLogin no/g" /etc/ssh/sshd_config
		sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config

sed -i "/^#Banner/ c\Banner /etc/issue.net" /etc/ssh/sshd_config

 
sed -i "s/#LogLevel INFO/LogLevel VERBOSE/g" /etc/ssh/sshd_config

sed -i "s/#Port 22/Port 22/g"  /etc/ssh/sshd_config

sed -i "s/#RhostsRSAAuthentication no/RhostsRSAAuthentication no/g" /etc/ssh/sshd_config
	sed -i "s/#RhostsRSAAuthentication yes/RhostsRSAAuthentication no/g" /etc/ssh/sshd_config
		sed -i "s/RhostsRSAAuthentication yes/RhostsRSAAuthentication no/g" /etc/ssh/sshd_config
		
sed -i "s/#HostbasedAuthentication no/HostbasedAuthentication no/g" /etc/ssh/sshd_config
	sed -i "s/#HostbasedAuthentication yes/HostbasedAuthentication no/g" /etc/ssh/sshd_config
		sed -i "s/HostbasedAuthentication yes/HostbasedAuthentication no/g" /etc/ssh/sshd_config

sed -i "s/#IgnoreRhosts yes/IgnoreRhosts yes/g" /etc/ssh/sshd_config
	sed -i "s/#IgnoreRhosts no/IgnoreRhosts yes/g" /etc/ssh/sshd_config
		sed -i "s/IgnoreRhosts no/IgnoreRhosts yes/g" /etc/ssh/sshd_config
		
sed -i "s/#PermitEmptyPasswords yes/PermitEmptyPasswords no/g" /etc/ssh/sshd_config
	sed -i "s/#PermitEmptyPasswords no/PermitEmptyPasswords no/g" /etc/ssh/sshd_config
		sed -i "s/PermitEmptyPasswords yes/PermitEmptyPasswords no/g" /etc/ssh/sshd_config


