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
#Group ID (Vulid): V-4365
#Group Title: The at directory ownership
#Rule ID: SV-4365r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003420
#Rule Title: The "at" directory must be owned by root, bin, or sys.
#
#Vulnerability Discussion: If the owner of the "at" directory is not root, 
#bin, sys, unauthorized users could be allowed to view or edit files 
#containing sensitive information within the directory.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of the "at" directory:
#
#Procedure:
# ls -ld /var/spool/cron/atjobs /var/spool/atjobs /var/spool/at
#
#If the directory is not owned by root, sys, bin, daemon, or cron, 
#this is a finding.
#
#Fix Text: Change the owner of the "at" directory to root, bin, sys, 
#or system.
#
#Procedure:
# chown <root or other system account> <"at" directory>    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003420

#Start-Lockdown
for ATFILE in /var/spool/cron/atjobs /var/spool/atjobs /var/spool/at
do

  if [ -a "$ATFILE" ]
  then

    CUROWN=`stat -c %U $ATFILE`;

    if [ "$CUROWN" != "root" -a "$CUROWN" != "sys" -a "$CUROWN" != "bin" -a "$CUROWN" != "daemon" -a "$CUROWN" != "system" -a "$CUROWN" != "cron" ]
      then
        chown daemon $ATFILE
    fi

  fi

done
