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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 02-jan-2011 to add content and move from dev to prod.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22401
#Group Title: GEN003503
#Rule ID: SV-26581r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN003503
#Rule Title: The centralized process core dump data directory must be 
#group-owned by root, bin, sys, or system.
#
#Vulnerability Discussion: Process core dumps contain the memory in 
#use by the process when it crashed. Any data the process was handling 
#may be contained in the core file, and it must be protected accordingly. 
#If the centralized process core dump data directory is not group-owned 
#by a system group, the core dumps contained in the directory may be 
#subject to unauthorized access.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the defined directory for process core dumps.
#
#Procedure:
# cat /proc/sys/kernel/core_pattern
#Check the group ownership of the directory
# ls -lLd <core file directory>
#If the directory is not group-owned by root, this is a finding.
#
#Fix Text: Change the group-owner of the core file directory.
# chgrp root <core file directory>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003503

#Start-Lockdown
COREDIR=`cat /proc/sys/kernel/core_pattern|xargs -n1 -IPATTERN dirname PATTERN`

if [ -d $COREDIR ]
then
  CURGOWN=`stat -c %G $COREDIR`;

  if [ "$CURGOWN" != "root" ]
  then
      chgrp root $COREDIR
  fi
fi
