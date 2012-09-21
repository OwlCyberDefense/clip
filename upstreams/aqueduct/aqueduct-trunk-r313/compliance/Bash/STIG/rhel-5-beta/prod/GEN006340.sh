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
# on 14-Feb-2012 to check ownership before running chown.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4277
#Group Title: /etc/news files ownership
#Rule ID: SV-4277r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006340
#Rule Title: Files in /etc/news must be owned by root or news.
#
#Vulnerability Discussion: If critical system files are not owned by a privileged user, system integrity could be compromised.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of the files in /etc/news.
#
#Procedure:
# ls -al /etc/news
#
#If any files are not owned by root or news, this is a finding.
##
#Fix Text: Change the ownership of the files in /etc/news to root or news.
#
#Procedure:
# chown root /etc/news/*   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006340

#Start-Lockdown

if [ -d /etc/news ]
then
  find /etc/news ! -user root ! -user news -exec chown root {} \; > /dev/null 2>&1
fi
