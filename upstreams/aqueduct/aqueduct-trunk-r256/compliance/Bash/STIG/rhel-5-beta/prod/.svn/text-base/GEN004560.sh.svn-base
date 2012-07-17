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
#|    1.1   | Exit if Sendmail not  | Leam Hall          | 11-APR-2012|
#|          |  installed.           |                    |            |
#|__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4384
#Group Title: Sendmail greeting to mask version
#Rule ID: SV-4384r7_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN004560
#Rule Title: The SMTP service's SMTP greeting must not provide version information.
#
#Vulnerability Discussion: The version of the SMTP service can be used by attackers to plan an attack based on vulnerabilities present in the specific version.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#To check for the sendmail version being displayed in the greeting:
#
# telnet localhost 25
#
#If a version number is displayed, this is a finding.
#
#Fix Text: Ensure that sendmail or its equivalent has been configured to mask the version information. If necessary, change the O SmtpGreetingMessage line in the /etc/sendmail.cf file as noted below:
#O SmtpGreetingMessage=$j Sendmail $v/$Z; $b
#change it to:
#O SmtpGreetingMessage= Mail Server Ready ; $b
 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004560

if [ -f /etc/mail/sendmail.cf ]
then
	MAILCHECK=$(cat /etc/mail/sendmail.cf | egrep "^O" | egrep "SmtpGreetingMessage=$j" | egrep "$v/$Z" | wc -l )
else
	exit 0
fi

#Start-Lockdown

if [ $MAILCHECK -eq 1 ]
  then
  sed -i '/SmtpGreetingMessage/ c\
  O SmtpGreetingMessage= Mail Server Ready ; $b' /etc/mail/sendmail.cf
fi


    
