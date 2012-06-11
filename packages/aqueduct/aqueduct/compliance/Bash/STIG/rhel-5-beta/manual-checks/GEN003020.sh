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
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-977
#Group Title: Cron Executes Programs in World Writable Dirs
#Rule ID: SV-27332r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003020
#Rule Title: Cron must not execute programs in, or subordinate to, world-writable directories.
#
#Vulnerability Discussion: If cron programs are located in or subordinate to world-writable directories, they become vulnerable to removal and replacement by malicious users or system intruders.
#
#Responsibility: System Administrator
#IAControls: DCSL-1
#
#Check Content: 
#List all cronjobs on the system.
#Procedure:
#
# ls /var/spool/cron
#
# ls /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly
#or
# ls /etc/cron*|grep -v deny
#
#
#If cron jobs exist under any of the above directories, use the following command to search for programs executed by at:
#
# more <cron job file>
#
#Perform a long listing of each directory containing program files found in the cron file to determine if the directory is world writable.
#
# ls -ld <cron program directory>
#
#If cron executes programs in world writable directories, this is a finding.
#
#Fix Text: Remove the world-writable permission from the cron program directories identified.
#
#Procedure:
# chmod o-w <cron program directory>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003020

#Start-Lockdown
