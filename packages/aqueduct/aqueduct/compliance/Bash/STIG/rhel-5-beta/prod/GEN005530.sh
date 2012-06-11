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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechonlogy-llc.com)
# on 09-Feb-2012 to only run fix when needed.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22479
#Group Title: GEN005530
#Rule ID: SV-26773r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN005530
#Rule Title: The SSH daemon must not permit user environment settings.
#
#Vulnerability Discussion: SSH may be used to provide limited functions other than an 
#interactive shell session, such as file transfer. If local, user-defined environment 
#settings (such as those configured in ~/.ssh/authorized_keys or ~/.ssh/environment, 
#or equivalent) are configured by the user and permitted by the SSH daemon, they 
#could be used to alter the behavior of the limited functions, potentially granting unauthorized access to the system.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the PermitUserEnvironment setting in the SSH daemon configuration.
#
#Procedure:
# grep -i PermitUserEnvironment /etc/ssh/sshd_config|grep -v '^#'
#
#If the setting is not present, or set to a value other than "no", this is a finding.
#
#Fix Text: Edit the SSH daemon configuration and edit or add the PermitUserEnvironment setting with a value of "no".   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005530

#Start-Lockdown

if [ `grep -c "^PermitUserEnvironment" /etc/ssh/sshd_config` -gt 0 ]
then
  egrep '^PermitUserEnvironment.*yes' /etc/ssh/sshd_config > /dev/null
  if [ $? -eq 0 ]
  then
    sed -i "/^PermitUserEnvironment/ c\PermitUserEnvironment no" /etc/ssh/sshd_config
    service sshd restart
  fi
else
  echo "#Added for DISA $PDI" >> /etc/ssh/sshd_config
  echo "PermitUserEnvironment no" >> /etc/ssh/sshd_config
  service sshd restart
fi


