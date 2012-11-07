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
#Group ID (Vulid): V-12017
#Group Title: X Client Authorization
#Rule ID: SV-12518r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005240
#Rule Title: The .Xauthority utility must only permit access to authorized hosts.
#
#Vulnerability Discussion: If unauthorized clients are permitted access to the X server, the user's X session may be compromised.
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Check the X window system access is limited to authorized clients.
#
#Procedure:
# xauth
#xauth> list
#
#Ask the SA if the clients listed are authorized. If any are not, this is a finding.
#
#Fix Text: Remove unauthorized clients from the xauth configuration.
# xauth remove <display name>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005240

#Start-Lockdown

#Manual check....
