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
# on 20-Feb-2012 to check service status before disabling it.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22589
#Group Title: GEN008820
#Rule ID: SV-26992r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN008820
#Rule Title: The system package management tool must not automatically obtain updates.#
#
#Vulnerability Discussion: System package management tools can obtain a list of updates and patches from a package repository and make this information available to the SA for review and action. Using a package repository outside of the organization's control presents a risk that malicious packages could be introduced.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check that the yum service is enabled.
# service yum-updatesd status
#If the service is enabled, this is a finding.
#
#Fix Text: Disable the yum service.
# chkconfig yum-updatesd off ; service yum-updatesd stop   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008820

#Start-Lockdown

chkconfig --list yum-updatesd | grep ':on' > /dev/null
if [ $? -eq 0 ]
then
  service yum-updatesd stop
  chkconfig yum-updatesd off
fi
