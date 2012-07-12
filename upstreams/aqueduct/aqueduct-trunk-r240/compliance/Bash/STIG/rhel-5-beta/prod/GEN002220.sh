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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 16-jan-2012 to check for permissions with find before running the chmod.

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-922
#Group Title: Shell Permissions
#Rule ID: SV-922r6_rule
#Severity: CAT I
#Rule Version (STIG-ID): GEN002220
#Rule Title: All shell files must have mode 0755 or less permissive.
#
#Vulnerability Discussion: Shells with world/group write permissions 
#give the ability to maliciously modify the shell to obtain unauthorized 
#access.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#If /etc/shells exists, check the group ownership of each shell referenced.
# cat /etc/shells | xargs -n1 ls -l
#
#Otherwise, check any shells found on the system.
# find / -name "*sh" | xargs -n1 ls -l
#
#If a shell has a mode more permissive than 0755, this is a finding.
#
#Fix Text: Change the mode of the shell.
# chmod 0755 <shell>    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002220

#Start-Lockdown
find -L /bin/bash /sbin/nologin /bin/tcsh /bin/csh /bin/ksh /bin/sync /sbin/shutdown /sbin/halt -perm /7022 -exec chmod u-s,g-ws,o-wt {} \; 2> /dev/null
