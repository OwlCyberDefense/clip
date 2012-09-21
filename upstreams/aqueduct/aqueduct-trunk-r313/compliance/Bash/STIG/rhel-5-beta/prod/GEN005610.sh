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
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#
#
# - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 12-feb-2012 to cut back on the output from sysctl -p.  Also split up
# check for the default and all entries. Also set to only run if enabled.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22491
#Group Title: GEN005610
#Rule ID: SV-26809r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005610
#Rule Title: The system must not have IP forwarding for IPv6 enabled, unless the system is an IPv6 router.
#
#Vulnerability Discussion: If the system is configured for IP forwarding and is not a designated router, it could be used to bypass network security by providing a path for communication not filtered by network devices.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check if the system is configured for IPv6 forwarding.
# cat /proc/sys/net/ipv6/conf/all/forwarding
#If the value is not 0, this is a finding.
#
#Fix Text: Disable IPv6 forwarding.
# echo 0 > /proc/sys/net/ipv6/conf/all/forwarding
#Disable IPv6 forwarding on startup.
#Edit /etc/sysctl.conf
#Add or edit the "net.ipv6.conf.all.forwarding" and "net.ipv6.conf.default.forwarding" settings to "0".    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005610

#Start-Lockdown

if [ -e /proc/sys/net/ipv6/conf/all/forwarding ]
then

  IP6=$( cat /proc/sys/net/ipv6/conf/all/forwarding )

  if [ "$IP6" -ne 0 ]
  then
    echo " " >> /etc/sysctl.conf
    echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
    echo "net.ipv6.conf.all.forwarding=0" >> /etc/sysctl.conf
    sysctl -p > /dev/null
  fi

fi

if [ -e /proc/sys/net/ipv6/conf/default/forwarding ]
then

  IP6DEF=$( cat /proc/sys/net/ipv6/conf/default/forwarding )

  if [ "$IP6DEF" -ne 0 ]
  then
    echo " " >> /etc/sysctl.conf
    echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
    echo "net.ipv6.conf.default.forwarding=0" >> /etc/sysctl.conf
    sysctl -p > /dev/null
  fi

fi
