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
# on 06-Feb-2012 to check for cbc entries before running fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22462
#Group Title: GEN005511
#Rule ID: SV-26755r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005511
#Rule Title: The SSH client must be configured to not use CBC-based ciphers.
#
#Vulnerability Discussion: The cipher-block chaining (CBC) mode of encryption as implemented in the SSHv2 protocol is vulnerable to chosen-plaintext attacks and must not be used.
#
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the SSH client configuration for allowed ciphers.
# grep -i ciphers /etc/ssh/ssh_config | grep -v '^#'
#If no lines are returned, or the returned ciphers list contains any cipher that ends with "cbc", this is a finding.
#
#Fix Text: Edit the SSH client configuration and remove any ciphers ending with "cbc". If necessary, add a "Ciphers" line.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005511

#Start-Lockdown

grep ',.*es.*-cbc' /etc/ssh/ssh_config > /dev/null
if [ $? -eq 0 ]
then
  sed -i 's/,aes128-cbc//g' /etc/ssh/ssh_config
  sed -i 's/,3des-cbc//g' /etc/ssh/ssh_config
  sed -i 's/,aes192-cbc//g' /etc/ssh/ssh_config
  sed -i 's/,aes256-cbc//g' /etc/ssh/ssh_config
fi
