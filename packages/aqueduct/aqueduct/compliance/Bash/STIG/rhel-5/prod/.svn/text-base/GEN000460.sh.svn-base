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
# Group ID (Vulid): V-766
# Group Title: GEN000460
# Rule ID: SV-37203r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000460
# Rule Title: The system must disable accounts after three consecutive 
# unsuccessful login attempts.
#
# Vulnerability Discussion: Disabling accounts after a limited number of 
# unsuccessful login attempts improves protection against password guessing 
# attacks.
#
# Responsibility: System Administrator
# IAControls: ECLO-1, ECLO-2
#
# Check Content:
#
# Check the pam_tally configuration.
# more /etc/pam.d/system-auth 
# Confirm the following line is configured, before any "auth sufficient" 
# lines:
# auth required pam_tally2.so deny=3 
# If no such line is found, this is a finding.
#
# Fix Text: 
#
# By default link /etc/pam.d/system-auth points to 
# /etc/pam.d/system-auth-ac which is the file maintained by the authconfig 
# utility. In order to add pam options other than those available via the 
# utility create /etc/pam.d/system-auth-local with the options and 
# including system-auth-ac. In order to set the account lockout to three 
# failed attempts the content should be similar to:

# auth required pam_access.so
# auth required pam_tally2.so deny=3
# auth include system-auth-ac
# account required pam_tally2.so
# account include system-auth-ac
# password include system-auth-ac
# session include system-auth-ac

# Once system-auth-local is written reset the /etc/pam.d/system-auth to 
# point to system-auth-local. This is necessary because authconfig writes 
# directly to system-auth-ac so any changes made by hand will be lost if 
# authconfig is run.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000460
	
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
    egrep '^[^#]?auth.*pam_tally2.*' /etc/pam.d/${PFPREFIX}-auth-local > /dev/null
    if [ $? != 0 ]
    then
      # Add the new entry if the line does not exist
      sed -i -e 's/\(^auth.*-auth-ac\)/auth          required      pam_tally2.so deny=3\n\1/' /etc/pam.d/${PFPREFIX}-auth-local
    else
      #Add the new argument if the line exists and the config does not
      egrep '^[^#]?auth.*pam_tally2' /etc/pam.d/${PFPREFIX}-auth-local | grep deny=3 > /dev/null
      if [ $? != 0 ]
      then
        sed -i -e 's/\(^auth.*pam_tally2.*$\)/\1 deny=3/' /etc/pam.d/${PFPREFIX}-auth-local
      fi
    fi

    # Fix the account line
    egrep '^[^#]?account.*pam_tally2.*' /etc/pam.d/${PFPREFIX}-auth-local > /dev/null
    if [ $? != 0 ]
    then
      # Add the new entry if the line does not exist
      sed -i -e 's/\(^account.*-auth-ac\)/account       required      pam_tally2.so\n\1/' /etc/pam.d/${PFPREFIX}-auth-local
    fi 
  fi
done
