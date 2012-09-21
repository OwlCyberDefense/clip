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
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22550
#Group Title: GEN007860
#Rule ID: SV-26935r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN007860
#Rule Title: The system must ignore IPv6 ICMP redirect messages.
#
#Vulnerability Discussion: ICMP redirect messages are used by routers to inform hosts that a more direct route exists for a particular destination. These messages modify the host's route table and are unauthenticated. An illicit ICMP redirect message could result in a man-in-the-middle attack.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check that the system is configured to ignore IPv6 ICMP redirect messages.
# cat /proc/sys/net/ipv6/conf/all/accept_redirects
#If the returned value is not 0, this is a finding.
#
#Fix Text: Configure the system to ignore IPv6 ICMP redirect messages.
#Edit /etc/sysctl.conf and add a settings for "net.ipv6.conf.default.accept_redirects=0" and "net.ipv6.conf.all.accept_redirects=0".
#Restart the system for the setting to take effect.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN007860
IPV6REDIRECT=$( cat /etc/sysctl.conf| grep "net.ipv6.conf.default.accept_redirects = 0" | wc -l )
IPV6REDIRECT2=$( cat /etc/sysctl.conf| grep "net.ipv6.conf.all.accept_redirects = 0" | wc -l )
#Start-Lockdown

if [ $IPV6REDIRECT -eq 0 ]
  then
      echo "#Added for DISA GEN007860" >> /etc/sysctl.conf
      echo "net.ipv6.conf.default.accept_redirects = 0" >> /etc/sysctl.conf 
fi

if [ $IPV6REDIRECT2 -eq 0 ]
  then
      echo "#Added for DISA GEN007860" >> /etc/sysctl.conf
      echo "net.ipv6.conf.all.accept_redirects = 0" >> /etc/sysctl.conf 
fi


