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
# on 02-jan-2012.
#    - added check to update the /etc/login.defs so new accounts have a pass
#      min length of 14.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-11947
#Group Title: Password Length
#Rule ID: SV-27114r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000580
#Rule Title: The system must require that passwords contain a minimum 
#of 14 characters.
#
#Vulnerability Discussion: The use of longer passwords reduces the 
#ability of attackers to successfully obtain valid passwords using 
#guessing or exhaustive search techniques by increasing the password 
#search space.
#
#Responsibility: System Administrator
#IAControls: IAIA-1, IAIA-2
#
#Check Content: 
#Check the system password length setting.
#
#Procedure:
#Check the password minlen option
# more /etc/pam.d/system-auth | grep pam_cracklib.so
#
#Confirm the minlen option is set to at least 14 as in the example:
#
#password required pam_cracklib.so minlen=14
#
#There may be other options on the line. If no such line is found, 
#or the minlen is less than 14 this is a finding.
#
#
#
#Fix Text: Edit "/etc/pam.d/system-auth" to include the line:
#
#password required pam_cracklib.so minlen=14
#
#prior to the "password include system-auth-ac" line. 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000580

#Start-Lockdown


# pam configuration addressed in GEN000460



# update the login.defs to set the PASS_MIN_LEN setting
grep '^PASS_MIN_LEN' /etc/login.defs > /dev/null
if [ $? -eq 0 ]
then
  PASS_MIN_LEN=`awk '/PASS_MIN_LEN/{print $2}' /etc/login.defs`
  if [ "$PASS_MIN_LEN" != "14" ]
  then
    sed -i -e 's/\(PASS_MIN_LEN[^0-9]*\).*/\114/g' /etc/login.defs
  fi
else
  echo "" >> /etc/login.defs
  echo "# Added for STIG id $PDI" >> /etc/login.defs
  echo 'PASS_MIN_LEN   14' >> /etc/login.defs
fi

