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
# on 12-feb-2012 to cut back on the output from sysctl -p.  


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-12023
#Group Title: Disable IP Forwarding
#Rule ID: SV-28438r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005600
#Rule Title: IP forwarding for IPv4 must not be enabled, unless the system is a router.
#
#Vulnerability Discussion: If the system is configured for IP forwarding and is not a designated router, it could be used to bypass network security by providing a path for communication not filtered by network devices.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check if the system is configured for IPv4 forwarding.
#
#Procedure:
# cat /proc/sys/net/ipv4/ip_forward
#
#If the value is set to 1, IPv4 forwarding is enabled this is a finding.
#
#Fix Text: Edit /etc/sysctl.conf and set net.ipv4.ip_forward to 0. Restart the system or run "sysctl -p" to make the change take effect.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005600
IPFORWARD=$( cat /proc/sys/net/ipv4/ip_forward )
#Start-Lockdown

if [ $IPFORWARD -eq 1 ]
  then
  sed -i "/net\.ipv4\.ip_forward/ c\
  net.ipv4.ip_forward = 0" /etc/sysctl.conf
  sysctl -p > /dev/null
fi

    
