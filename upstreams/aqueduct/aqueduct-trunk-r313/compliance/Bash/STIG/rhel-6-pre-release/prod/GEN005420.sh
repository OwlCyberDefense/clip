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
# on 05-Feb-2012 to check group ownership before running chgrp.

# Modified by David Wagenheim, dwagenheim@owlcti.com to address the   #
# the difference between the naming of the syslog config file between #
# RHEL 5 & RHEL 6.
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4394
#Group Title: /etc/syslog.conf group ownership
#Rule ID: SV-4394r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005420
#Rule Title: The /etc/syslog.conf file must be group-owned by root, bin, sys, or system.
#
#Vulnerability Discussion: If the group owner of /etc/syslog.conf is not root, bin, or sys, unauthorized users could be permitted to view, edit, or delete important system messages that are handled by the syslog facility.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check /etc/syslog.conf group ownership.
#
#Procedure:
# ls -lL /etc/syslog.conf
#
#If /etc/syslog.conf is not group owned by root, sys, bin, or system, this is a finding.
#
#Fix Text: Change the group-owner of the /etc/syslog.conf file to root, bin, sys, or system.
#
#Procedure:
# chgrp root /etc/syslog.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005420

RELEASE=$(/bin/grep -io 'release [1-9]\{1,2\}\.' /etc/redhat-release | /bin/sed -e 's/release //; s/\.//')

if [[ ${RELEASE} -ge 6 ]]
then
    SYSLOGFILE=/etc/rsyslog.conf
else
    SYSLOGFILE=/etc/syslog.conf
fi


#Start-Lockdown

if [ -a "${SYSLOGFILE}" ]
then
  CURGROUP=`stat -c %G ${SYSLOGFILE}`;
  if [  "$CURGROUP" != "root" -a "$CURGROUP" != "bin" -a "$CURGROUP" != "sys" -a "$CURGROUP" != "system" ]
  then
      chgrp root ${SYSLOGFILE}
  fi
fi
