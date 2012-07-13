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
# on 13-Feb-2012 to include an ACL check before running setfacl.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22498
#Group Title: GEN006210
#Rule ID: SV-26826r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006210
#Rule Title: The /etc/samba/passdb.tdb and /etc/samba.secrets.tdb files must not have an extended ACL.
#
#Vulnerability Discussion: If the permissions of the smbpasswd maintained files are too permissive, the file may be maliciously accessed or modified, potentially resulting in the compromise of Samba accounts.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the Samba password files.
#
#Procedure:
# ls -lL /etc/samba/passdb.tdb /etc/samba.secrets.tdb
#
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/samba/passdb.tdb and /etc/samba.secrets.tdb    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006210

#Start-Lockdown

if [ -a "/etc/samba.secrets.tdb" ]
then
  ACLOUT=`getfacl --skip-base /etc/samba.secrets.tdb 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all /etc/samba.secrets.tdb
  fi
fi

if [ -a "/etc/samba/passdb.tdb" ]
then
  ACLOUT=`getfacl --skip-base /etc/samba/passdb.tdb 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all /etc/samba/passdb.tdb
  fi
fi

