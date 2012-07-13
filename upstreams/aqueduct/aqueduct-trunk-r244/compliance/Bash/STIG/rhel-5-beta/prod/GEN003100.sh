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
# on 30-jan-2012 to allow for "less permissive" permissions and to check the
# permissions before running a chmod.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-979
#Group Title: Cron and Crontab Directories Permissions
#Rule ID: SV-27344r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003100
#Rule Title: Cron and crontab directories must have mode 0755 or less 
#permissive.
#
#Vulnerability Discussion: To protect the integrity of scheduled 
#system jobs and to prevent malicious modification to these jobs, 
#crontab files must be secured.
#
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the mode of the crontab directories.
#
#Procedure:
# ls -ld /var/spool/cron
#
# ls -ld /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly 
#/etc/cron.monthly /etc/cron.weekly
#or
# ls -ld /etc/cron*|grep -v deny
#
#If the mode of any of the crontab directories is more permissive 
#than 0755, this is a finding.
#
#Fix Text: Change the mode of the crontab directories.
# chmod 0755 <crontab directory> 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003100

#Start-Lockdown
for CRONDIR in /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly /var/spool/cron
do

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' $CRONDIR`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7022)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&2)) != "0" ] || [ $(($FILEOTHER&2)) != "0" ]
      then
        chmod u-s,g-ws,o-wt $CRONDIR
    fi

done
