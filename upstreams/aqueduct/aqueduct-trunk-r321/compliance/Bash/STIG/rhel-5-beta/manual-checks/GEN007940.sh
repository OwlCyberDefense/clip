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
#Group ID (Vulid): V-22554
#Group Title: GEN007940
#Rule ID: SV-26229r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN007940
#Rule Title: The system must not accept source-routed IPv6 packets.
#
#Vulnerability Discussion: Source-routed packets allow the source of the 
#packet to suggest that routers forward the packet along a different path 
#than configured on the router, which can be used to bypass network 
#security measures. This requirement applies only to the handling of 
#source-routed traffic destined to the system itself, not to traffic 
#forwarded by the system to another, such as when IPv6 forwarding is 
#enabled and the system is functioning as a router.
#
#Mitigations: 
#While this filter is not available in IPv6 in some cases the use of 
#an INPUT source check (-s) defined in /etc/sysconfig/ip6tables can 
#offer similar protection and be used as a mitigation.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#The ability to control the acceptance of source_routed packets is not inherent to IPv6.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN007940

#Start-Lockdown

#Dear DISA, you want me to do what? 

# By default no source checks are defined in ip6tables, so lets make this a 
# a manual check until more information is provided.
