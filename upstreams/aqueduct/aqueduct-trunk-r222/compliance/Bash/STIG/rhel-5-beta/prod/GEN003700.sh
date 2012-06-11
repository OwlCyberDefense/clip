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
# on 04-feb-2012 to only disable xinetd if its enabled and no on demand
# services are enabled.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-12005
#Group Title: Disable xinetd
#Rule ID: SV-27424r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003700
#Rule Title: Xinetd must be disabled or removed if no network services 
#utilizing them are enabled.
#
#Vulnerability Discussion: Services that are not necessary should be 
#disabled to decrease the attack surface of the system.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#RHEL5 does not include inetd service in its distribution. It has 
#been replaced by xinetd.
#
#Procedure:
# ps -ef |grep xinetd
#If xinetd is not running, this check is not a finding.
# grep -v "^#" /etc/xinetd.conf
# grep disable /etc/xinetd.d/* |grep no
#If no active services are found, yet the xinetd daemon is running, 
#this is a finding.
#
#Fix Text: # service xinetd stop ; chkconfig xinetd off   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003700

#Start-Lockdown
chkconfig --list xinetd | grep ':on' > /dev/null
if [ $? -eq 0 ]
then
  # Only turn off xined if all on demand services are disabled
  grep disable /etc/xinetd.d/* | grep no > /dev/null
  if [ $? -ne 0 ]
  then
    service xinetd stop
    chkconfig xinetd off  
  fi
fi
