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
#Group ID (Vulid): V-22455
#Group Title: GEN005450
#Rule ID: SV-26745r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005450
#Rule Title: The system must use a remote syslog server (loghost).
#
#Vulnerability Discussion: A syslog server (loghost) receives syslog messages from one or more systems. This data can be used as an authoritative log source in the event a system is compromised and its local logs are suspect.
#
#Responsibility: System Administrator
#IAControls: ECAT-1
#
#Check Content: 
#Check the syslog configuration file for remote syslog servers.
# grep '@' /etc/syslog.conf | grep -v '^#'
#If no line is returned, this is a finding.
#
#Fix Text: Edit the syslog configuration file and add an appropriate remote syslog server.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005450

#Start-Lockdown

#This will have to be done manually 
