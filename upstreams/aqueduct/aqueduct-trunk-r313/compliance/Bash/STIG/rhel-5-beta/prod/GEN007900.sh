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
#Group ID (Vulid): V-22552
#Group Title: GEN007900
#Rule ID: SV-26227r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN007900
#Rule Title: The system must use an appropriate reverse-path filter
#for IPv6 network traffic, if the system uses IPv6.
#
#Vulnerability Discussion: Reverse-path filtering provides protection
#against spoofed source addresses by causing the system to discard
#packets that have source addresses for which the system has no
#route or if the route does not point towards the interface on
#which the packet arrived. Depending on the role of the system,
#reverse-path filtering may cause legitimate traffic to be
#discarded and, therefore, should be used with a more permissive
#mode or filter, or not at all. Whenever possible, reverse-path
#filtering should be used.
#
#Mitigations: 
#Support for this filter started with the kernel used in RHEL-6.
#While this filter is not available in RHEL-5 in some cases the use
#of an INPUT source check (-s) defined in /etc/sysconfig/ip6tables
#can offer similar protection and be used as a mitigation.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#RHEL 5.x as shipped does not support stateful IPv6 firewalling.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN007900

#Start-Lockdown

#Not supported in RHEL 5...so we can't do much about this right now.  Thanks DISA for this check :) 
