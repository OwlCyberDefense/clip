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
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-23827
#Group Title: GEN005495
#Rule ID: SV-28763r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005495
#Rule Title: The SSH client must use a FIPS 140-2 validated cryptographic module (operating in FIPS mode).
#
#Vulnerability Discussion: Cryptographic modules used by the system must be validated by the NIST CVMP as compliant with FIPS 140-2. Cryptography performed by modules that are not validated is viewed by NIST as providing no protection for the data.
#
#Responsibility: System Administrator
#IAControls: DCNR-1
#
#Check Content: 
#Determine if the SSH client uses a FIPS 140-2 validated cryptographic module (operating in FIPS mode). The NIST CVMP web site provides a list of validated modules and the required security policies for the compliant use of such modules. Verify that the module is on this list and configured in accordance with the validated security policy.
#
#Procedure:
#grep " Cipher" /etc/ssh/ssh_config
#The "Cipher" entry should indicate"3des" which is the default. If the Cipher entry has not been commented out then if it does not contain "3des" it is a finding.
#
#The "Ciphers" entry should only support "3des","aes128","aes192", "aes256". The default is not acceptable because "blowfish", "arcfour" and "cast128" are not FIPS-140-2 compliant, this is a finding.
#
#
#Fix Text: Configure the SSH client to use a FIPS 140-2 validated cryptographic module (operating in FIPS mode).   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005495

#Start-Lockdown

sed -i 's/,arcfour//g' /etc/ssh/ssh_config
sed -i 's/,blowfish-cbc//g' /etc/ssh/ssh_config
sed -i 's/,cast128//g' /etc/ssh/ssh_config
