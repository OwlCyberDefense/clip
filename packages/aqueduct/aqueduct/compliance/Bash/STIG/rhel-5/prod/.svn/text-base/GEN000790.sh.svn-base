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
# Group ID (Vulid): V-22307
# Group Title: GEN000790
# Rule ID: SV-37318r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000790
# Rule Title: The system must prevent the use of dictionary words for 
# passwords.
#
# Vulnerability Discussion: An easily guessable password provides an open 
# door to any external or internal malicious intruder.  Many computer 
# compromises occur as the result of account name and password guessing.  
# This is generally done by someone with an automated script that uses 
# repeated logon attempts until the correct account and password pair is 
# guessed.  Utilities, such as cracklib, can be used to validate passwords 
# are not dictionary words and meet other criteria during password changes.
#
# Responsibility: System Administrator
# IAControls: IAIA-1, IAIA-2
#
# Check Content:
#
# Check /etc/pam.d/system-auth for pam_cracklib configuration.

# Procedure:
# grep pam_cracklib /etc/pam.d/system-auth*
# If pam_cracklib is not present. This is a finding.

# If pam_cracklib is present only in /etc/pam.d/system-auth-ac:
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

# If pam_cracklib is not defined in /etc/pam.d/system-auth either directly 
# or through inclusion of system-auth-ac, this is a finding.

# Ensure the passwd command uses the system-auth settings.
# grep system-auth /etc/pam.d/passwd

# If a line "password include system-auth" is not found then the password 
# checks in system-auth will not be applied to new passwords, this is a 
# finding.
#
# Fix Text: 
#
# If /etc/pam.d/system-auth references /etc/pam.d/system-auth-ac refer to 
# the man page for system-auth-ac for a description of how to add options 
# not configurable with authconfig. Edit /etc/pam.d/system-auth and 
# configure pam_cracklib by adding a line such as "password required 
# pam_cracklib.so"  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000790
	
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


# Comment out the original pam_craclkib from system-auth-ac as it overrides
# the one in the system-auth-local file after throwning errors.
for PFPREFIX in system password smartcard fingerprint
do
  if [ -e "/etc/pam.d/${PFPREFIX}-auth-local" ]
  then
    grep '^password    requisite     pam_cracklib.so try_first_pass retry=3' /etc/pam.d/${PFPREFIX}-auth-ac > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/password    requisite     pam_cracklib.so try_first_pass retry=3/#&/g' /etc/pam.d/${PFPREFIX}-auth-ac
    fi
  fi
done



# Run the fix
for PFPREFIX in system password smartcard fingerprint
do
  if [ -e "/etc/pam.d/${PFPREFIX}-auth-local" ]
  then

    # Fix the password line
    egrep '^[^#]?password.*pam_cracklib.*' /etc/pam.d/${PFPREFIX}-auth-local > /dev/null
    if [ $? != 0 ]
    then
      # Add the new entry if the line does not exist
      sed -i -e 's/\(^password.*-auth-ac\)/password      required      pam_cracklib.so ucredit=-1\n\1/' /etc/pam.d/${PFPREFIX}-auth-local
    fi
  fi
done
