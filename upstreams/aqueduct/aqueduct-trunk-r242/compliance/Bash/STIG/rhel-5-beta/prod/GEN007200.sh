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
#Group ID (Vulid): V-22520
#Group Title: GEN007200
#Rule ID: SV-26876r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN007200
#Rule Title: The Internetwork Packet Exchange (IPX) protocol must be disabled or not installed.
#
#Vulnerability Discussion: The Internetwork Packet Exchange (IPX) protocol
#is a network-layer protocol that is no longer in common use. Binding
#this protocol to the network stack increases the attack surface of
#the host. Unprivileged local processes may be able to cause the
#system to dynamically load a protocol handler by opening a socket using the protocol.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#The IPX protocol handler is not part of the RHEL5 distribution. This is not a finding.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN007200

#Start-Lockdown

#So DISA says its not part of RHEL 5, so it's not a finding....  Then why have the check since this configuration guideline is for RHEL 5??
