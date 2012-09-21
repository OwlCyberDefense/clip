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
#Group ID (Vulid): V-22400
#Group Title: GEN003502
#Rule ID: SV-26578r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN003502
#Rule Title: The centralized process core dump data directory must be 
#owned by root.
#
#Vulnerability Discussion: Process core dumps contain the memory in 
#use by the process when it crashed. Any data the process was handling 
#may be contained in the core file, and it must be protected accordingly. 
#If the centralized process core dump data directory is not owned by 
#root, the core dumps contained in the directory may be subject to 
#unauthorized access.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#
#Procedure:
#Check the defined directory for process core dumps.
# cat /proc/sys/kernel/core_pattern|xargs -n1 -IPATTERN dirname PATTERN
#
#Check the existence and ownership of the directory
# ls -lLd <core file directory>
#If the directory does not exist or is not owned by root, this is a finding.
#
#Fix Text: If the core file directory does not exist it must be created.
# mkdir -p <core file directory>
#
#If necessary, change the owner of the core file directory.
# chown root <core file directory>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003502

#Start-Lockdown
COREDIR=`cat /proc/sys/kernel/core_pattern|xargs -n1 -IPATTERN dirname PATTERN`


if [ -d $COREDIR ]
then
  CUROWN=`stat -c %U $COREDIR`;

  if [ "$CUROWN" != "root" ]
  then
      chown root $COREDIR
  fi
else
  mkdir $COREDIR
  chown root $COREDIR
  chgrp root $COREDIR
  chmod 0700 $COREDIR
fi

