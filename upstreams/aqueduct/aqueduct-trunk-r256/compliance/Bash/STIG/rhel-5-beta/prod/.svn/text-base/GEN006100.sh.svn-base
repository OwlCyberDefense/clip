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
# on 13-Feb-2012 to check ownership before running chown.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-1027
#Group Title: smb.conf ownership
#Rule ID: SV-1027r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006100
#Rule Title: The /etc/samba/smb.conf file must be owned by root.
#
#Vulnerability Discussion: The /etc/samba/smb.conf file allows access to other machines on the network and grants permissions to certain users. If it is owned by another user, the file may be maliciously modified and the Samba configuration could be compromised.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the ownership of the /etc/samba/smb.conf file.
#
#Procedure:
# ls -l /etc/samba/smb.conf
#If an smb.conf file is not owned by root, this is a finding.
#
#Fix Text: Change the ownership of the smb.conf file.
#
#Procedure:
# chown root smb.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006100

#Start-Lockdown

if [ -a "/etc/samba/smb.conf" ]
then
  CUROWN=`stat -c %U /etc/samba/smb.conf`;
  if [ "$CUROWN" != "root" ]
    then
      chown root /etc/samba/smb.conf
  fi
fi
