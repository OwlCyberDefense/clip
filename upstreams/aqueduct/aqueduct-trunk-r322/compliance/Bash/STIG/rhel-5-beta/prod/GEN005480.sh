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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 05-Feb-2012 to remove the -r from the syslog deamon options.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-12021
#Group Title: Syslog Accepts Remote Messages
#Rule ID: SV-28434r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005480
#Rule Title: The syslog daemon must not accept remote messages unless it is a syslog server documented using site-defined procedures.
#
#Vulnerability Discussion: Unintentionally running a syslog server that accepts remote messages puts the system at increased risk. Malicious syslog messages sent to the server could exploit vulnerabilities in the server software itself, could introduce misleading information in to the system's logs, or could fill the system's storage leading to a denial of service.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#ps -ef | grep syslogd
#If the '-r' option is present. This is a finding.
#
#Fix Text: Edit /etc/sysconfig/syslog removing the '-r' in SYSLOGD_OPTIONS. Restart the syslogd service.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005480

#Start-Lockdown
if [ -e '/etc/sysconfig/syslog' ]
then
  grep 'SYSLOGD_OPTIONS' /etc/sysconfig/syslog | grep '\-r' > /dev/null
  if [ $? -eq 0 ]
  then
    sed -i 's/-r//g' /etc/sysconfig/syslog
  fi
fi
