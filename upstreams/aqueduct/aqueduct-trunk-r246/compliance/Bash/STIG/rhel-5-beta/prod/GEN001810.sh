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
#Group ID (Vulid): V-22357
#Group Title: GEN001810
#Rule ID: SV-26473r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001810
#Rule Title: Skeleton files must not have extended ACLs.
#
#Vulnerability Discussion: If the skeleton files are not protected, 
#unauthorized personnel could change user startup parameters and possibly 
#jeopardize user files.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check skeleton files for extended ACLs:
# ls -alL /etc/skel.
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all [skeleton file with extended ACL]
#or:
# ls -lL /etc/skel|grep "\+ "|sed "s/^.* \//|xargs setfacl --remove-all
#will remove all ACLs from the files.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001810
BADSKELACL=$( getfacl -R --skip-base --absolute-names /etc/skel | grep file| awk '{print $3}' )
#Start-Lockdown

for file in $BADSKELACL
  do
    setfacl --remove-all $file
done
