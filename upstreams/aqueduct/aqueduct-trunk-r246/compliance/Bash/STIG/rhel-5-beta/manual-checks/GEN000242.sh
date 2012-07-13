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
#By Tummy a.k.a Vincent C. Passaro				 											     #
#Fotis Networks LLC						  																     #
#Vincent[.]Passaro[@]fotisnetworks[.]com												     #
#www.fotisnetworks.com						   															   #
######################Fotis Networks LLC##############################

#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	   		  |   Creation	    			|                    |            |
#|__________|_______________________|____________________|____________|
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22291
#Group Title: GEN000242
#Rule ID: SV-26302r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000242
#Rule Title: The system must use at least two time sources for clock 
#synchronization.
#
#Vulnerability Discussion: A synchronized system clock is critical 
#for the enforcement of time-based policies and the correlation of 
#logs and audit records with other systems. For redundancy, two time 
#sources are required so that synchronization continues to function 
#if one source fails.
#
#If the system is completely isolated (that is, it has no connections 
#to networks or other systems), time synchronization is not required 
#as no correlation of events or operation of time-dependent protocols 
#between systems will be necessary. If the system is completely 
#isolated, this requirement is not applicable.
#
#Note: For the network time protocol (NTP), the requirement is two 
#servers, but it is recommended to configure at least four distinct 
#time servers which allow NTP to effectively exclude a time source 
#that is not consistent with the others. The system's local clock 
#must be excluded from the count of time sources.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the root crontab (crontab -l) and the global crontabs in 
#/etc/crontab, /etc/cron.d/*, or scripts in the /etc/cron.daily 
#directory for the presence of an ntpdate job. If the ntpdate 
#command is not invoked with at least two external NTP servers 
#listed, this is a finding.
#
#Check the NTP daemon configuration for at least two external servers.
# grep ^server /etc/ntp.conf | egrep -v '(127.127.1.0|127.127.1.1)'
#If less than two servers or external reference clocks (127.127.x.x other than 127.127.1.0 or 127.127.1.1) are listed, this is a finding.
#
#Fix Text: If using ntpdate, add additional NTP servers to the cron job running ntpdate.
#
#If using the NTP daemon, add an additional "server" line to /etc/ntp.conf for each additional NTP server.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000242

#Start-Lockdown

