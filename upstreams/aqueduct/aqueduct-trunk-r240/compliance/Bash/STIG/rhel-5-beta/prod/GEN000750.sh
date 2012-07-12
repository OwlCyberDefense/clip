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
#Group ID (Vulid): V-22306
#Group Title: GEN000750
#Rule ID: SV-26323r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000750
#Rule Title: The system must require that at least four characters be 
#changed between the old and new passwords during a password change.
#
#Vulnerability Discussion: To ensure that password changes are effective 
#in their goals, the system must ensure that old and new passwords have 
#significant differences. Without significant changes, new passwords 
#may be easily guessed based on the value of a previously compromised 
#password.
#
#Responsibility: System Administrator
#IAControls: IAIA-1, IAIA-2
#
#Check Content: 
#Check /etc/pam.d/system-auth for a pam_cracklib parameter difok.
#
#Procedure:
# more /etc/pam.d/system-auth | grep difok
#If difok is not present, or has a value less than 4, this is a finding.
#
#Check for system-auth-ac inclusions.
# grep -c system-auth-ac /etc/pam.d/*
#
#If the system-auth-ac file is included anywhere
# more /etc/pam.d/system-auth-ac | grep difok
#
#If system-auth-ac is included anywhere and difok is not present, 
#or has a value less than 4, this is a finding.
#
#Ensure that the passwd command uses the system-auth settings.
# grep system-auth /etc/pam.d/passwd
#If a line "password include system-auth" is not found then the 
#password checks in system-auth will not be applied to new passwords.
#
#
#Fix Text: If /etc/pam.d/system-auth references 
#/etc/pam.d/system-auth-ac refer to the man page for system-auth-ac 
#for a description of how to add options not configurable with 
#authconfig. Edit /etc/pam.d/system-auth and add or edit a pam_cracklib 
#entry with an difok parameter set equal to or greater than 4.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000750

#Start-Lockdown

#Addressed in GEN000460



