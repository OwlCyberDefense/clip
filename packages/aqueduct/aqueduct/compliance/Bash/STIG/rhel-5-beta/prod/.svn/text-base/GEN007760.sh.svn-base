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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com
# on 18-Feb-2012 to check before running the fix and fix a few typos. 


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22544
#Group Title: GEN007760
#Rule ID: SV-29600r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN007760
#Rule Title: Proxy Neighbor Discovery Protocol (NDP) must not be enabled on the system.
#
#Vulnerability Discussion: Proxy Neighbor Discovery Protocol (NDP) allows a system to respond to NDP requests on one interface on behalf of hosts connected to another interface. If this function is enabled when not required, addressing information may be leaked between the attached network segments.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Determine if the system has proxy NDP capability, and if it is enabled.
#
#Procedure:
# ls -lL /proc/sys/net/ipv6/conf/* |grep proxy_ndp
#
#If the file is not found, the kernel does not have proxy NDP capability, and this is not a finding.
#If the file has a value of "0", proxy NDP is not enabled, and this is not a finding. If the file has a value of "1", proxy NDP is enabled, this is a finding.
#
#Fix Text: Disable proxy NDP on the system.
#
#Procedure:
# echo "net.ipv6.proxy_ndp = 0" >> /etc/sysctl.conf
# sysctl -p   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN007760

#Start-Lockdown

if [ -e /proc/sys/net/ipv6/conf/proxy_ndp ]
then
  
  $NDP=`sysctl -n net.ipv6.conf.proxy_ndp`
  if [ $NDP -eq 0 ]
  then
    echo "#Added for DISA GEN007760" >> /etc/modprobe.conf
    echo "net.ipv6.conf.proxy_ndp = 0" >> /etc/sysctl.conf 
    sysctl -p > /dev/null
  fi
fi
