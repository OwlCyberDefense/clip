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
#Group ID (Vulid): V-22358
#Group Title: GEN001830
#Rule ID: SV-26477r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001830
#Rule Title: All skeleton files (typically in /etc/skel) must be 
#group-owned by root, bin, sys, system, or other.
#
#Vulnerability Discussion: If the skeleton files are not protected, 
#unauthorized personnel could change user startup parameters and 
#possibly jeopardize user files.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that the skeleton files are group-owned by root.
#
#Procedure:
# ls -alL /etc/skel
#If a skeleton file is not group-owned by root, this is a finding.
#
#Fix Text: Change the group-owner of the skeleton file to root, bin, 
#sys, system, or other.
#
#Procedure:
# chgrp <group> /etc/skel/[skeleton file]
#or:
# ls -L /etc/skel|xargs stat -L -c %G:%n|egrep -v 
#"^(root|bin|sy|sytem|other):"|cut -d: -f2|chgrp root
#will change the group of all files not already one of the approved 
#group to root.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001830
BADSKELGRP=$( find /etc/skel/ ! -group root ! -group bin )

#Start-Lockdown

for file in $BADSKELGRP
  do
    chgrp root $file
done

