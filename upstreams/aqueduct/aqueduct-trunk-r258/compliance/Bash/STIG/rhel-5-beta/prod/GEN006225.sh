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
# Updated by Lee Kinser (lkinser@redhat.com) on 1 May 2012 to add logic
# for verifying the pkg is installed before attempting to configure it

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22499
#Group Title: GEN006225
#Rule ID: SV-26830r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006225
#Rule Title: Samba must be configured to use an authentication mechanism other than "share."
#
#Vulnerability Discussion: Samba share authentication does not provide for individual user identification and must not be used.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the security mode of the Samba configuration.
# grep -i security /etc/samba/smb.conf
#If the security mode is "share", this is a finding.
#
#Fix Text: Edit the /etc/samba/smb.conf file and change the "security" setting to "user" or another valid setting other than "share".   
#######################DISA INFORMATION###############################

# Confirm that we actually have the pkg installed.  Both the directory/files for this GEN
# as well as the RPM must be missing in order for this check to stop execution of the script
if [ ! -d /etc/samba ] && ! rpm -q samba >/dev/null 2>&1 ; then
        exit 0
fi

#Global Variables#
PDI=GEN006225
SECURITYSHARE=$( grep -i security /etc/samba/smb.conf | grep -i share | grep -i "=" | wc -l )
#Start-Lockdown

if [ $SECURITYSHARE -ne 0 ]
  then
      sed -i 's/[[:blank:]]*security[[:blank:]]*=[[:blank:]]*share/        security = user/g' /etc/samba/smb.conf
fi

