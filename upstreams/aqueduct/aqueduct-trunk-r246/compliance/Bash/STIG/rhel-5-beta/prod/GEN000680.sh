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
#Group ID (Vulid): V-11975
#Group Title: Password Contents
#Rule ID: SV-27128r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000680
#Rule Title: The system must require that passwords contain no more 
#than three consecutive repeating characters.
#
#Vulnerability Discussion: To enforce the use of complex passwords, 
#the number of consecutive repeating characters is limited. Passwords 
#with excessive repeated characters may be more vulnerable to 
#password-guessing attacks.
#
#Responsibility: System Administrator
#IAControls: IAIA-1, IAIA-2
#
#Check Content: 
#Check the maxrepeat setting.
#
#Procedure:
#Check the password maxrepeat configuration
# more /etc/pam.d/system-auth | grep pam_cracklib.so
#
#If the maxrepeat option is missing, this is a finding.
#If the maxrepeat option is set to more than 3, this is a finding.
#
#
#
#Fix Text: Edit "/etc/pam.d/system-auth" to include the line:
#
#password required pam_cracklib.so maxrepeat=3
#
#prior to the "password include system-auth-ac" line.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000680

#Start-Lockdown

#Addressed in GEN000460

