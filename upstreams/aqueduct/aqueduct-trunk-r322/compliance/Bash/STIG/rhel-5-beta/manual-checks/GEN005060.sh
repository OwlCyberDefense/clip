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
#Group ID (Vulid): V-12013
#Group Title: FSP Is Enabled
#Rule ID: SV-28417r1_rule
#Severity: CAT I
#Rule Version (STIG-ID): GEN005060
#Rule Title: The system must not have an FSP service enabled.
#
#Vulnerability Discussion: FSP is a UDP-based file transfer protocol that, in the past, was commonly used for file sharing.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Determine if the in.fspd service is running through xinetd.
# grep in.fspd /etc/xinetd.d/*
#If a service file exists for fspd and is not disabled, this is a finding.
#
#Determine if the fspd process is running.
# ps -ef | grep fspd
#If the process is running, this is a finding.
#
#Fix Text: Disable or remove any fspd configuration files in /etc/xinetd.d/.
#Kill any running fspd processes and disable any fspd startup scripts.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005060

#Start-Lockdown

#This isn't available in the RHEL REPO, so if it's installed it's beyond our control (rpm)