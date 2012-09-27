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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 23-jan-2012 to add a check to only lock non-root system accounts if
# they are not currently locked.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-810
#Group Title: Disabled default system accounts
#Rule ID: SV-810r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002640
#Rule Title: Default system accounts must be disabled or removed.
#
#Vulnerability Discussion: Vendor accounts and software may contain 
#backdoors that will allow unauthorized access to the system. These 
#backdoors are common knowledge and present a threat to system security 
#if the account is not disabled.
#
#Responsibility: System Administrator
#IAControls: IAAC-1
#
#Check Content: 
#Determine if default system accounts (such as those for sys, bin, uucp, 
#nuucp, daemon, smtp) have been disabled.
# cat /etc/shadow
#If an account's password field is "*", "*LK*", or is prefixed with a '!', 
#the account is locked or disabled.
#If there are any default system accounts that are not locked this is a 
#finding.
#
#Fix Text: Lock the default system account(s).
# passwd -l <user>
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002640

#Start-Lockdown
for NAME in `awk -F':' '!/^root/{if($3 < 500)print $1}' /etc/passwd`
do
  egrep "^${NAME}:(\!|\*|\*LK\*)" /etc/shadow > /dev/null
  if [ $? -ne 0 ]
  then
    usermod -L $NAME
  fi
done

