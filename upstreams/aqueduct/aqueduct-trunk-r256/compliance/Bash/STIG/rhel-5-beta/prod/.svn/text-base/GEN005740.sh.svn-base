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
# on 12-Feb-2012 to check ownership before running chown.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-928
#Group Title: Export Configuration File Ownership
#Rule ID: SV-28445r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005740
#Rule Title: The NFS export configuration file must be owned by root.
#
#Vulnerability Discussion: Failure to give ownership of the NFS export configuration file to root provides the designated owner and possible unauthorized users with the potential to change system configuration which could weaken the system's security posture.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the owner of the exports file.
#
#Example:
# ls -lL /etc/exports
#
#If the export configuration file is not owned by root, this is a finding.
#
#Fix Text: Change the owner of the exports file to root.
#
#Example:
# chown root /etc/exports   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005740

#Start-Lockdown

if [ -a "/etc/exports" ]
then
  CUROWN=`stat -c %U /etc/exports`;
  if [ "$CUROWN" != "root" ]
    then
      chown root /etc/exports
  fi
fi

