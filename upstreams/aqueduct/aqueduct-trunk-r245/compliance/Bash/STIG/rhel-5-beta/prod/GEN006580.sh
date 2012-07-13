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
#Group ID (Vulid): V-940
#Group Title: Access Control Program
#Rule ID: SV-28460r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006580
#Rule Title: The system must use an access control program.
#
#Vulnerability Discussion: Access control programs (such as TCP_WRAPPERS) provide the ability to enhance system security posture.
#
#
#Responsibility: System Administrator
#IAControls: EBRU-1
#
#Check Content: 
#Determine if TCP_WRAPPERS is installed.
# rpm -qa | grep tcp_wrappers
#If no package is listed, this is a finding.
#
#Fix Text: Install the tcp_wrappers package.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006580
TCPWAPPA=$( rpm -qa | grep tcp_wrappers | wc -l )
#Start-Lockdown

if [ $TCPWAPPA -eq 0 ]
  then
    yum install tcp_wrappers
fi
