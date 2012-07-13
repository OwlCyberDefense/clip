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
#By Tummy a.k.a Vincent C. Passaro				     #
#Vincent[.]Passaro[@]gmail[.]com	         		     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4269-5
#Group Title: Unnecessary Accounts, Lp.
#Rule ID: SV-4269-5r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000290-5
#Rule Title: The system must not have the unnecessary "lp" account.
#
#Vulnerability Discussion: Accounts that provide no operational purpose 
#provide additional opportunities for system compromise. Unnecessary 
#accounts include user accounts for individuals not requiring access 
#to the system and application accounts for applications not installed 
#on the system.
#
#Responsibility: System Administrator
#IAControls: IAAC-1
#
#Check Content: 
#Check the system the unnecessary "lp" accounts.
#
#Procedure:
# grep ^lp /etc/passwd
#If this account exists, it is a finding.
#
#Fix Text: Remove the "lp" account from the /etc/password file 
#before connecting a system to the network.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000290-5
LPACCOUNT=`grep -c '^lp' /etc/passwd`

#Start-Lockdown

if [ $LPACCOUNT -ne 0	]
  then
    userdel lp 
fi

