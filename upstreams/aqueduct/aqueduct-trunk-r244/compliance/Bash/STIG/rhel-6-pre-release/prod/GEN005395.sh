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
# on 05-Feb-2012 to include an ACL check before running setfacl.

# Modified by David Wagenheim, dwagenheim@owlcti.com to address the   #
# the difference between the naming of the syslog config file between #
# RHEL 5 & RHEL 6.
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22454
#Group Title: GEN005395
#Rule ID: SV-26741r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005395
#Rule Title: The /etc/syslog.conf file must not have an extended ACL.
#
#Vulnerability Discussion: Unauthorized users must not be allowed to access or modify the /etc/syslog.conf file.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the syslog configuration file.
# ls -lL /etc/syslog.conf
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/syslog.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005395

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
  ACLOUT=`getfacl --skip-base ${SYSLOGFILE} 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all ${SYSLOGFILE}
  fi
fi
