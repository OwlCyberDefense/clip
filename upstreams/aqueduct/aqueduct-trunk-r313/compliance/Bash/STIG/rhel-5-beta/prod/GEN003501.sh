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
# on 02-jan-2011 to add content and move from dev to prod.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22399
#Group Title: GEN003501
#Rule ID: SV-26575r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN003501
#Rule Title: The system must be configured to store any process core 
#dumps in a specific, centralized directory.
#
#Vulnerability Discussion: Specifying a centralized location for core 
#file creation allows for the centralized protection of core files. 
#Process core dumps contain the memory in use by the process when it 
#crashed. Any data the process was handling may be contained in the 
#core file, and it must be protected accordingly. If process core 
#dump creation is not configured to use a centralized directory, core 
#dumps may be created in a directory that does not have appropriate 
#ownership or permissions configured, which could result in 
#unauthorized access to the core dumps.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that a directory is defined for process core dumps.
# cat /proc/sys/kernel/core_pattern
#If the parameter is not an absolute path (does not start with a 
#slash [/]), this is a finding.
#
#Fix Text: Edit /etc/sysctl.conf and set (adding if necessary) 
#kernel.core_pattern to an absolute path ending with a file name 
#prefix, such as "/var/core/core".  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003501

#Start-Lockdown
grep 'kernel.core_pattern' /etc/sysctl.conf > /dev/null
if [ $? -eq 0 ]
then
  # Check for proper value
  grep 'kernel.core_pattern = /var/core/core' /etc/sysctl.conf > /dev/null
  if [ $? -ne 0 ]
  then
    sed -i -e 's/kernel.core_pattern = .*$/kernel.core_pattern = \/var\/core\/core/g' /etc/sysctl.conf
    sysctl -p > /dev/null
  fi
else
  echo "" >> /etc/sysctl.conf
  echo "#Added by STIG check GEN003501" >> /etc/sysctl.conf
  echo "kernel.core_pattern = /var/core/core" >> /etc/sysctl.conf
  sysctl -p > /dev/null
fi
