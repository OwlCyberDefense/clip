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
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.1   | Exit if Sendmail not  | Leam Hall          | 11-APR-2012|
#|          |  installed.           |                    |            |
#|__________|_______________________|____________________|____________|
#|    1.2   | Exit if either        | David Wagenheim    | 07-JUN-2012|
#|          | Sendmail or Postfix   |                    |            |
#|          | are not installed     |                    |            |
#|__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-837
#Group Title: Critical Sendmail Log File Ownership
#Rule ID: SV-837r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004480
#Rule Title: The SMTP service log file must be owned by root.
#
#Vulnerability Discussion: If the SMTP service log file is not owned by root, then unauthorized personnel may modify or delete the file to hide a system compromise.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Locate any mail log files by checking the syslog configuration file.
#
#Procedure:
#Identify any log files configured for the "mail" service (excluding mail.none) at any severity level and check the ownership
# egrep "mail\.[^n][^/]*" /etc/syslog.conf|sed 's/^[^/]*//'|xargs ls -lL
#
#If any mail log file is not owned by root, this is a finding.
#
#Fix Text: Change the ownership of the sendmail log file.
#
#Procedure:
# chown root <sendmail log file>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004480

MAILSERVER_INSTALLED=$(/bin/rpm -qa | /bin/egrep -ic '(^sendmail|^postfix)')

if [[ ${MAILSERVER_INSTALLED} -gt 0 ]]
then

    RELEASE=$(/bin/grep -io 'release [1-9]\{1,2\}\.' /etc/redhat-release | /bin/sed -e 's/release //; s/\.//')
    
    if [[ ${RELEASE} -ge 6 ]]
    then
        SYSLOGFILE=/etc/rsyslog.conf
    else
        SYSLOGFILE=/etc/syslog.conf
    fi
    
    MAILLOG=$(egrep "mail\.[^n][^/]*" ${SYSLOGFILE}|sed 's/^[^/]*//')
    
    #Start-Lockdown
    for LOGFILE in $(/bin/echo ${MAILLOG})
    do
        if [[ -f "${LOGFILE}" ]]
        then
            MAILOWNER=$(stat -L -c %U  ${LOGFILE})
            #Check if root owns the file
            if [ $MAILOWNER != root ]
            then
                chown root ${LOGFILE}
            fi
        fi
    done

fi
