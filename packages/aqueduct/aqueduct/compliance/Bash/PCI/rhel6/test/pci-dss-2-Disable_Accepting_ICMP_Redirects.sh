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
#By Tummy a.k.a Vincent C. Passaro							                     #
#Vincent[.]Passaro[@]gmail[.]com																     #
#www.vincentpassaro.com																					     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 29-Feb-2012|
#|	  	    |   Creation	          |                    |            |
#|__________|_______________________|____________________|____________|
#######################PCI INFORMATION###############################
#Risk =
#######################PCI INFORMATION###############################

#Global Variables#

#Start-Lockdown

IPREDIREECTS=$( cat /proc/sys/net/ipv4/conf/all/accept_redirects )
IPREDIREECTSDEF=$( cat /proc/sys/net/ipv4/conf/default/accept_redirects )
IPV6REDIRECT=$( cat /etc/sysctl.conf| grep "net.ipv6.conf.default.accept_redirects = 0" | wc -l )
IPV6REDIRECT2=$( cat /etc/sysctl.conf| grep "net.ipv6.conf.all.accept_redirects = 0" | wc -l )
#Start-Lockdown

if [ $IPREDIREECTS -ne 0 ]
then
  echo " " >> /etc/sysctl.conf
  echo "#Added for PCI DSS" >> /etc/sysctl.conf
  echo "net.ipv4.conf.all.accept_redirects=0" >> /etc/sysctl.conf
  sysctl -p > /dev/null
fi

if [ $IPREDIREECTSDEF -ne 0 ]
then
  echo " " >> /etc/sysctl.conf
  echo "#Added by Aqueduct for PCI DSS" >> /etc/sysctl.conf
  echo "net.ipv4.conf.default.accept_redirects=0" >> /etc/sysctl.conf
  sysctl -p > /dev/null
fi


if [ $IPV6REDIRECT -eq 0 ]
  then
      echo "#Added for PCI DSS" >> /etc/sysctl.conf
      echo "net.ipv6.conf.default.accept_redirects = 0" >> /etc/sysctl.conf 
fi

if [ $IPV6REDIRECT2 -eq 0 ]
  then
      echo "#Added for PCI DSS" >> /etc/sysctl.conf
      echo "net.ipv6.conf.all.accept_redirects = 0" >> /etc/sysctl.conf 
fi
