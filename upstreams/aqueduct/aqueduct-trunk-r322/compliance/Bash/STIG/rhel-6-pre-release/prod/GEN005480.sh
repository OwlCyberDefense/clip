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
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 05-Feb-2012 to remove the -r from the syslog deamon options.

# Updated by David Wagenheim(dwagenheim@owlcti.com) on 12-Jun-2012.  Updated
# to account for the different config file under RHEL 6 (rsyslog vs syslog in
# RHEL 5), and also the different parameters in the config file.  rsyslog can
# run in compatibility mode where it may be possible to specify the -r parameter
# so disabling the compatibility mode (setting it to -c 4) prevents that.  Also,
# there are parameters in /etc/rsyslog.conf that control accepting remote messages
# either by tcp or udp.  Commenting those out prevents reception of remote
# messages
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-12021
#Group Title: Syslog Accepts Remote Messages
#Rule ID: SV-28434r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005480
#Rule Title: The syslog daemon must not accept remote messages unless it is a syslog server documented using site-defined procedures.
#
#Vulnerability Discussion: Unintentionally running a syslog server that accepts remote messages puts the system at increased risk. Malicious syslog messages sent to the server could exploit vulnerabilities in the server software itself, could introduce misleading information in to the system's logs, or could fill the system's storage leading to a denial of service.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#ps -ef | grep syslogd
#If the '-r' option is present. This is a finding.
#
#Fix Text: Edit /etc/sysconfig/syslog removing the '-r' in SYSLOGD_OPTIONS. Restart the syslogd service.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005480
RELEASE=$(/bin/grep -io 'release [1-9]\{1,2\}\.' /etc/redhat-release | /bin/sed -e 's/release //; s/\.//')

if [[ ${RELEASE} -ge 6 ]]
then
    SYSLOGFILE=/etc/sysconfig/rsyslog
else
    SYSLOGFILE=/etc/sysconfig/syslog
fi

#Start-Lockdown
if [[ -f ${SYSLOGFILE} ]]
then
    if [[ ${RELEASE} -ge 6 ]]
    then
        # /etc/sysconfig/rsyslog should have "-c 4" as the only syslogd_option
        grep '^SYSLOGD_OPTIONS' ${SYSLOGFILE} | grep '\-c 4' > /dev/null
        if [[ $? -eq 0 ]]
        then
            sed -i 's/^\(SYSLOGD_OPTIONS="\)[^"]*\("\)/\1\-c 4\2/' ${SYSLOGFILE}
        fi
        # Comment out $ModLoad imudp.so, $ModLoad imtcp.so, $UDPServerRun 514 and $InputTCPServerRun 514  which provide
        # udp/tcp syslog reception
        sed -i "s/^\(\$ModLoad im[ut][dc]p.so\)/\# Commented out to comply with \${PDI}\n\# \1/g;s/^\([^#]*[UT][DC]PServerRun .*\)/\# \1/g" /etc/rsyslog.conf
    else
        grep 'SYSLOGD_OPTIONS' ${SYSLOGFILE} | grep '\-r' > /dev/null
        if [[ $? -eq 0 ]]
        then
            sed -i 's/-r//g' ${SYSLOGFILE}
        fi
    fi
fi
