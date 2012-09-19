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
#  - Updated by Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com) 
# on 02-feb-2011 to include an ownership check before running.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-11997
#Group Title: Core Dump Directory Ownership and Permissions
#Rule ID: SV-27411r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN003520
#Rule Title: The kernel core dump data directory must be owned by root.
#
#Vulnerability Discussion: Kernel core dumps may contain the full contents of system memory at the time of the crash. As the system memory may contain sensitive information, it must be protected accordingly. If the kernel core dump data directory is not owned by root, the core dumps contained in the directory may be subject to unauthorized access.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of the kernel core dump data directory.
# ls -ld /var/crash
#If the kernel core dump data directory is not owned by root, this is a finding.
#
#Fix Text: Change the owner of the kernel core dump data directory to root.
# chown root /var/crash 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003520

#Start-Lockdown
if [ -d "/var/crash" ]
then
  CUROWN=`stat -c %U /var/crash`;
  if [ "$CUROWN" != "root" ]
    then
      chown root /var/crash
  fi
fi
