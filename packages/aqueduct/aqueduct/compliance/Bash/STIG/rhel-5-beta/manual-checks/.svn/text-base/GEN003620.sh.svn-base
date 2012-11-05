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
#Group ID (Vulid): V-12003
#Group Title: Separate Filesytem Partitions
#Rule ID: SV-28619r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN003620
#Rule Title: A separate file system must be used for user home directories (such as /home or equivalent).
#
#Vulnerability Discussion: The use of separate file systems for different paths can protect the system from failures resulting from a file system becoming full or failing.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Determine if the /home path is a separate filesystem.
# grep "^/home " /etc/fstab
#If no result is returned, /home is not on a separate filesystem this is a finding.
#
#Fix Text: Migrate the /home (or equivalent) path onto a separate file system.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003620

#Start-Lockdown
