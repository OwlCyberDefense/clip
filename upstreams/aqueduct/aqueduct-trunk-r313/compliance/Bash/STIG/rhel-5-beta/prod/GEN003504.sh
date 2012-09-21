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
#Group ID (Vulid): V-22402
#Group Title: GEN003504
#Rule ID: SV-26595r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN003504
#Rule Title: The centralized process core dump data directory must 
#have mode 0700 or less permissive.
#
#Vulnerability Discussion: Process core dumps contain the memory in 
#use by the process when it crashed. Any data the process was handling 
#may be contained in the core file, and it must be protected 
#accordingly. If the process core dump data directory has a mode more 
#permissive than 0700, unauthorized users may be able to view or to
#modify sensitive information contained any process core dumps in 
#the directory.
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
#Check the permissions of the directory.
# ls -lLd <core file directory>
#If the has a mode more permissive than 0700, this is a finding.
#
#Fix Text: Change the mode of the core file directory.
# chmod 0700 <core file directory>    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003504

#Start-Lockdown
COREDIR=`cat /proc/sys/kernel/core_pattern|xargs -n1 -IPATTERN dirname PATTERN`


if [ -d $COREDIR ]
then
    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' $COREDIR`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7077)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&7)) != "0" ] || [ $(($FILEOTHER&7)) != "0" ]
      then
        chmod u-s,g-rwxs,o-rwxt $COREDIR
    fi
fi

