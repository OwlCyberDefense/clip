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
#Group ID (Vulid): V-22574
#Group Title: GEN008360
#Rule ID: SV-26961r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008360
#Rule Title: If the system is using LDAP for authentication or account information, the LDAP TLS key file must not have an extended ACL.
#
#Vulnerability Discussion: LDAP can be used to provide user authentication and account information, which are vital to system security. The LDAP client configuration must be protected from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Determine the key file.
# grep -i '^tls_key' /etc/ldap.conf
#Check the permissions.
# ls -lL <keypath>
#If the permissions of the file contains a '+', an extended ACL is present. This is a finding.
#
#Fix Text: Remove the extended ACL from the key file.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008360

[ -f /etc/ldap.conf ] || exit 0

#Start-Lockdown
TLSKEY=$(  grep -i '^tls_key' /etc/ldap.conf | awk '{print $2}' ) 

for line in $TLSKEY
  do
    if [ -a $TLSKEY ]
      then
      ACLOUT=`getfacl --skip-base $TLSKEY 2>/dev/null`;
        if [ "$ACLOUT" != "" ]
          then
            setfacl --remove-all $TLSKEY
        fi
    fi
done
