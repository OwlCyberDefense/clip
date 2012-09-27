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
# on 04-feb-2012 to cut back on the output from sysctl -p.  Also split up
# check for the default and all entries.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22420
#Group Title: GEN003613
#Rule ID: SV-26635r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003613
#Rule Title: The system must use a reverse-path filter for IPv4 network traffic when possible.
#
#Vulnerability Discussion: Reverse-path filtering provides protection against spoofed source addresses by causing the system to discard packets that have source addresses for which the system has no route or if the route does not point towards the interface on which the packet arrived. Reverse-path filtering should be used whenever possible. Depending on the role of the system, reverse-path filtering may cause legitimate traffic to be discarded and, therefore, should be used in a more permissive mode or not at all.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check that the system configured to use a reverse-path filter for IPv4 network traffic.
# cat /proc/sys/net/ipv4/conf/all/rp_filter
#If the result is 0, this is a finding.
#
#Fix Text: Configure the system to use a reverse-path filter for IPv4 network traffic.
#Edit /etc/sysctl.conf and add a setting for "net.ipv4.conf.all.rp_filter=1" and "net.ipv4.conf.default.rp_filter=1".
# sysctl -p 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003613
RPFILTER=$( cat /proc/sys/net/ipv4/conf/all/rp_filter )
RPFILTERDEF=$( cat /proc/sys/net/ipv4/conf/default/rp_filter )

#Start-Lockdown

if [ $RPFILTER -ne 1 ]
then
  echo " " >> /etc/sysctl.conf
  echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
  echo "net.ipv4.conf.all.rp_filter=1" >> /etc/sysctl.conf
  sysctl -p > /dev/null
fi

if [ $RPFILTERDEF -ne 1 ]
then
  echo " " >> /etc/sysctl.conf
  echo "#Added by STIG check $PDI" >> /etc/sysctl.conf
  echo "net.ipv4.conf.default.rp_filter=1" >> /etc/sysctl.conf
  sysctl -p > /dev/null
fi
