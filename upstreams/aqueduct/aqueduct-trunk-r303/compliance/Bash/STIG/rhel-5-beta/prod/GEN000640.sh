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
#Group ID (Vulid): V-11973
#Group Title: Password Character Mix
#Rule ID: SV-27125r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000640
#Rule Title: The system must require that passwords contain at least 
#one special character.
#
#Vulnerability Discussion: To enforce the use of complex passwords, 
#minimum numbers of characters of different classes are mandated. The 
#use of complex passwords reduces the ability of attackers to 
#successfully obtain valid passwords using guessing or exhaustive 
#search techniques. Complexity requirements increase the password 
#search space by requiring users to construct passwords from a larger 
#character set than they may otherwise use.
#
#Responsibility: System Administrator
#IAControls: IAIA-1, IAIA-2
#
#Check Content: 
#Check the ocredit setting.
#
#Procedure:
#Check the password ocredit option
# more /etc/pam.d/system-auth | grep pam_cracklib.so
#
#Confirm the ocredit option is set to -1 as in the example:
#
#password required pam_cracklib.so ocredit=-1
#
#There may be other options on the line. If no such line is found, 
#or the ocredit is not -1 this is a finding.
#
#
#
#
#Fix Text: Edit "/etc/pam.d/system-auth" to include the line:
#
#password required pam_cracklib.so ocredit=-1
#
#prior to the "password include system-auth-ac" line.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000640

#Start-Lockdown

#Addressed in GEN000460


