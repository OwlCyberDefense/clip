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
# on 23-jan-2012 to add a check on default auditd runlevels before running 
# chkconfig.
#
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 10-apr-2012 to install audit rpm package if its not already installed.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-811
#Group Title: Configure and implement auditing
#Rule ID: SV-27270r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002660
#Rule Title: Auditing must be implemented.
#
#Vulnerability Discussion: Without auditing, individual system accesses 
#cannot be tracked and malicious activity cannot be detected and traced 
#back to an individual account.
#
#Responsibility: System Administrator
#IAControls: ECAR-1, ECAR-2, ECAR-3
#
#Check Content: 
#Determine if auditing is enabled.
# ps -ef |grep auditd
#If the auditd process is not found, this is a finding.
#
#Fix Text: Start the auditd service and set it to start on boot.
# service auditd start ; chkconfig auditd on   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002660

#Start-Lockdown
rpm -q audit > /dev/null
if [ $? != 0 ]
then
  yum -y install audit
fi


RES=`chkconfig --list auditd | awk '/2:on/ && /3:on/ && /4:on/ && /5:on/'`
if [ "$RES" == "" ]
then
  chkconfig auditd on
  service auditd start > /dev/null
fi

