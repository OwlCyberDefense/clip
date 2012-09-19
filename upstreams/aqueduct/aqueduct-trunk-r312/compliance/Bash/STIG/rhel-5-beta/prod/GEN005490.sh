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
# on 05-Feb-2012 to disable rsa1 key generation in the /etc/rc.d/init.d/sshd 
# script.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-23826
#Group Title: GEN005490
#Rule ID: SV-28762r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005490
#Rule Title: The SSH daemon must use a FIPS 140-2 validated cryptographic module (operating in FIPS mode).
#
#Vulnerability Discussion: Cryptographic modules used by the system must be validated by the NIST CVMP as compliant with FIPS 140-2.
#Cryptography performed by modules that are not validated is viewed by NIST as providing no protection for the data.
#
#Responsibility: System Administrator
#IAControls: DCNR-1
#
#Check Content: 
#Determine if the SSH daemon uses a FIPS 140-2 validated cryptographic module (operating in FIPS mode). The NIST CVMP web site provides a list of validated modules and the required security policies for the compliant use of such modules. Verify that the module is on this list and configured in accordance with the validated security policy.
#
#Procedure:
#grep "key generation" /etc/rc.d/init.d/sshd
#If the response does not indicate FIPS-140-2 compliant modules (RSA and DSA) this is a finding.
#
#Fix Text: Configure the SSH daemon to use a FIPS 140-2 validated cryptographic module (operating in FIPS mode).   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005490

#Start-Lockdown

#Turning on FIPS mode is addressed in GEN000588.sh
# After turn on FIPS mode on an initial boot, the sshd service will not start
# due to FIPS mode keeping the rsa1 key from being generated.  Its not needed
# so lets comment it out.  It will probably need fixed on future sshd updates.
if [ -e '/etc/rc.d/init.d/sshd' ]
then
  egrep '#.*do_rsa1_keygen' /etc/rc.d/init.d/sshd > /dev/null
  if [ $? -ne 0 ]
  then
    sed -i 's/^[^d].*do_rsa1_keygen.*/#&/g' /etc/rc.d/init.d/sshd
  fi
fi
