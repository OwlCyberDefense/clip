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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 18-Feb-2012 to move from dev to prod and add fix.
# Updated by Vincent C. Passaro (vincent.passaro@fotisnetworks.com) to 
# check for file before running


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-23972
#Group Title: GEN007950
#Rule ID: SV-29788r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN007950
#Rule Title: The system must not respond to ICMPv6 echo requests sent to a broadcast address.
#
#Vulnerability Discussion: Responding to broadcast ICMP echo requests facilitates network mapping and provides a vector for amplification attacks.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check for an iptables rule that drops inbound IPv6 ICMP ECHO_REQUESTs sent to the all-hosts multicast address.
#
#Procedure:
# less /etc/sysconfig/ip6tables
#
#Check for a rule in, or referenced by, the INPUT chain such as:
#-A INPUT -p icmpv6 -d ff02::1 --icmpv6-type 128 -j DROP
#
#If such a rule does not exist, this is a finding.
#
#Fix Text: Add an iptables rule that drops inbound IPv6 ICMP ECHO_REQUESTs sent to the all-hosts multicast address.
#
#Edit /etc/sysconfig/ip6tables and add a rule in, or referenced by, the INPUT chain such as:
#-A INPUT -p icmpv6 -d ff02::1 --icmpv6-type 128 -j DROP
#
#Reload the iptables rules.
#Procedure:
# service ip6tables restart    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN007950

#Start-Lockdown

# ip6tables has been disabled by previous checks, but we will go ahead and
# add this line in case it needs enabled.

if [ -e /etc/sysconfig/ip6tables ]
	then
		grep 'icmpv6 \-d ff02::1' /etc/sysconfig/ip6tables > /dev/null
		if [ $? -ne 0 ]
			then
				grep 'RH-Firewall-1-INPUT' /etc/sysconfig/ip6tables > /dev/null
		if [ $? -eq 0 ]
			then
				sed -i -e 's/\(:RH-Firewall-1-INPUT.*$\)/\1\n-A INPUT -p icmpv6 -d ff02::1 --icmpv6-type 128 -j DROP/g' /etc/sysconfig/ip6tables
		else
				sed -i -e 's/\(:OUTPUT.*$\)/\1\n-A INPUT -p icmpv6 -d ff02::1 --icmpv6-type 128 -j DROP/g' /etc/sysconfig/ip6tables
		fi
		fi
else
exit 0
fi
