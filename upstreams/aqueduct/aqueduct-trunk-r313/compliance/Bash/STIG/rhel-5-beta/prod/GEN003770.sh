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
# on 04-Feb-2012 to check group ownership before running chgrp.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22427
#Group Title: GEN003770
#Rule ID: SV-26657r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003770
#Rule Title: The services file must be group-owned by root, bin, sys, 
#or system.
#
#Vulnerability Discussion: Failure to give ownership of system 
#configuration files to root or a system group provides the designated 
#owner and unauthorized users with the potential to change the system 
#configuration which could weaken the system's security posture.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the services file.
#
#Procedure:
# ls -lL /etc/services
#
#If the file is not group-owned by root, bin, sys, or system, 
#this is a finding.
#
#Fix Text: Change the group-owner of the services file.
#
#Procedure:
# chgrp root /etc/services 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003770

#Start-Lockdown

if [ -a "/etc/services" ]
then
  CURGROUP=`stat -c %G /etc/services`;
  if [  "$CURGROUP" != "root" -a "$CURGROUP" != "bin" -a "$CURGROUP" != "sys" -a "$CURGROUP" != "system" ]
  then
      chgrp root /etc/services
  fi
fi
