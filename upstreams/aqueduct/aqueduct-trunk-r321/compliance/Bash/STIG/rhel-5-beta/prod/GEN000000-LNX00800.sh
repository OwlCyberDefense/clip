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
#By Tummy a.k.a Vincent C. Passaro				     #
#Vincent[.]Passaro[@]gmail[.]com	         		     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22584
#Group Title: GEN000000-LNX00800
#Rule ID: SV-26978r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN000000-LNX00800
#Rule Title: The system must use a Linux Security Module that is 
#configured to limit the privileges of system services.
#
#Vulnerability Discussion: Linux Security Modules such as SELinux can 
#be used to provide protection from software exploits by explicitly 
#defining the privileges permitted to each software package.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check if SELINUX is enabled.
# getenforce
#If "disabled" is returned, this is a finding.
#
#Fix Text: Enable SELINUX.
#Edit /etc/sysconfig/selinux and set the mode to other than "disabled". Restart the system.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000000-LNX00800
SELINUXCONFIG=`cat /etc/sysconfig/selinux |grep "^SELINUX=" | cut -d "=" -f 2`
#Start-Lockdown

if [ $SELINUXCONFIG == disabled ]
  then
    sed -i 's/=disabled/=permissive/g' /etc/sysconfig/selinux 
fi


