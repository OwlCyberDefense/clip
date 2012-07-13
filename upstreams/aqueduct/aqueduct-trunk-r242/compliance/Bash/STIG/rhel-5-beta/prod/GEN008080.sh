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
# on 18-Feb-2012 to check ownership before running chown.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22560
#Group Title: GEN008080
#Rule ID: SV-26947r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008080
#Rule Title: If the system is using LDAP for authentication or account information, the /etc/ldap.conf (or equivalent) file must be owned by root.
#
#Vulnerability Discussion: LDAP can be used to provide user authentication and account information, which are vital to system security. The LDAP client configuration must be protected from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of the file.
# ls -lL /etc/ldap.conf
#If the file is not owned by root, this is a finding.
#
#Fix Text: Change the owner of the file.
# chown root /etc/ldap.conf    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008080

#Start-Lockdown

if [ -a "/etc/ldap.conf" ]
then
  CUROWN=`stat -c %U /etc/ldap.conf`;
  if [ "$CUROWN" != "root" ]
    then
      chown root /etc/ldap.conf
  fi
fi
