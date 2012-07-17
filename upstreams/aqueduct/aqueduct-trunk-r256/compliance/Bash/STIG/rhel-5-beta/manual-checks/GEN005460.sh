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
#Group ID (Vulid): V-4395
#Group Title: Remote Loghost Documentation
#Rule ID: SV-4395r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005460
#Rule Title: The system must only use remote syslog servers (log hosts) that are justified and documented using site-defined procedures.
#
#Vulnerability Discussion: If a remote log host is in use and it has not been justified and documented with the IAO, sensitive information could be obtained by unauthorized users without the SA's knowledge. A remote log host is any host to which the system is sending syslog messages over a network.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Examine the syslog.conf file for any references to remote log hosts.
# grep -v "^#" /etc/syslog.conf | grep '@'
#Destination locations beginning with an '@' represent log hosts. If the log host name is a local alias such as "loghost", consult the /etc/hosts or other name databases as necessary to obtain the canonical name or address for the log host. Determine if the host referenced is a log host documented using site-defined procedures. If an undocumented log host is referenced, this is a finding.
#
#Fix Text: Remove or document the referenced undocumented log host.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005460

#Start-Lockdown

#Manual Check
