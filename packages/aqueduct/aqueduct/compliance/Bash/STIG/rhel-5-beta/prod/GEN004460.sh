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
#
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.1   | Exit if Sendmail not  | Leam Hall          | 11-APR-2012|
#|          |  installed.           |                    |            |
#|__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-836
#Group Title: Critical Level Sendmail Messages Logging
#Rule ID: SV-836r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004460
#Rule Title: The system syslog service must log informational and more severe SMTP service messages.
#
#Vulnerability Discussion: If informational and more severe SMTP service messages are not logged, malicious activity on the system may go unnoticed.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the syslog configuration file for mail.crit logging configuration.
#
#Procedure:
# grep "mail\." /etc/syslog.conf
#
#If syslog is not configured to log critical sendmail messages ("mail.crit" or "mail.*"), this is a finding.
#
#Fix Text: Edit the syslog.conf file and add a configuration line specifying an appropriate destination for "mail.crit" syslogs.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004460

if [ -f /etc/mail/sendmail.cf ]
then
	MAILLING=$( grep "mail\.\*" /etc/syslog.conf | wc -l )
else
	exit 0
fi

#Start-Lockdown

#This is on by default in RHEL 5, but well check for it anyways

if [ $MAILLING -lt 1 ]
  then
    echo " " >> /etc/syslog.conf
    echo "#Added for GEN004460" >> /etc/syslog.conf
    echo "mail.*							-/var/log/maillog" >> /etc/syslog.conf
fi

    

