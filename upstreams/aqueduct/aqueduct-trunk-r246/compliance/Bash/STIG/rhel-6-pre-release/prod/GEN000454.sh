#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com )
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
#By Shannon Mitchell                                                 #
#shannon.mitchell@fusiontechnology-llc.com                           #
######################################################################
#
#  - Created by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com) 
# to create an /etc/pam.d/password-auth-local and add pam_lastlog to it for
# RHEL6.

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22300
#Group Title: GEN000454
#Rule ID: SV-26312r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN000454
#Rule Title: The system must display the number of unsuccessful login 
#attempts since the last successful login for a user account upon login.
#
#Vulnerability Discussion: Providing users with feedback on recent login 
#failures facilitates user recognition and reporting of attempted 
#unauthorized account use.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check that pam_lastlog is used, not silent, and configured to show 
#failed logins.
#
# grep pam_lastlog /etc/pam.d/sshd /etc/pam.d/password-auth
#
#This is a finding if:
#- pam_lastlog is configured with the "silent" option.
#
#This is a finding unless:
#- pam_lastlog is present in sshd and password-auth, or only password-auth 
#if sshd calls system-auth with the auth include statement.
#- pam_lastlog is configured with the "showfailed" option.
#
#Fix Text: Configure pam_lastlog.
#
#Edit /etc/pam.d/sshd or /etc/pam.d/password-auth (if included from sshd) 
#and make the following changes:
#- if pam_lastlog is not present, add it: "session required 
#pam_lastlog.so showfailed"
#- if pam_lastlog has the "silent" option specified, remove it.
#- if pam_lastlog does not have the "showfailed" option specified, add it.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000454


#Start-Lockdown

# Create the password-auth-local configuration if not there already.
if [ ! -e /etc/pam.d/password-auth-local ]
then

cat << EOF > /etc/pam.d/password-auth-local
auth       include      password-auth-ac
account    include      password-auth-ac
password   include      password-auth-ac
session    include      password-auth-ac

EOF


  chmod 644 /etc/pam.d/password-auth-local
  chown root:root /etc/pam.d/password-auth-local
  mv /etc/pam.d/password-auth /etc/pam.d/password-auth.orig
  ln -s /etc/pam.d/password-auth-local /etc/pam.d/password-auth
fi

# Add the pam_lastlog entry
grep -c "session    required     pam_lastlog.so" /etc/pam.d/password-auth-local > /dev/null
if [ $? -ne 0 ]
then
  echo "#Added to meet requirements for GEN000452" >> /etc/pam.d/password-auth-local
  echo "session    required     pam_lastlog.so showfailed" >> /etc/pam.d/password-auth-local
fi


