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
#Group ID (Vulid): V-22366
#Group Title: GEN002230
#Rule ID: SV-26490r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002230
#Rule Title: All shell files must not have extended ACLs.
#
#Vulnerability Discussion: Shells with world/group write permissions 
#give the ability to maliciously modify the shell to obtain unauthorized 
#access.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#If /etc/shells exists, check the permissions of each shell referenced.
# cat /etc/shells | xargs -n1 ls -lL
#
#Otherwise, check any shells found on the system.
# find / -name "*sh" | xargs -n1 ls -lL
#
#If the permissions include a '+', the file has an extended ACL, 
#this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all [shell] 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002230
BADSHELLFILE=$( for file in `cat /etc/shells`; do getfacl --absolute-names --skip-base $file | grep "# file:" | cut -d ":" -f 2 ; done |sort | uniq )

#Start-Lockdown

for line in $BADSHELLFILE
  do
    setfacl --remove-all $line
done

