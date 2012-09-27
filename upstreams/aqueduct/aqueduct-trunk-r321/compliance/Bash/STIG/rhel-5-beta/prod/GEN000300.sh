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
#####################Fotis Networks LLC###############################
#By Tummy a.k.a Vincent C. Passaro				     #
#Fotis Networks LLC						     #
#Vincent[.]Passaro[@]fotisnetworks[.]com			     #
#www.fotisnetworks.com						     #
######################Fotis Networks LLC##############################

#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-761
#Group Title: Accounts have the same user or account name.
#Rule ID: SV-27063r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000300
#Rule Title: All accounts on the system must have unique user or 
#account names.
#
#Vulnerability Discussion: A unique user name is the first part of the 
#identification and authentication process. If user names are not unique, 
#there can be no accountability on the system for auditing purposes. 
#Multiple accounts sharing the same name could result in the denial of 
#service to one or both of the accounts or unauthorized access to files 
#or privileges.
#
#Responsibility: System Administrator
#IAControls: IAIA-1, IAIA-2
#
#Check Content: 
#Check the system for duplicate account names.
#
#Example:
# pwck -r
#
#If any duplicate account names are found, this is a finding.
#
#Fix Text: Change user account names, or delete accounts, so 
#that each account has a unique name.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000300

#Start-Lockdown
DUPACC=`awk -F ':' '{print $1}' /etc/passwd | sort | uniq -d | tr "\n" " "`
if [ "$DUPACC" != "" ]
then
  echo "------------------------------" > $PDI-error.log
  date >> $PDI-error.log
  echo " " >> $PDI-error.log
  echo "The following accounts are duplicates: $DUPACC" >> $PDI-error.log
  echo " " >> $PDI-error.log
  echo "Please review these accounts" >> $PDI-error.log
  echo "------------------------------" >> $PDI-error.log
fi
