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
#Group ID (Vulid): V-22442
#Group Title: GEN004510
#Rule ID: SV-26698r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004510
#Rule Title: The SMTP service log file must not have an extended ACL.
#
#Vulnerability Discussion: If the SMTP service log file has an extended ACL, unauthorized users may be allowed to access or to modify the log file.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Examine /etc/syslog.conf and determine the log file(s) receiving logs for mail.crit, mail.debug, mail.*, or *.crit.
#
#Procedure:
#Check the permissions on these log files.Identify any log files configured for "*.crit" and the "mail" service (excluding mail.none) and at any severity level.
# egrep "(\*.crit|mail\.[^n][^/]*)" /etc/syslog.conf|sed 's/^[^/]*//'|xargs ls -lL
#
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all <log file>    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004510
MAILLOG=$( egrep "(\*.crit|mail\.[^n][^/]*)" /etc/syslog.conf|sed 's/^[^/]*//' )
#Start-Lockdown

if [ -a $MAILLOG ]
  then
    ACLOUT=`getfacl --skip-base $MAILLOG 2>/dev/null`;
    if [ "$ACLOUT" != "" ]
      then
      setfacl --remove-all $MAILLOG
    fi
fi
