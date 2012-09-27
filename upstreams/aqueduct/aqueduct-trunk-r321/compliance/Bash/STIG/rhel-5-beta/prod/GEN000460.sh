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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 30-dec-2011 to add documentation and comment out the pam_cracklib entry
# in the main /etc/pam.d/system-auth-ac as it overrides the system-auth-local
# entry after throwing up errors.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-766
#Group Title: After three consecutive unsuccessful login attempt
#Rule ID: SV-27090r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000460
#Rule Title: The system must disable accounts after three consecutive 
#unsuccessful login attempts.
#
#Vulnerability Discussion: Disabling accounts after a limited number 
#of unsuccessful login attempts improves protection against password 
#guessing attacks.
#

#
#Responsibility: System Administrator
#IAControls: ECLO-1, ECLO-2
#
#Check Content: 
#Check the pam_tally configuration.
# more /etc/pam.d/system-auth
#Confirm the following line is configured, before any "auth sufficient" lines:
#auth required pam_tally2.so deny=3
#If no such line is found, this is a finding.
#
#Fix Text: By default link /etc/pam.d/system-auth points to 
#/etc/pam.d/system-auth-ac which is the file that is maintained but 
#the autoconfig utility. In order to add pam options other than 
#those available via the utility create /etc/pam.d/system-auth-local 
#with the options and including system-auth-ac. For example in order 
#to set the account lockout to three failed attempts the content 
#should be something like:
#
#auth requisite pam_access.so
#auth requisite pam_tally2.so deny=3
#auth include system-auth-ac
#account required pam_tally2.so
#account include system-auth-ac
#password include system-auth-ac
#session include system-auth-ac
#
#Once system-auth-local is written reset the /etc/pam.d/system-auth 
#to point to system-auth-local. This is necessary because authconfig 
#writes directly to system-auth-ac so any changes made by hand will 
#be lost if authconfig is run. 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000460

#Start-Lockdown

if [ ! -a "/etc/pam.d/system-auth-local" ]
  then
    cat <<-EOF > /etc/pam.d/system-auth-local

#Added by Vincent C. Passaro
#To meet requirement of GEN000480 | GEN000460 | GEN000580 | GEN000600-1 | GEN000610 | GEN000620 | GEN000640 | GEN000680 | GEN000750 | GEN000790 | 
# GEN000460  (pam_tally2: deny=3)
# GEN000480  (pam_tally2: lock_time=4)
# GEN000580  (pam_cracklib: minlen=14)
# GEN000600-1(pam_cracklib:  ucredit=-1)
# GEN000610  (pam_cracklib:  lcredit=-1)
# GEN000620  (pam_cracklib:  dcredit=-1)
# GEN000640  (pam_cracklib:  ocredit=-1)
# GEN000680  (pam_cracklib:  maxrepeat=3)
# GEN000750  (pam_cracklib:  difok=4)
# GEN000790  (pam_cracklib:  pam_cracklib does this by default)

auth          requisite     pam_access.so
auth          requisite     pam_tally2.so deny=3 lock_time=4
auth          include       system-auth-ac
account       required      pam_tally2.so
account       include       system-auth-ac
password      required      pam_cracklib.so minlen=14 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1 maxrepeat=3 difok=4
password      include       system-auth-ac
session       include       system-auth-ac

EOF

ln -f -s /etc/pam.d/system-auth-local /etc/pam.d/system-auth

# Comment out the original pam_craclkib from system-auth-ac as it overrides
# the one in the system-auth-local file after throwning errors.
grep '^password    requisite     pam_cracklib.so try_first_pass retry=3' /etc/pam.d/system-auth-ac > /dev/null
if [ $? -eq 0 ]
then
  sed -i -e 's/password    requisite     pam_cracklib.so try_first_pass retry=3/#&/g' /etc/pam.d/system-auth-ac
fi

fi

