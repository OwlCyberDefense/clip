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
#                                                                    #
#Modified by David Wagenheim, dwagenheim@owlcti.com to address the   #
#the difference between the naming of the syslog config file between #
#RHEL 5 & RHEL 6.                                                    #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-12004
#Group Title: Authentication Data Logging
#Rule ID: SV-12505r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003660
#Rule Title: The system must log authentication informational data.
#
#Vulnerability Discussion: Monitoring and recording successful and 
#unsuccessful logins assists in tracking unauthorized access to the 
#system.
#
#Responsibility: System Administrator
#IAControls: ECAR-2, ECAR-3
#
#Check Content: 
#Check /etc/syslog.conf and verify the auth facility is logging both 
#the notice and info level messages by:
#
# grep "auth.notice" /etc/syslog.conf
# grep "auth.info" /etc/syslog.conf
#or
# egrep 'auth\..*' /etc/syslog.conf
#
#If auth.* is not found, and either auth.notice or auth.info is not 
#found, this is a finding.
#
#
#
#Fix Text: Edit /etc/syslog.conf and add local log destinations for 
#auth.* or both auth.notice and auth.info.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003660
RELEASE=$(/bin/grep -io 'release [1-9]\{1,2\}\.' /etc/redhat-release | /bin/sed -e 's/release //; s/\.//')

if [[ ${RELEASE} -ge 6 ]]
then
    SYSLOGFILE=/etc/rsyslog.conf
else
    SYSLOGFILE=/etc/syslog.conf
fi

SYSLOGAUTH=$( egrep -c 'auth\..*' ${SYSLOGFILE} )
#Start-Lockdown

if [ $SYSLOGAUTH -eq 0 ]
  then
    if [[ ${RELEASE} -ge 6 ]]
    then
         # Preserving sequencing of rules in /etc/rsyslog.conf file
         /bin/sed --in-place "s/\(\# \#\#\# begin forwarding rule \#\#\#.*$\)/\# Added to meet requirements of STIG ${PDI}\nauth\.\*                                    \/var\/log\/messages\n\n\1/" ${SYSLOGFILE}
    else
        echo " " >> ${SYSLOGFILE}
        echo "auth.*                                               /var/log/messages" >> ${SYSLOGFILE}
    fi
fi

