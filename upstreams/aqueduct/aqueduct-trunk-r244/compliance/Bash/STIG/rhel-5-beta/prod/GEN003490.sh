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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 02-feb-2012 to check group ownership before running chgrp.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22398
#Group Title: GEN003490
#Rule ID: SV-26572r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003490
#Rule Title: The at.deny file must be group-owned by root, bin, sys, 
#or cron.
#
#Vulnerability Discussion: If the group-owner of the at.deny file is 
#not set to root, bin, sys, or cron, unauthorized users could be 
#allowed to view or edit sensitive information contained within the 
#file. Unauthorized modification could result in denial of service 
#to authorized "at" users or provide unauthorized users with the 
#ability to run "at" jobs.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the file.
#
#Procedure:
# ls -lL /etc/at.deny
#
#If the file is not group-owned by root, bin, sys, or cron, this 
#is a finding.
##
#Fix Text: Change the group ownership of the at.deny file to root, 
#sys, bin, or cron.
#
#Procedure:
# chgrp root /etc/at.deny 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003490

#Start-Lockdown
if [ -e "/etc/at.deny" ]
then

  CURGOWN=`stat -c %G /etc/at.deny`;

  if [ "$CURGOWN" != "root" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "cron" ]
  then
    chgrp root /etc/at.deny
  fi

fi
