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
# on 18-Feb-2012 to move from dev to prod and add the fix
#Updated by Vincent C. Passaro (vincent.passaro@fotisnetworks.com) to 
#check for file before trying to execute. 

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22517
#Group Title: GEN007140
#Rule ID: SV-26192r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN007140
#Rule Title: The Lightweight User Datagram Protocol (UDP-Lite) must 
#be disabled unless required.
#
#Vulnerability Discussion: The Lightweight User Datagram Protocol (UDP-Lite)
#is a proposed transport layer protocol. This protocol is not yet widely used.
#Binding this protocol to the network stack increases the attack surface of the
#host. Unprivileged local processes may be able to cause the system to
#dynamically load a protocol handler by opening a socket using the protocol.
#
#Mitigations: 
#This may be mitigated by creating an iptable rule to drop all udplite traffic.
#This is done by modifying /etc/sysconfig/iptables to include
#the line "-A INPUT -p udplite -j DROP". Once the modification is made
#reload the tables using the command "service iptables restart".
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#If there is no UDP-Lite protocol handler available for the system, 
#this is not applicable.
#Determine if the UDP-Lite protocol handler is prevented from dynamic 
#loading. If it is not, this is a finding.
#
#Fix Text: Configure the system to prevent the dynamic loading of the 
#UDP-Lite protocol handler. 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN007140

#Start-Lockdown

if [ -e /etc/sysconfig/iptables ]
	then
		grep '\-A INPUT \-p udplite \-j DROP' /etc/sysconfig/iptables > /dev/null
		if [ $? -ne 0 ]
			then
				service iptables start > /dev/null
				iptables -I INPUT -p udplite -j DROP
				service iptables save > /dev/null
		fi
fi

