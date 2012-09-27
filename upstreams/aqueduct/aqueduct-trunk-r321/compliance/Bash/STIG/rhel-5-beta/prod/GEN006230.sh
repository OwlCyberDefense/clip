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
# on 13-Feb-2012 to add the option in the global section.
#
# Updated by Lee Kinser (lkinser@redhat.com) on 1 May 2012 to add logic
# for verifying the pkg is installed before attempting to configure it


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22500
#Group Title: GEN006230
#Rule ID: SV-26831r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006230
#Rule Title: Samba must be configured to use encrypted passwords.
#
#Vulnerability Discussion: Samba must be configured to protect authenticators.
#If Samba passwords are not encrypted for storage, plain-text user passwords
#may be read by those with access to the Samba password file.
#
#Responsibility: System Administrator
#IAControls: IAIA-1, IAIA-2
#
#Check Content: 
#Check the encryption setting the Samba configuration.
# grep -i 'encrypt passwords' /etc/samba/smb.conf
#If the setting is not present, or not set to 'yes', this is a finding.
#
#Fix Text: Edit the /etc/samba/smb.conf file and change the "encrypt passwords" setting to "yes".    
#######################DISA INFORMATION###############################

# Confirm that we actually have the pkg installed.  Both the directory/files for this GEN
# as well as the RPM must be missing in order for this check to stop execution of the script
if [ ! -d /etc/samba ] && ! rpm -q samba >/dev/null 2>&1 ; then
        exit 0
fi

#Global Variables#
PDI=GEN006230

ENCRYPTPASS=$( grep -i 'encrypt passwords' /etc/samba/smb.conf | wc -l )
#Start-Lockdown

if [ $ENCRYPTPASS -eq 0 ]
  then
    # Add to global section
    sed -i 's/\[global\]/\[global\]\n\n\tencrypt passwords = yes/g' /etc/samba/smb.conf
else
    sed -i 's/[[:blank:]]*encrypt[[:blank:]]passwords[[:blank:]]*=[[:blank:]]*no/        encrypt passwords = yes/g' /etc/samba/smb.conf
fi


