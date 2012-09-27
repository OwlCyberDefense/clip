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
#Group ID (Vulid): V-849
#Group Title: TFTP Configuration
#Rule ID: SV-849r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005120
#Rule Title: The TFTP daemon must be configured to vendor specifications, including a dedicated TFTP user account, a non-login shell such as /bin/false, and a home directory owned by the TFTP user.
#
#Vulnerability Discussion: If TFTP has a valid shell, it increases the likelihood that someone could logon to the TFTP account and compromise the system.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the /etc/passwd file to determine if TFTP is configured properly.
#
#Procedure:
# grep tftp /etc/passwd
#
#If a "tftp" user account does not exist and TFTP is active, this is a finding.
#
#Check the user shell for the "tftp" user. If it is not /bin/false or equivalent, this is a finding.
#
#Check the home directory assigned to the "tftp" user. If no home directory is set, or the directory specified is not dedicated to the use of the TFTP service, this is a finding.
#
#Fix Text: Create a "tftp" user account if none exists.
#Assign a non-login shell to the "tftp" user account, such as /bin/false.
#Assign a home directory to the "tftp" user account.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005120
TFTPACCOUNT=$(cat /etc/passwd | grep -i tftp| wc -l)

#Start-Lockdown

#Check if tftp server is installed
if [ -a /etc/xinetd.d/tftp ]
  then
    #check if tftp account isn't already there.
    if [ $TFTPACCOUNT -ne 1 ]
      then
        #Create the user account
        useradd -r -s /bin/false -c "tftp account used for GEN005120" -d /tftpboot/ tftp
        #Lock the account
        usermod -L tftp
    fi
fi




