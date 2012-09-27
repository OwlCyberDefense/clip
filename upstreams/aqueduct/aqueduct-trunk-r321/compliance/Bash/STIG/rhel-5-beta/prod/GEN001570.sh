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
#Group ID (Vulid): V-22352
#Group Title: GEN001570
#Rule ID: SV-26454r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001570
#Rule Title: All files and directories contained in user home directories 
#must not have extended ACLs.
#
#Vulnerability Discussion: Excessive permissions allow unauthorized access 
#to user files.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the contents of user home directories for files with extended ACLs.
# cut -d : -f 6 /etc/passwd | xargs -n1 -IDIR ls -alLR DIR
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all <user file with extended ACL>    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001570
HOMEDIRS=$(cut -d: -f6 /etc/passwd|sort|uniq|xargs -n1 ls -ld |grep -v "/$"| awk '{print $9}')
#Start-Lockdown

for FIXEDHOMEDIR in $HOMEDIRS
  do
    setfacl -R --remove-all $FIXEDHOMEDIR
done

