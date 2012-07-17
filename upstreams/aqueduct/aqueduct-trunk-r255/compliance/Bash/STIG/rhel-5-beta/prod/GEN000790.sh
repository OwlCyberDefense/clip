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
#Group ID (Vulid): V-22307
#Group Title: GEN000790
#Rule ID: SV-26344r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000790
#Rule Title: The system must prevent the use of dictionary words for 
#passwords.
#
#Vulnerability Discussion: An easily guessable password provides an 
#open door to any external or internal malicious intruder. Many 
#computer compromises occur as the result of account name and password 
#guessing. This is generally done by someone with an automated script 
#that uses repeated logon attempts until the correct account and 
#password pair is guessed. Utilities, such as cracklib, can be used 
#to validate that passwords are not dictionary words and meet other 
#criteria during password changes.
#
#Responsibility: System Administrator
#IAControls: IAIA-1, IAIA-2
#
#Check Content: 
#Check /etc/pam.d/system-auth for pam_cracklib configuration.
#
#Procedure:
# more /etc/pam.d/system-auth | grep pam_cracklib
#If pam_cracklib is not present. This is a finding.
#
#Check for system-auth-ac inclusions.
# grep -c system-auth-ac /etc/pam.d/*
#
#If the system-auth-ac file is included anywhere
# more /etc/pam.d/system-auth-ac | grep pam_cracklib
#
#If system-auth-ac is included anywhere and pam_cracklib is not
#present. This is a finding.
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
#authconfig. Edit /etc/pam.d/system-auth and configure pam_cracklib 
#by adding a line such as "password required pam_cracklib.so"   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000790

#Start-Lockdown

#Addressed in GEN000460

