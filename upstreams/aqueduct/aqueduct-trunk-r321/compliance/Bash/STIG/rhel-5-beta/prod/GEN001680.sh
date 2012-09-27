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
# on 14-jan-2012 to only run chgrp when needed.



#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4090
#Group Title: Run Control Scripts Group Ownership
#Rule ID: SV-27218r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001680
#Rule Title: All system start-up files must be group-owned by root, 
#sys, bin, or other group.
#
#Vulnerability Discussion: If system start-up files do not have a 
#group owner of root or a system group, the files may be modified 
#by malicious users or intruders.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check run control scripts' group ownership.
#
#Procedure:
# ls -lL /etc/rc* /etc/init.d
#
#Alternatively:
# find /etc -name "[SK][0-9]*"|xargs stat -L -c %G:%n|egrep -v 
#"^(root|sys|bin|other):"
#If any run control script is not group-owned by root, sys, bin, 
#or other system groups, this is a finding.
#
#Fix Text: Change the group ownership of the run control script(s) 
#that have incorrect group ownership.
#
#Procedure:
# chgrp root <run control script>
# find /etc -name "[SK][0-9]*"|xargs stat -L -c %G:%n|egrep -v "^(
#root|sys|bin|other):"|cut -d: -f2|xargs chgrp root 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001680

#Start-Lockdown

find /etc/rc.d/ -not -group root -not -group bin -not -group sys -exec chgrp root {} \;

