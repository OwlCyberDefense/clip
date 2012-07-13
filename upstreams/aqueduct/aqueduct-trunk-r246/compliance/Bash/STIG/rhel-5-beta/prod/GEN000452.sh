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
#Group ID (Vulid): V-22299
#Group Title: GEN000452
#Rule ID: SV-26309r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN000452
#Rule Title: The system must display the date and time of the last 
#successful account login upon login.
#
#Vulnerability Discussion: Providing users with feedback on when 
#account accesses last occurred facilitates user recognition and 
#reporting of unauthorized account use.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check that pam_lastlog is used and not silent, or that the SSH 
#daemon is configured to display last login information.
#
# grep pam_lastlog /etc/pam.d/sshd
#If pam_lastlog is present, and does not have the "silent" option, 
#this is not a finding.
#
# grep -i PrintLastLog /etc/ssh/sshd_config
#If PrintLastLog is present in the configuration and not disabled, 
#this is not a finding.
#
#Otherwise, this is a finding.
#
#Fix Text: Implement pam_lastlog, or enable PrintLastLog in the 
#SSH daemon.
#
#To enable pam_lastlog, add a line such as "session required 
#pam_lastlog.so" to /etc/pam.d/sshd.
#
#To enable PrintLastLog in the SSH daemon, remove any lines 
#disabling this option from /etc/ssh/sshd_config.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000452
PRINTLASTLOG=`grep -c "#PrintLastLog yes" /etc/ssh/sshd_config`


#Start-Lockdown

if [ $PRINTLASTLOG -eq 1 ]
  then
    sed -i 's/#PrintLastLog yes/PrintLastLog yes/g' /etc/ssh/sshd_config
fi

#Second part of this check is addressed in GEN000454, so it will be configured in system-auth as these check semi conflict themselves.



