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
#Group ID (Vulid): V-22501
#Group Title: GEN006235
#Rule ID: SV-26832r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006235
#Rule Title: Samba must be configured to not allow guest access to shares.
#
#Vulnerability Discussion: Guest access to shares permits anonymous access and is not permitted.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the encryption setting the Samba configuration.
# grep -i 'guest ok' /etc/samba/smb.conf
#If the setting exists and is set to 'yes', this is a finding.
#
#Fix Text: Edit the /etc/samba/smb.conf file and change the "guest ok" setting to "no".   
#######################DISA INFORMATION###############################

# Confirm that we actually have the pkg installed.  Both the directory/files for this GEN
# as well as the RPM must be missing in order for this check to stop execution of the script
if [ ! -d /etc/samba ] && ! rpm -q samba >/dev/null 2>&1 ; then
        exit 0
fi

#Global Variables#
PDI=GEN006235
GUESTOK=$( grep -i 'guest ok' /etc/samba/smb.conf| grep -i yes | grep -v "^;" | grep -v "^#" | wc -l )
GUESTOk2=$( grep -i 'guest ok' /etc/samba/smb.conf| grep -i no | grep -v "^;" | grep -v "^#" | wc -l )
#Start-Lockdown

if [ $GUESTOK -eq 1 ]
  then
    sed -i 's/[[:blank:]]*guest[[:blank:]]ok[[:blank:]]*=[[:blank:]]*yes/        guest ok = no/g' /etc/samba/smb.conf
fi

if [ $GUESTOk2 -eq 0 ]
  then
      echo "#Added for DISA GEN006235" >> /etc/samba/smb.conf
    echo "        guest ok = no" >> /etc/samba/smb.conf
fi
