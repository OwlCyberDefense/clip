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
#Group ID (Vulid): V-22374
#Group Title: GEN002719
#Rule ID: SV-26517r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN002719
#Rule Title: The audit system must alert the SA in the event of an audit 
#processing failure.
#
#Vulnerability Discussion: An accurate and current audit trail is essential 
#for maintaining a record of system activity. If the system fails, the SA 
#must be notified and must take prompt action to correct the problem.
#
#Minimally, the system must log this event and the SA will receive this 
#notification during the daily system log review. If feasible, active 
#alerting (such as e-mail or paging) should be employed consistent with 
#the site’s established operations management systems and procedures.
#
#Responsibility: System Administrator
#IAControls: ECAT-1
#
#Check Content: 
#Check /etc/auditd.conf has the disk_full_action and disk_error_action 
#parameters. If these parameters are missing or set to "ignore" this is a 
#finding.
#
#Fix Text: Edit /etc/auditd.conf and set the disk_full_action and 
#disk_error_action parameters to a valid setting other than "ignore", 
#adding the parameters if necessary.  
#######################DISA INFORMATION###############################

#DISA is wrong.  The file is /etc/audit/auditd.conf  #Thanks DISA

#Global Variables#
PDI=GEN002719

AUDITLOGFILE='/etc/audit/auditd.conf'
#Start-Lockdown

sed -i 's/disk_full_action = IGNORE/disk_full_action = SUSPEND/g' $AUDITLOGFILE
sed -i 's/disk_error_action = IGNORE/disk_error_action = SUSPEND/g' $AUDITLOGFILE


