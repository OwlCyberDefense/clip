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
#By Tummy a.k.a Vincent C. Passaro				     #
#Vincent[.]Passaro[@]gmail[.]com	         		     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22303
#Group Title: GEN000590
#Rule ID: SV-26313r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000590
#Rule Title: The system must use a FIPS 140-2 approved cryptographic 
#hashing algorithm for generating account password hashes.
#
#Vulnerability Discussion: Systems must employ cryptographic hashes 
#for passwords using the SHA-2 family of algorithms or FIPS 140-2 
#approved successors. The use of unapproved algorithms may result 
#in weak password hashes that are more vulnerable to compromise.
#
#Responsibility: System Administrator
#IAControls: DCNR-1, IAIA-1, IAIA-2
#
#Check Content: 
#Verify that the algorithm used for password hashing is of the 
#SHA-2 family.
# egrep "password .* pam_unix.so" /etc/pam.d/system-auth-ac
#If the line indicates that the hash algorithm is not set to sha256 
#or sha512, this is a finding.
#
#Fix Text: Change the default password algorithm.
# authconfig --passalgo=sha512 --kickstart
#Fix Text: Change the default password algorithm:
# authconfig --passalgo=sha512 --update   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000590
HASHTYPE=`cat /etc/pam.d/system-auth-ac | grep -c sha512`

#Start-Lockdown

if [ $HASHTYPE = 0 ]
  then
    authconfig --passalgo=sha512 --update 
    authconfig --passalgo=sha512 --kickstart
fi



