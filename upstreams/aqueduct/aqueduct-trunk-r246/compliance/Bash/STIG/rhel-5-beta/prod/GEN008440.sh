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
#Group ID (Vulid): V-22577
#Group Title: GEN008440
#Rule ID: SV-26963r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN008440
#Rule Title: Automated file system mounting tools must not be enabled unless needed.
#
#Vulnerability Discussion: Automated file system mounting tools may provide unprivileged users with the ability to access local media and network shares. If this access is not necessary for the system’s operation, it must be disabled to reduce the risk of unauthorized access to these resources.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#If the autofs service is needed, this vulnerability is not applicable.
#Check if the autofs service is running.
# service autofs status
#If the service is running, this is a finding.
#
#Fix Text: Stop and disable the autofs service.
# service autofs stop
# chkconfig autofs off
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008440
AUTOSERVICE=$( service autofs status | grep "running..." | wc -l )
#Start-Lockdown

if [ $AUTOSERVICE -ne 0 ]
  then
  service autofs stop
  chkconfig --level 2345 autofs off
fi


