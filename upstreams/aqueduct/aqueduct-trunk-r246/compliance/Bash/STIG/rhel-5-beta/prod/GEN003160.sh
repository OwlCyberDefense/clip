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
#Group ID (Vulid): V-982
#Group Title: Cron Logging
#Rule ID: SV-27352r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003160
#Rule Title: Cron logging must be implemented.
#
#Vulnerability Discussion: Cron logging can be used to trace the 
#successful or unsuccessful execution of cron jobs. It can also be 
#used to spot intrusions into the use of the cron facility by 
#unauthorized and malicious users.
#
#
#Responsibility: System Administrator
#IAControls: ECAR-1, ECAR-2, ECAR-3
#
#Check Content: 
#Verify that cron logging is configured and active
#
#Procedure:
# grep cron /etc/syslog.conf
#If cron logging is not configured, this is a finding.
#
#Check the configured cron log file found in the cron entry of 
#/etc/syslog (normally /var/log/cron).
# ls -lL /var/log/cron
#
#If this file does not exist, or is older than the last cron job, 
#this is a finding.
#
#
#Fix Text: Edit /etc/syslog.conf and setup cron logging.   
#######################DISA INFORMATION###############################
#
#Global Variables#
PDI=GEN003160

GOODCRON=$( grep -ic "^cron" /etc/syslog.conf )

#Start-Lockdown

if [ $GOODCRON -lt 1 ]
  then
    echo "cron.*							/var/log/cron" >> /etc/syslog.conf
fi

