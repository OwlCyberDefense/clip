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
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-984
#Group Title: At Utility Accessibility
#Rule ID: SV-27379r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003280
#Rule Title: Access to the "at" utility must be controlled via the 
#at.allow and/or at.deny file(s).
#
#Vulnerability Discussion: The "at" facility selectively allows users 
#to execute jobs at deferred times. It is usually used for one-time 
#jobs. The at.allow file selectively allows access to the "at" facility. 
#If there is no at.allow file, there is no ready documentation of who 
#is allowed to submit "at" jobs.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check for the existence of at.allow and at.deny files.
# ls -lL /etc/at.allow
# ls -lL /etc/at.deny
#If neither file exists, this is a finding.
#
#Fix Text: Create at.allow and/or at.deny files containing 
#appropriate lists of users to be allowed or denied access to the at daemon.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003280

#Start-Lockdown

if [ ! -f /etc/at.allow ]
  then
    touch /etc/at.allow
    chown root:root /etc/at.allow
    chmod 600 /etc/at.allow
fi

if [ ! -f /etc/at.deny ]
  then
    touch /etc/at.deny
    chown root:root /etc/at.deny
    chmod 600 /etc/at.allow
fi

