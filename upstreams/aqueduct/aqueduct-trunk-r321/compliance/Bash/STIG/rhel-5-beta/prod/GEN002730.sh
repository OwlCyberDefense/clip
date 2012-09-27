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
#	Updated by Vincent C. Passaro Apr 11th 2012:
	#Documentation cleanup

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22375
#Group Title: GEN002730
#Rule ID: SV-26518r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002730
#Rule Title: The audit system must alert the SA when the audit storage 
#volume approaches its capacity.
#
#Vulnerability Discussion: An accurate and current audit trail is 
#essential for maintaining a record of system activity. If the system 
#fails, the SA must be notified and must take prompt action to correct 
#the problem.
#
#Minimally, the system must log this event and the SA will receive 
#this notification during the daily system log review. If feasible, 
#active alerting (such as e-mail or paging) should be employed 
#consistent with the site’s established operations management 
#systems and procedures.
#
#Responsibility: System Administrator
#IAControls: ECAT-1
#
#Check Content: 
#Check /etc/auditd.conf for the space_left_action and 
#action_mail_account parameters. If the space_left_action 
#parameter is missing or set to "ignore", this is a finding. 
#If the space_left_action is set to "email" and the action_mail_account 
#parameter is not set to the e-mail address of the system 
#administrator, this is a finding.
#
#Fix Text: Edit /etc/auditd.conf and set the space_left_action 
#parameter to a valid setting other than "ignore". If the 
#space_left_action parameter is set to "email" set the 
#action_email_account parameter to an e-mail address for 
#the system administrator.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002730

#The default is syslog, which is ok per the guidance, 
#so were only going to check and make sure that its not ignore

#Start-Lockdown

sed -i 's/space_left_action = IGNORE/space_left_action = SUSPEND/g' /etc/audit/auditd.conf


