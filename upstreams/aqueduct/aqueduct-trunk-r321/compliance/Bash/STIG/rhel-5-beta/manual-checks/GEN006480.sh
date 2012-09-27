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
#Group ID (Vulid): V-782
#Group Title: Host-Based Intrusion Detection Tool
#Rule ID: SV-782r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006480
#Rule Title: The system must have a host-based intrusion detection tool installed.
#
#Vulnerability Discussion: Without a host-based intrusion detection tool,
#there is no system-level defense when an intruder gains access to a system or
#network. Additionally, a host-based intrusion detection tool can provide
#methods to immediately lock out detected intrusion attempts.
#
#Responsibility: System Administrator
#IAControls: ECID-1
#
#Check Content: 
#A few applications that provide host-based network intrusion protection are:
#
#- Dragon Squire by Enterasys Networks
#- ITA by Symantec
#- Hostsentry by Psionic Software
#- Logcheck by Psionic Software
#- RealSecure agent by ISS
#- Swatch by Stanford University
#
#Ask the SA or IAO if a host-based intrusion detection application is loaded on the system.
#
#Procedure:
# find / -name <daemon name>
#
#(where <daemon name> is the name of the primary application daemon) to determine if the application is loaded on the system.
#
#Determine if the application is active on the system.
#
#Procedure:
# ps -ef | grep <daemon name>
#
#If no host-based intrusion detection system is installed on the system, this is a finding.
#
#Fix Text: Install a host-based intrusion detection tool.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006480

#Start-Lockdown
