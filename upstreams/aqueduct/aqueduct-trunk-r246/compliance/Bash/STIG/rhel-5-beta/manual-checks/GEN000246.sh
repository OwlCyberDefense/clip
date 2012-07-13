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
#####################Fotis Networks LLC###############################
#By Tummy a.k.a Vincent C. Passaro				     #
#Fotis Networks LLC						     #
#Vincent[.]Passaro[@]fotisnetworks[.]com			     #
#www.fotisnetworks.com						     #
######################Fotis Networks LLC##############################

#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22293
#Group Title: GEN000246
#Rule ID: SV-26307r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000246
#Rule Title: The system time synchronization method must use cryptographic algorithms to verify the authenticity and integrity of the time data.
#
#Vulnerability Discussion: A synchronized system clock is critical for the enforcement of time-based policies and the correlation of logs and audit records with other systems. If an illicit time source is used for synchronization, the integrity of system logs and the security of the system could be compromised.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the root crontab (crontab -l) and the global crontabs in /etc/crontab, /etc/cron.d/*, or scripts in the /etc/cron.daily directory for the presence of an ntpdate job. If the ntpdate command is not invoked with the '-a' parameter, this is a finding.
#
#Check the NTP daemon configuration.
# grep ^server /etc/ntp.conf | grep -v '( key | autokey )'
#If "server" lines are present without "key" or "autokey" options, this is a finding.
#
#Fix Text: If using ntpdate, add the '-a' option with a key to the cron job running ntpdate.
#
#If using the NTP daemon, add the "key" or "autokey" options, as appropriate, to each "server" line in /etc/ntp.conf for each NTP server not configured for authentication    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000246

#Start-Lockdown

