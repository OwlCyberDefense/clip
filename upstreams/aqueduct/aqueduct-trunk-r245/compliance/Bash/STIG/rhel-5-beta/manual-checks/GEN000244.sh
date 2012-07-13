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
#By Tummy a.k.a Vincent C. Passaro															     #
#Fotis Networks LLC						  																	   #
#Vincent[.]Passaro[@]fotisnetworks[.]com												     #
#www.fotisnetworks.com						    															 #
######################Fotis Networks LLC##############################

#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    		|   Creation				    |                    |            |
#|__________|_______________________|____________________|____________|
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22292
#Group Title: GEN000244
#Rule ID: SV-26304r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN000244
#Rule Title: The system must use time sources that are local to 
#the enclave.
#
#Vulnerability Discussion: A synchronized system clock is critical 
#for the enforcement of time-based policies and the correlation of 
#logs and audit records with other systems. The network architecture 
#should provide multiple time servers within an enclave that 
#provide local service to the enclave and synchronize with time 
#sources outside of the enclave.
#
#If this server is an enclave time server, this requirement is 
#not applicable.
#
#If the system is completely isolated (that is, it has no connections 
#to networks or other systems), time synchronization is not 
#required as no correlation of events or operation of time-dependent 
#protocols between systems will be necessary. If the system is 
#completely isolated, this requirement is not applicable.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the root crontab (crontab -l) and the global crontabs in 
#/etc/crontab, /etc/cron.d/*, or scripts in the /etc/cron.daily 
#directory for the presence of an ntpdate job. If the ntpdate 
#command is invoked with NTP servers that are outside of the 
#enclave, this is a finding.
#
#Check the NTP daemon configuration for NTP servers.
# grep ^server /etc/ntp.conf | grep -v 127.127.1.1
#If an NTP server is listed that is outside of the enclave, 
#this is a finding.
#
#
#Fix Text: If using ntpdate, remove NTP servers that are external 
#to the enclave from the cron job running ntpdate.
#
#If using the NTP daemon, remove the "server" line from 
#/etc/ntp.conf for each NTP server that is external to the enclave.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000244

#Start-Lockdown

