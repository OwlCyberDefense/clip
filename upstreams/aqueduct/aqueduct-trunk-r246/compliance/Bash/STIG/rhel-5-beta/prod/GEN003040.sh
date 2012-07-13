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
# to add ownership checks before running chown. 


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-11994
#Group Title: Crontabs Ownership
#Rule ID: SV-27334r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003040
#Rule Title: Crontabs must be owned by root or the crontab creator.
#
#Vulnerability Discussion: To protect the integrity of scheduled system 
#jobs and prevent malicious modification to these jobs, crontab files 
#must be secured.
#
#Responsibility: System Administrator
#IAControls: DCSL-1
#
#Check Content: 
#List all crontabs on the system.
#
# ls -lL /var/spool/cron
#
# ls -lL /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly 
#/etc/cron.monthly /etc/cron.weekly
#or
# ls -lL /etc/cron*|grep -v deny
#
#
#
#If any crontab is not owned by root or the creating user, this 
#is a finding.
#
#Fix Text: Change the crontab owner to root or the crontab creator.
# chown root <crontab file> 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003040

#Start-Lockdown
find /etc/cron.hourly /etc/cron.daily /etc/cron.weekly /etc/cron.monthly /etc/cron.d /etc/crontab /etc/cron.allow ! -user root -type f -exec chown root {} \; > /dev/null

# Make sure user crons are owned by the user or root
for USERCRON in `find /var/spool/cron -type f`
do
  USERNAME=`basename $USERCRON`
  find $USERCRON -type f ! -user $USERNAME ! -user root -exec chown $USERNAME {} \;
done

