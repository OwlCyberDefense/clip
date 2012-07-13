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
#Group ID (Vulid): V-11977
#Group Title: Password Change Every Year
#Rule ID: SV-12478r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000740
#Rule Title: All non-interactive/automated processing account passwords must be changed at least once per year or be locked.
#
#Vulnerability Discussion: Limiting the lifespan of authenticators limits the period of time an unauthorized user has access to the system while using compromised credentials and reduces the period of time available for password-guessing attacks to run against a single password. Locking the password for non-interactive and automated processing accounts is preferred as it removes the possibility of accessing the account by a password. On some systems, locking the passwords of these accounts may prevent the account from functioning properly. Passwords for non-interactive/automated processing accounts must not be used for direct logon to the system.
#
#Responsibility: System Administrator
#IAControls: IAIA-1, IAIA-2
#
#Check Content: 
#Ask the SA if there are any automated processing accounts on the system. If there are automated processing accounts on the system, ask the SA if the passwords for those automated accounts are changed at least once a year. If SA indicates passwords for automated processing accounts are not changed once per year, this is a finding.
#
#Fix Text: Implement or establish procedures to change the passwords of automated processing accounts at least once per year.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000740

#Start-Lockdown

