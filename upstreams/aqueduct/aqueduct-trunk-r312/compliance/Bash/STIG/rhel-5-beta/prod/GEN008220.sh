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
# on 20-Feb-2012 to point to the correct config entry.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22567
#Group Title: GEN008220
#Rule ID: SV-26954r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008220
#Rule Title: For systems using NSS LDAP, the TLS certificate file must be owned by root.
#
#Vulnerability Discussion: The NSS LDAP service provides user mappings which are a vital component of system security. Its configuration must be protected from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Determine the certificate file.
# grep -i '^tls_cert' /etc/ldap.conf
#Check the ownership.
# ls -lL <certpath>
#If the owner of the file is not root, this is a finding.
#
#Fix Text: Change the ownership of the file.
# chown root <certpath>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008220

[ -f /etc/ldap.conf ] || exit 0

#Start-Lockdown
TLSCERTS=$(  grep -i '^tls_cert' /etc/ldap.conf | awk '{print $2}' ) 

for line in $TLSCERTS
  do
    if [ -a $TLSCERTS ]
      then
      CUROWN=`stat -c %U $TLSCERTS`;
        if [ "$CUROWN" != "root" ]
          then
            chown -R root $TLSCERTS
        fi
    fi
done

