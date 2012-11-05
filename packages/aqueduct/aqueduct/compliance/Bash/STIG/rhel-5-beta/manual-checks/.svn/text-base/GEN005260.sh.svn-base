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
#Group ID (Vulid): V-12018
#Group Title: X Window System Not Required and Not Disabled
#Rule ID: SV-12519r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005260
#Rule Title: X Window System connections that are not required must be disabled.
#
#Vulnerability Discussion: If unauthorized clients are permitted access to the X server, the user's X session may be compromised.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Determine if the X window system is running.
#
#Procedure:
# ps -ef |grep Xorg
#
#Ask the SA if the X window system is an operational requirement. If it is not, this is a finding.
#
#Fix Text: Disable the X Windows server on the system.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005260

#Start-Lockdown

#Manual Check.  I like Xorg, but thats just me :) 