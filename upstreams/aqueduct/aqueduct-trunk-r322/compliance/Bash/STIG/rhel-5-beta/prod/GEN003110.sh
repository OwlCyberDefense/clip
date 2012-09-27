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
# on 30-jan-2012 to check for ACL's before running setfacl.



#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22387
#Group Title: GEN003110
#Rule ID: SV-26536r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003110
#Rule Title: Cron and crontab directories must not have extended ACLs.
#
#Vulnerability Discussion: To protect the integrity of scheduled 
#system jobs and to prevent malicious modification to these jobs, 
#crontab files must be secured. ACLs on cron and crontab directories 
#may provide unauthorized access to these directories. Unauthorized 
#modifications to these directories or their contents may result in 
#the addition of unauthorized cron jobs or deny service to authorized 
#cron jobs.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the crontab directories.
#
#Procedure:
# ls -ld /var/spool/cron
#
# ls -ld /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly 
#/etc/cron.monthly /etc/cron.weekly
#or
# ls -ld /etc/cron*|grep -v deny
#
#If the permissions include a '+' the directory has an extended ACL, 
#this is a finding.
#
#Fix Text: Remove the extended ACL from the directory.
# setfacl --remove-all <crontab directory>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003110

#Start-Lockdown
for CRONDIR in /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly /var/spool/cron
do
  ACLOUT=`getfacl --skip-base $CRONDIR 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all $CRONDIR
  fi
done
