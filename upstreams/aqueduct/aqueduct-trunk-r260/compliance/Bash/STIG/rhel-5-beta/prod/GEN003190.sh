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
# on 31-jan-2012 to include an ACL check before running setfacl.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22388
#Group Title: GEN003190
#Rule ID: SV-26540r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003190
#Rule Title: The cron log files must not have extended ACLs.
#
#Vulnerability Discussion: Cron logs contain reports of scheduled system 
#activities and must be protected from unauthorized access or manipulation.
#
#Responsibility: System Administrator
#IAControls: ECLP-1, ECTP-1
#
#Check Content: 
#Check the permissions of the file.
#
#Procedure:
#Check the configured cron log file found in the cron entry in /etc/syslog 
#(normally /var/log/cron).
# grep cron /etc/syslog.conf
# ls -lL /var/log/cron
#
#If the permissions include a '+', the file has an extended ACL, 
#this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /var/log/cron   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003190

#Start-Lockdown
ACLOUT=`getfacl --skip-base /var/log/cron 2>/dev/null`;
if [ "$ACLOUT" != "" ]
then
  setfacl --remove-all /var/log/cron
fi
