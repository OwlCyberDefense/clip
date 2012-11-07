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
#Group ID (Vulid): V-22576
#Group Title: GEN008420
#Rule ID: SV-26962r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN008420
#Rule Title: The system must use available memory address randomization techniques.
#
#Vulnerability Discussion: Successful exploitation of buffer overflow vulnerabilities
#relies in some measure to having a predictable address structure of the
#executing program. Address randomization techniques reduce the probability of a successful exploit.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check that exec-shield is enabled if present.
# cat /proc/sys/kernel/exec-shield
#If the file is present and contains a value of 0, this is a finding.
#
#Fix Text: Edit the kernel boot parameters, or /etc/sysctl.conf, and set exec-shield to 1. Reboot the system.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008420
EXECSHEILD=$( cat /proc/sys/kernel/exec-shield )
#Start-Lockdown

if [ $EXECSHEILD -ne 1 ]
  then
    echo "#Added for DISA GEN008420" >> /etc/sysctl.conf
    echo "kernel.exec-shield = 1" >> /etc/sysctl.conf
    sysctl -p
fi
