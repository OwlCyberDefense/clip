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
# Group ID (Vulid): V-22306
# Group Title: GEN000750
# Rule ID: SV-37304r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000750
# Rule Title: The system must require at least four characters be changed 
# between the old and new passwords during a password change.
#
# Vulnerability Discussion: To ensure password changes are effective in 
# their goals, the system must ensure that old and new passwords have 
# significant differences.  Without significant changes, new passwords may 
# be easily guessed based on the value of a previously compromised password.
#
# Responsibility: System Administrator
# IAControls: IAIA-1, IAIA-2
#
# Check Content:
#
# Check /etc/pam.d/system-auth for a pam_cracklib parameter difok. 

# Procedure:
# grep difok /etc/pam.d/system-auth
# If difok is not present, or has a value less than 4, this is a finding.

# Check for system-auth-ac inclusions.
# grep -c system-auth-ac /etc/pam.d/*

# If the system-auth-ac file is included anywhere
# more /etc/pam.d/system-auth-ac | grep difok

# If system-auth-ac is included anywhere and difok is not present, or has a 
# value less than 4, this is a finding.

# Ensure the passwd command uses the system-auth settings.
# grep system-auth /etc/pam.d/passwd
# If a line "password include system-auth" is not found then the password 
# checks in system-auth will not be applied to new passwords.
#
# Fix Text: 
#
# If /etc/pam.d/system-auth references /etc/pam.d/system-auth-ac refer to 
# the man page for system-auth-ac for a description of how to add options 
# not configurable with authconfig. Edit /etc/pam.d/system-auth and add or 
# edit a pam_cracklib entry with an difok parameter set equal to or greater 
# than 4.   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000750
	
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



# password required pam_cracklib.so difok=4
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
      sed -i -e 's/\(^password.*-auth-ac\)/password      required      pam_cracklib.so difok=4\n\1/' /etc/pam.d/${PFPREFIX}-auth-local
    else
      #Add the new argument if the line exists and the config does not
      egrep '^[^#]?password.*pam_cracklib' /etc/pam.d/${PFPREFIX}-auth-local | grep difok=4 > /dev/null
      if [ $? != 0 ]
      then
        sed -i -e 's/\(^password.*pam_cracklib.*$\)/\1 difok=4/' /etc/pam.d/${PFPREFIX}-auth-local
      fi
    fi
  fi
done
