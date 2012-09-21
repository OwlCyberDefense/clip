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
#Group ID (Vulid): V-22403
#Group Title: GEN003505
#Rule ID: SV-26600r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN003505
#Rule Title: The centralized process core dump data directory must not 
#have an extended ACL.
#
#Vulnerability Discussion: Process core dumps contain the memory in use 
#by the process when it crashed. Any data the process was handling may be 
#contained in the core file, and it must be protected accordingly. If 
#the process core dump data directory has an extended ACL, unauthorized 
#users may be able to view or to modify sensitive information contained 
#any process core dumps in the directory.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the defined directory for process core dumps.
#
#Procedure:
#Check the defined directory for process core dumps.
# cat /proc/sys/kernel/core_pattern|xargs -n1 -IPATTERN dirname PATTERN
#
#Check the permissions of the directory.
# ls -lLd <core file directory>
#If the permissions include a '+', the file has an extended ACL, 
#this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all <core file directory>    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003505

#Start-Lockdown
COREDIR=`cat /proc/sys/kernel/core_pattern|xargs -n1 -IPATTERN dirname PATTERN`


if [ -d $COREDIR ]
then

  if [ -a "$COREDIR" ]
  then

    ACLOUT=`getfacl --skip-base $COREDIR 2>/dev/null`;
    if [ "$ACLOUT" != "" ]
      then
      setfacl --remove-all $COREDIR
    fi

  fi

fi

