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
#Group ID (Vulid): V-23738
#Group Title: GEN003623
#Rule ID: SV-28630r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN003623
#Rule Title: The system must use a separate file system for the system audit data path.
#
#Vulnerability Discussion: The use of separate file systems for different paths can protect the system from failures resulting from a file system becoming full or failing.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Determine if the /var/log/audit path is a separate filesystem.
# grep "^/var/log/audit " /etc/fstab
#If no result is returned, /var/log/audit is not on a separate filesystem this is a finding.
#
#Fix Text: Migrate the /var/log/audit path onto a separate filesystem.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003623

#Start-Lockdown
