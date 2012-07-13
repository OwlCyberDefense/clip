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
#Group ID (Vulid): V-11984
#Group Title: Default/Skeleton Dot Files Ownership
#Rule ID: SV-12485r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001820
#Rule Title: All skeleton files and directories (typically in /etc/skel) 
#must be owned by root or bin.
#
#Vulnerability Discussion: If the skeleton files are not protected, 
#unauthorized personnel could change user startup parameters and possibly 
#jeopardize user files. Failure to give ownership of sensitive files or 
#utilities to root or bin provides the designated owner and unauthorized
#users with the potential to access sensitive information or change the 
#system configuration which could weaken the system's security posture.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check skeleton files ownership.
# ls -alL /etc/skel
#If a skeleton file is not owned by root or bin, this is a finding.
#
#Fix Text: Change the ownership of skeleton files with incorrect mode:
# chown root <skeleton file>
#or
# ls -L /etc/skel|xargs stat -L -c %U:%n|egrep -v "^(root|bin):"|cut -d: -f2|chown root
#will change all files not owned by root or bin to root.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001820
BADSKELOWN=$( find /etc/skel/ ! -user root ! -user bin )

#Start-Lockdown

for file in $BADSKELOWN
  do
    chown root $file
done
