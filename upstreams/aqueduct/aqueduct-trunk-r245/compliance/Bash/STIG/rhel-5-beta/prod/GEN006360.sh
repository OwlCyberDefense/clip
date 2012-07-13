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
# on 14-Feb-2012 to check group ownership before running chgrp.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4278
#Group Title: /etc/news files group ownership
#Rule ID: SV-4278r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006360
#Rule Title: The files in /etc/news must be group-owned by root or news.
#
#Vulnerability Discussion: If critical system files do not have a privileged group-owner, system integrity could be compromised.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check /etc/news files group ownership:
#
#Procedure:
# ls -al /etc/news
#
#If /etc/news files are not group-owned by root or news, this is a finding.
#
#Fix Text: Change the group-owner of the files in /etc/news to root or news.
#
#Procedure:
# chgrp root /etc/news/*   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006360

#Start-Lockdown

if [ -d /etc/news ]
then
  find /etc/news ! -group root ! -group news -exec chgrp root {} \; > /dev/null 2>&1
fi
