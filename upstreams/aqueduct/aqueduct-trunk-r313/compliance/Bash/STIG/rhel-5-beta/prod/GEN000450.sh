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
#Group ID (Vulid): V-22298
#Group Title: GEN000450
#Rule ID: SV-26308r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN000450
#Rule Title: The system must limit users to 10 simultaneous system 
#logins, or a site-defined number, in accordance with operational 
#requirements.
#
#Vulnerability Discussion: Limiting simultaneous user logins can 
#insulate the system from denial of service problems caused by 
#excessive logins. Automated login processes that are operating 
#improperly or maliciously may result in an exceptional number 
#of simultaneous login sessions.
#
#If the defined value of 10 logins does not meet operational 
#requirements, the site may define the permitted number of 
#simultaneous login sessions based on operational requirements.
#
#This limit is for the number of simultaneous login sessions 
#for EACH user account. This is NOT a limit on the total number 
#of simultaneous login sessions on the system.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check for a maxlogins line in the /etc/security/limits.conf 
#and /etc/security/limits.d/* files. If no such line exists, this is a finding.
#
#Fix Text: Add a "maxlogins" line such as "* hard maxlogins 
#10" to /etc/security/limits.conf or a file in /etc/security/limits.d. 
#The enforced maximum should be defined by site requirements and policy.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000450
HARDLOGINLIMIT=`grep -c "* hard maxlogins 10" /etc/security/limits.conf`
#Start-Lockdown

if [ $HARDLOGINLIMIT -eq 0 ]
  then
    echo "#Configured to meet GEN000450" >> /etc/security/limits.conf
    echo "* hard maxlogins 10" >> /etc/security/limits.conf
fi


