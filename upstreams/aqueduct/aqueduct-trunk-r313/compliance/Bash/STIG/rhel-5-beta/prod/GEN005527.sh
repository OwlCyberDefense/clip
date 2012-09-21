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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 06-Feb-2012 to comment out fix as its not a valid ssh client option.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22476
#Group Title: GEN005527
#Rule ID: SV-26770r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN005527
#Rule Title: The SSH client must not permit Kerberos authentication unless needed.
#
#Vulnerability Discussion: Kerberos authentication for SSH is often implemented using GSSAPI. 
#If Kerberos is enabled through SSH, the SSH client provides a means of access to the system's 
#Kerberos implementation. Vulnerabilities in the system's Kerberos implementation may then be 
#subject to exploitation. To reduce the attack surface of the system, the Kerberos authentication 
#mechanism within SSH must be disabled for systems not using this capability.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Ask the SA if the system uses Kerberos authentication. If it does, this is not applicable.
#
#Check the SSH clients configuration for the KerberosAuthentication setting.
# grep -i KerberosAuthentication /etc/ssh/ssh_config | grep -v '^#'
#If no lines are returned, or the setting is set to "yes", this is a finding.
#
#Fix Text: Edit the SSH client configuration and set (add if necessary) an "KerberosAuthentication" directive set to "no".   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005527

#Start-Lockdown

#KERBAUTH=$( grep -i KerberosAuthentication /etc/ssh/ssh_config | grep -v '^#' | wc -l )
#Start-Lockdown

#if [ $KERBAUTH -eq 0 ]
#  then
#    echo "#Adding for DISA GEN005527" >> /etc/ssh/ssh_config
#    echo "KerberosAuthentication no" >> /etc/ssh/ssh_config
#    service sshd restart
#else
#  sed -i 's/KerberosAuthentication yes/KerberosAuthentication no/g' /etc/ssh/ssh_config
#  service sshd restart
#fi
