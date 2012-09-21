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
# on 19-Feb-2012 to move from dev to prod and add fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-23828
#Group Title: GEN007970
#Rule ID: SV-28764r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN007970
#Rule Title: If the system is using LDAP for authentication or account 
#information, the system must use a FIPS 140-2 validated cryptographic 
#module (operating in FIPS mode) for protecting the LDAP connection.
#
#Vulnerability Discussion: LDAP can be used to provide user authentication 
#and account information, which are vital to system security. 
#Cryptographic modules used by the system must be validated by 
#the NIST CVMP as compliant with FIPS 140-2. Cryptography performed 
#by modules that are not validated is viewed by NIST as providing 
#no protection for the data.
#
#Responsibility: System Administrator
#IAControls: DCNR-1
#
#Check Content: 
#Determine if the system uses NSS LDAP. If it does not, this is not applicable. If the system does use NSS LDAP then the "tls_cypher" must be a FIPS 140-2 validated cryptographic module .The NIST CVMP web site provides a list of validated modules and the required security policies for the compliant use of such modules. Verify that the module is on this list and configured in accordance with the validated security policy.
#
#Procedure:
# grep -v '^#' /etc/nsswitch.conf | grep ldap
#If no lines are returned, this vulnerability is not applicable.
#
#Examine the content of /etc/ldap.conf. If the "tls_cipher" line is commented or uncommented and the cipher is not a FIPS 140-2 validated cryptographic module (operating in FIPS mode), this is a finding.
#
#
#Fix Text: Configure the system to use a FIPS 140-2 validated cryptographic module (operating in FIPS mode) for protecting the NSS LDAP connection. 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN007970

#Start-Lockdown

# The nsswitch check above doesn't include if ldap is configure for 
# authentication. Lets check for that and for pam_ldap as well. 

RUNFIX=0
grep -v '^#' /etc/nsswitch.conf | grep ldap > /dev/null
if [ $? -eq 0 ]
then
  RUNFIX=1
fi

grep -v '^#' /etc/pam.d/* | grep pam_ldap > /dev/null
if [ $? -eq 0 ]
then
  RUNFIX=1
fi


if [ $RUNFIX -eq 1 ]
then
  if [ -e /etc/ldap.conf ]
  then
    grep '^tls_ciphers' /etc/ldap.conf > /dev/null
    if [ $? -eq 0 ]
    then
      grep '^tls_ciphers TLSv1$' /etc/ldap.conf > /dev/null
      if [ $? -ne 0 ]
      then
        sed -i -e 's/^tls_ciphers.*/tls_ciphers TLSv1/g' /etc/ldap.conf
      fi
    else
      echo "#Entry added by STIG check $PDI" >> /etc/ldap.conf
      echo "tls_ciphers TLSv1" >> /etc/ldap.conf
    fi
  fi
fi
