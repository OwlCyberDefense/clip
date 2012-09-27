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
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.1   | Fixed SED Statement   | Vincent C. Passaro | 18-FEB-2012|
#|          |  		            |                    |            |
#|__________|_______________________|____________________|____________|
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.2   | Exit if Sendmail not  | Leam Hall          | 07-APR-2012|
#|          |  installed.           |                    |            |
#|__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-835
#Group Title: Sendmail Logging
#Rule ID: SV-835r7_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN004440
#Rule Title: Sendmail logging must not be set to less than nine in the sendmail.cf file.
#
#Vulnerability Discussion: If Sendmail is not configured to log at level 9, system logs may not contain the information necessary for tracking unauthorized use of the sendmail service.
#
#Responsibility: System Administrator
#IAControls: ECAR-1, ECAR-2, ECAR-3
#
#Check Content: 
#Check if /etc/mail/sendmail.cf present.
#Check if sendmail logging is set to level nine:
#
#Procedure:
# grep "O L" /etc/mail/sendmail.cf
#
#OR
#
# grep LogLevel /etc/mail/sendmail.cf
#
#If logging is set to less than nine, this is a finding.
#
#Fix Text: Edit the sendmail.conf file, locate the "O L" or "LogLevel" entry and change it to 9.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004440

if [ -f /etc/mail/sendmail.cf ]
then
	MAILOGLEVEL=$( grep LogLevel /etc/mail/sendmail.cf | cut -d '=' -f 2)
else
	exit 0
fi


#Start-Lockdown

if [ $MAILOGLEVEL -lt 9 ]
  then
    sed -i "s/O LogLevel=[0-9]/O LogLevel=9/g" /etc/mail/sendmail.cf
fi


