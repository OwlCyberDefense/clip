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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com) on 
# 02-jan-2012 to fix the check and logging conditional. 
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-773
#Group Title: An account other than root has a UID of 0.
#Rule ID: SV-773r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000880
#Rule Title: The root account must be the only account having a UID of 0.
#
#Vulnerability Discussion: If an account has a UID of 0, it has root 
#authority. Multiple accounts with a UID of 0 afford more opportunity 
#for potential intruders to guess a password for a privileged account.
#
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the system for duplicate UID 0 assignments by listing all 
#accounts assigned UID 0.
#
#Procedure:
# cat /etc/passwd | awk -F":" '{print$1":"$3":"}' | grep ":0:"
#
#If any accounts other than root are assigned UID 0, this is a finding.
#
#Fix Text: Remove or change the UID of accounts other than root that have UID 0.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000880

ROOTACCOUNTLIST=`awk -F ':' '!/^root/{if($3 == 0)print $1}' /etc/passwd`

#Start-Lockdown

if [ "$ROOTACCOUNTLIST" != "" ]
  then
    echo "------------------------------" > $PDI-ROOTACCOUNTS.log
    date >> $PDI-ROOTACCOUNTS.log
    echo " " >> $PDI-ROOTACCOUNTS.log
    echo "The following accounts are sharing the UID 0" >> $PDI-ROOTACCOUNTS.log
    echo " " >> $PDI-ROOTACCOUNTS.log
    echo $ROOTACCOUNTLIST >> $PDI-ROOTACCOUNTS.log
    echo "------------------------------" >> $PDI-ROOTACCOUNTS.log
fi


