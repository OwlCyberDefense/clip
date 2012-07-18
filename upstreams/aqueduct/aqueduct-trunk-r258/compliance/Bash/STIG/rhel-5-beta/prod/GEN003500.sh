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
#Group ID (Vulid): V-11996
#Group Title: Disable Core Dumps
#Rule ID: SV-27403r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN003500
#Rule Title: Process core dumps must be disabled unless needed.
#
#Vulnerability Discussion: Process core dumps contain the memory in 
#use by the process when it crashed. Process core dump files can be 
#of significant size and their use can result in file systems filling 
#to capacity, which may result in denial of service. Process core dumps 
#can be useful for software debugging.
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
# ulimit -c
#If the above command does not return 0, this a finding.
#
#
#Fix Text: Edit /etc/security/limits.conf and set a hard limit for 
#"core" to 0 for all users.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003500
HARDLIMIT=$(cat /etc/security/limits.conf | grep -c "* hard core 0")
#Start-Lockdown

if [ $HARDLIMIT -eq 0 ]
  then
	echo " " >> /etc/security/limits.conf
	echo "* hard core 0" >> /etc/security/limits.conf
fi

