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
#  - Update by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 05-jan-2012 to add a check for the inn package to keep from leaving
# files and directories without a valid user.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4269-2
#Group Title: Unnecessary Accounts, News.
#Rule ID: SV-4269-2r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000290-2
#Rule Title: The system must not have the unnecessary "news" account.
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
#Check the system the unnecessary "news" accounts.
#
#Procedure:
# grep ^news /etc/passwd
#If this account exists, it is a finding.

#Fix Text: Remove the "news" account from the /etc/password file 
#before connecting a system to the network.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000290-2
NEWSACCOUNT=`grep -c '^news' /etc/passwd`
#Start-Lockdown

if [ $NEWSACCOUNT -ne 0	]
  then
    userdel news

    # After running GEN001160.sh it seems removing the news user leaves
    # a bunch of stale files if inn is installed.  This seems like a good
    # place to uninstall it.
    rpm -q inn > /dev/null
    if [ $? -eq 0 ]
    then
      rpm -e inn > /dev/null
    fi
  
fi 



