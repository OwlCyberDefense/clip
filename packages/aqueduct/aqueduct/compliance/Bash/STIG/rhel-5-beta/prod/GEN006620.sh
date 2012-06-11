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
# on 18-Feb-2012 to move from manual to prod and add fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-12030
#Group Title: Access Control Program Control System Access
#Rule ID: SV-12531r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006620
#Rule Title: The system's access control program must be configured to grant or deny system access to specific hosts.
#
#Vulnerability Discussion: If the system's access control program is not configured with appropriate rules for allowing and denying access to system network resources, services may be accessible to unauthorized hosts.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check for the existence of the /etc/hosts.allow and /etc/hosts.deny files.
#
#Procedure:
# ls -la /etc/hosts.allow
# ls -la /etc/hosts.deny
#
#If either file does not exist, this is a finding.
#
#Check for the presence of a default deny entry.
#
#Procedure:
# grep "ALL: ALL" /etc/hosts.deny
#
#If the ‘ALL: ALL’ entry is not present the /etc/hosts.deny file, any TCP service from a host or network not matching other rules will be allowed access. If the entry is not in /etc/hosts.deny, this is a finding.
#
#Fix Text: Edit the /etc/hosts.all and /etc/hosts.deny files to configure access restrictions.
  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006620

#Start-Lockdown

# We are going to add the ALL: ALL to the hosts.deny, but allow all to ssh
# to keep from locking ourselves out.

# Check for sshd in /etc/hosts.allow
grep 'sshd: ALL' /etc/hosts.allow > /dev/null
if [ $? -ne 0 ]
then
  echo 'sshd: ALL' >> /etc/hosts.allow
fi

grep '^ALL: ALL' /etc/hosts.deny > /dev/null
if [ $? -ne 0 ]
then
  # Overwrite everything to make sure its a default deny policy
  echo "# Set to deny all for STIG fix $PDI" > /etc/hosts.deny
  echo 'ALL: ALL : severity authpriv.info' >> /etc/hosts.deny
fi


