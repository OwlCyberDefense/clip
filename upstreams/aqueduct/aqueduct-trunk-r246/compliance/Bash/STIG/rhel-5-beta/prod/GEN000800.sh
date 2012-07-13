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
# Updated by Vincent C. Passaro (vincent.passaro@fotisnetworks.com)
#  Replaced 12 to 5
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4084
#Group Title: Password reuse checks.
#Rule ID: SV-27135r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000800
#Rule Title: The system must prohibit the reuse of passwords within 
#five iterations.
#
#Vulnerability Discussion: If a user, or root, used the same password 
#continuously or was allowed to change it back shortly after being 
#forced to change it to something else, it would provide a potential 
#intruder with the opportunity to keep guessing at one user's password 
#until it was guessed correctly.
#
#
#Responsibility: System Administrator
#IAControls: IAIA-1, IAIA-2
#
#Check Content: 
# ls /etc/security/opasswd
#If /etc/security/opasswd does not exist, then this is a finding.
#
# more /etc/pam.d/system-auth | grep password | grep pam_unix.so | 
#grep remember
#If the "remember" option in /etc/pam.d/system-auth is not set to 5, 
#this is a finding.
#
#Check for system-auth-ac inclusions.
# grep -c system-auth-ac /etc/pam.d/*
#
#If the system-auth-ac file is included anywhere
# more /etc/pam.d/system-auth-ac | grep password | grep pam_unix.so | 
#grep remember
#
#If in /etc/pam.d/system-auth-ac is referenced by another file and the 
#"remember" option is not set to 5 this is a finding.
#
#Fix Text: Create the password history file.
# touch /etc/security/opasswd
# chown root:root /etc/security/opasswd
# chmod 0600 /etc/security/opasswd
#
#Enable password history.
#If /etc/pam.d/system-auth references /etc/pam.d/system-auth-ac refer 
#to the man page for system-auth-ac for a description of how to add 
#options not configurable with authconfig. Edit /etc/pam.d/system-auth 
#to include the remember option on the "password pam_cracklib" lines set to 5.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000800

#Start-Lockdown

sed -i '/password    sufficient    pam_unix.so/ {/remember=5/! s/.*/& remember=5/}' /etc/pam.d/system-auth-ac

if [ -a "/etc/security/opasswd" ]
  then
    touch /etc/security/opasswd
    chown root:root /etc/security/opasswd
    chmod 0600 /etc/security/opasswd
fi


    

