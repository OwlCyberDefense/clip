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
#Vincent Passaro on Apr 4th 2012. 
#Updated to check if config file exists before making adjustments
#
#######################DISA INFORMATION###############################
#Rule ID: SV-12512r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005040-1
#Rule Title: All FTP vsftp users must have a default umask of 077.
#
#Vulnerability Discussion: The umask controls the default access mode assigned to newly created files. A umask of 077 limits new files to mode 700 or less permissive. Although umask is stored as a 4-digit number, the first digit representing special access modes is typically ignored or required to be zero (0).
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Check the umask setting for vsftp users.
#
#Procedure:
#
# grep "_mask" /etc/vsftpd/vsftpd.conf
#The default "local_umask" setting is 077. if this has been changed, or the "anon_umask" setting is not 077, this is a finding.
#
#
#Fix Text: Edit "/etc/vsftpd/vsftpd.conf" and set the umask to 077.
#
#Procedure:GEN005040-1
#Modify the "/etc/vsftpd/vsftpd.conf" setting "local_umask" and "anon_umask" to 077. 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005040-1

#Start-Lockdown

if [ -e /etc/vsftpd/vsftpd.conf ]
  then
    MASKLEVEL=$( grep -i  "mask=" /etc/vsftpd/vsftpd.conf | cut -d '=' -f 2 )
	if [ $MASKLEVEL -lt 077 ]
	  then
        sed -i "/local_umask=/ c\local_umask=077" /etc/vsftpd/vsftpd.conf
    fi
fi



