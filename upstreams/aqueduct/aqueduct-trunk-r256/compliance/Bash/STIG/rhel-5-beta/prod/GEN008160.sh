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
# on 20-Feb-2012 to look at both the tls_certfile, tls_certdir and its contents


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22564
#Group Title: GEN008160
#Rule ID: SV-26951r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008160
#Rule Title: If the system is using LDAP for authentication or account information, the TLS certificate authority file and/or directory (as appropriate) must be group-owned by root, bin, sys, or system.
#
#Vulnerability Discussion: LDAP can be used to provide user authentication and account information, which are vital to system security. The LDAP client configuration must be protected from unauthorized modification
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Determine the certificate authority file and/or directory.
# grep -i '^tls_cacert' /etc/ldap.conf
#For each file or directory returned, check the group ownership.
# ls -lLd <certpath>
#If the group-owner of any file or directory is not root, this is a finding.
#
#Fix Text: Change the group-ownership of the file or directory.
# chgrp root <certpath>    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008160

[ -f /etc/ldap.conf ] || exit 0

#Start-Lockdown
TLSCERTS=$(  grep -i '^tls_cacert' /etc/ldap.conf | awk '{print $2}' ) 

for FILEORDIR in $TLSCERTS
do
  find $FILEORDIR ! -group root ! -group bin ! -group sys -exec chgrp root {} \; 2>/dev/null
done

