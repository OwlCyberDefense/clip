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
# on 30-jan-2012 to check group ownership before running chown.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-981
#Group Title: Cron and Crontab Directories Group Ownership
#Rule ID: SV-27348r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003140
#Rule Title: Cron and crontab directories must be group-owned by root, 
#sys, bin or cron.
#
#Vulnerability Discussion: To protect the integrity of scheduled system 
#jobs and to prevent malicious modification to these jobs, crontab files 
#must be secured. Failure to give group-ownership of cron or crontab 
#directories to a system group provides the designated group and 
#unauthorized users with the potential to access sensitive information 
#or change the system configuration which could weaken the system's 
#security posture.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group owner of cron and crontab directories.
#
#Procedure:
# ls -ld /var/spool/cron
#
# ls -ld /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly 
#/etc/cron.monthly /etc/cron.weekly
#or
# ls -ld /etc/cron*|grep -v deny
#
#
#If a directory is not group-owned by root, sys, bin, or cron, 
#this is a finding.
#
#Fix Text: Check the group owner of cron and crontab directories.
# chgrp root <crontab directory>    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003140

#Start-Lockdown
for CRONDIR in /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly /var/spool/cron
do
  CURGOWN=`stat -c %G $CRONDIR`;

  if [ "$CURGOWN" != "root" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "cron" ]
  then
    chgrp root $CRONDIR
  fi
done
