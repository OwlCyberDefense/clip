#!/bin/bash

##########################################################################
#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  
#  Vincent C. Passaro (vincent.passaro@gmail.com)
#  Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
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
##########################################################################

##################### Fusion Technology LLC #############################
# By Shannon Mitchell                                                   #
# Fusion Technology LLC                                                 #
# Shannon[.]Mitchell[@]fusiontechnology-llc[.]com                       #
# www.fusiontechnology-llc.com                                          #
##################### Fusion Technology LLC #############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Shannon Mitchell   | 15-jul-2012|
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-768
# Group Title: GEN000480
# Rule ID: SV-37213r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000480
# Rule Title: The delay between login prompts following a failed login 
# attempt must be at least 4 seconds.
#
# Vulnerability Discussion: Enforcing a delay between successive failed 
# login attempts increases protection against automated password guessing 
# attacks.
#
# Responsibility: System Administrator
# IAControls: ECLO-1, ECLO-2
#
# Check Content:
#
# Check the value of the FAIL_DELAY variable and the ability to use it.

# Procedure:
# grep FAIL_DELAY /etc/login.defs 
# If the value does not exist, or is less than 4, this is a finding.

# Check for the use of pam_faildelay.
# grep pam_faildelay /etc/pam.d/system-auth*
# If pam_faildelay.so module is not present, this is a finding.

# If pam_faildelay is present only in /etc/pam.d/system-auth-ac:
# ensure that /etc/pam.d/system-auth includes /etc/pam.d/system-auth-ac.
#grep system-auth-ac /etc/pam.d/system-auth

# This should return:
# auth include system-auth-ac
# account include system-auth-ac
# password include system-auth-ac
# session include system-auth-ac

# /etc/pam.d/system-auth-ac should only be included by 
# /etc/pam.d/system-auth. All other pam files should include 
# /etc/pam.d/system-auth. 

# If pam_faildelay is not defined in /etc/pam.d/system-auth either directly 
# or through inclusion of system-auth-ac, this is a finding.
#
# Fix Text: 
#
# Add the pam_faildelay module and set the FAIL_DELAY variable.

# Procedure:

# Edit /etc/login.defs and set the value of the FAIL_DELAY variable to 4 or 
# more.

# The default link /etc/pam.d/system-auth points to 
# /etc/pam.d/system-auth-ac which is the file maintained by the authconfig 
# utility. In order to add pam options other than those available via the 
# utility create or modify /etc/pam.d/system-auth-local with the options 
# and including system-auth-ac. For example:

# auth required pam_access.so
# auth optional pam_faildelay.so delay=4000000
# auth include system-auth-ac
# account include system-auth-ac
# password include system-auth-ac
# session include system-auth-ac

# Once system-auth-local is written ensure the /etc/pam.d/system-auth 
# points to system-auth-local. This is necessary because authconfig writes 
# directly to system-auth-ac so any manual changes made will be lost if 
# authconfig is run.   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000480
	
# Start-Lockdown

#####################################################################
# Set up custom config files if needed. This section will be appended
# to each script making pam config changes just in case.
#####################################################################

for PFPREFIX in system password smartcard fingerprint
do
  if [ -e "/etc/pam.d/${PFPREFIX}-auth-ac" ]
  then
    if [ ! -e "/etc/pam.d/${PFPREFIX}-auth-local" ]
    then
    
      cat <<EOF > /etc/pam.d/${PFPREFIX}-auth-local
auth          include       ${PFPREFIX}-auth-ac
account       include       ${PFPREFIX}-auth-ac
password      include       ${PFPREFIX}-auth-ac
session       include       ${PFPREFIX}-auth-ac
EOF

      ln -f -s /etc/pam.d/${PFPREFIX}-auth-local /etc/pam.d/${PFPREFIX}-auth
      chown root:root /etc/pam.d/${PFPREFIX}-auth-local
      chmod 644 /etc/pam.d/${PFPREFIX}-auth-local
      chcon system_u:object_r:etc_t /etc/pam.d/${PFPREFIX}-auth-local

    fi
  fi
done



# Run the fix
for PFPREFIX in system password smartcard fingerprint
do
  if [ -e "/etc/pam.d/${PFPREFIX}-auth-local" ]
  then

    # Fix the auth line
    egrep '^[^#]?auth.*pam_faildelay.*' /etc/pam.d/${PFPREFIX}-auth-local > /dev/null
    if [ $? != 0 ]
    then
      # Add the new entry if the line does not exist
      sed -i -e 's/\(^auth.*-auth-ac\)/auth          optional      pam_faildelay.so delay=4000000\n\1/' /etc/pam.d/${PFPREFIX}-auth-local
    else
      #Add the new argument if the line exists and the config does not
      egrep '^[^#]?auth.*pam_faildelay' /etc/pam.d/${PFPREFIX}-auth-local | grep delay=4000000 > /dev/null
      if [ $? != 0 ]
      then
        sed -i -e 's/\(^auth.*pam_faildelay.*$\)/\1 delay=4000000/' /etc/pam.d/${PFPREFIX}-auth-local
      fi
    fi

  fi
done



grep '^FAIL_DELAY' /etc/login.defs > /dev/null
if [ $? -eq 0 ]
then
  FAIL_DELAY=`awk '/FAIL_DELAY/{print $2}' /etc/login.defs`
  if [ "$FAIL_DELAY" != "4" ]
  then
    sed -i -e 's/\(FAIL_DELAY[^0-9]*\).*/\14/g' /etc/login.defs
  fi
else
  echo "" >> /etc/login.defs
  echo "# Added for STIG id GEN000480" >> /etc/login.defs
  echo 'FAIL_DELAY   4' >> /etc/login.defs
fi
