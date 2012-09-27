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
#
#
#  - Updated by shannon.mitchell@fusiontechnology-llc.com on 27-dec-2011.
# The shutdown and reboot userdel calls were reversed and needed fixed.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4268
#Group Title: Special Privileged Accounts
#Rule ID: SV-4268r5_rule
#Severity: CAT I
#Rule Version (STIG-ID): GEN000000-LNX00320
#Rule Title: The system must not have special privilege accounts, such 
#as shutdown and halt.
#
#Vulnerability Discussion: If special privilege accounts are compromised, 
#the accounts could provide privileges to execute malicious commands on 
#a system.
#
#Responsibility: System Administrator
#IAControls: IAAC-1
#
#Check Content: 
#Perform the following to check for unnecessary privileged accounts:
#
# grep "^shutdown" /etc/passwd /etc/shadow
# grep "^halt" /etc/passwd /etc/shadow
# grep "^reboot" /etc/passwd /etc/shadow
#
#If any unnecessary privileged accounts exist this is a finding.
#
#
#Fix Text: Remove any special privilege accounts, such as shutdown and 
#halt, from the /etc/passwd and /etc/shadow files.  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000000-LNX00320
HALTACCOUNT=`grep -c '^halt' /etc/passwd`
SHUTDOWNACCOUNT=`grep -c '^shutdown' /etc/passwd`
REBOOTACCOUNT=`grep -c '^reboot' /etc/passwd`

#Start-Lockdown

if [ $HALTACCOUNT -ne 0	]
  then
    userdel halt 
fi

if [ $SHUTDOWNACCOUNT -ne 0 ]
  then
    userdel shutdown 
fi

if [ $REBOOTACCOUNT -ne 0 ]
  then
    userdel reboot 
fi



