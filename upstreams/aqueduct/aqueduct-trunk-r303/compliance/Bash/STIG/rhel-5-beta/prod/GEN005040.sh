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
#Group ID (Vulid): V-12011
#Group Title: FTP User’s umask
#Rule ID: SV-12512r3_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005040
#Rule Title: All FTP gssftp users must have a default umask of 077.
#
#Vulnerability Discussion: The umask controls the default access mode assigned to newly created files. A umask of 077 limits new files to mode 700 or less permissive. Although umask is stored as a 4-digit number, the first digit representing special access modes is typically ignored or required to be zero (0).
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Check the umask setting for FTP users.
#
#Procedure:
#Assuming an anonymous ftp user has been defined with no user initialization script invoked to change the umask
# ftp localhost
#Name: (localhost:root): anonymous
#Password: anything
#ftp>umask
#
#If the umask value returned is not 077, this is a finding.
#or:
#grep "server_args" /etc/xinetd.d./gssftp
#
#The default umask for FTP is "023" if the server _args entry does not contain "-u 077" this is a finding.
#
#Fix Text: Edit the initialization files for the ftp user and set the umask to 077.
#
#Procedure:
#Modify the /etc/xinetd.d/gssftp file adding "-u 077" to the server_args entry.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005040
FTPUMASK=$( cat /etc/xinetd.d/gssftp | grep server_args | grep 077 | wc -l )
#Start-Lockdown

#Check if gssftp is installed
if [ -a '/etc/xinetd.d/gssftp' ]
  then
    if [ $FTPUMASK -eq 0 ]
      then
        #Append umask setting to end of line...not delete the whole line
        sed -i '/.*server_args.*/s/$/ -u 077/' /etc/xinetd.d/gssftp
    fi
fi

