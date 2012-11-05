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

-#!/bin/bash
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
#Group ID (Vulid): V-4357
#Group Title: Audit Logs Rotation
#Rule ID: SV-4357r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002860
#Rule Title: Audit logs must be rotated daily.
#
#Vulnerability Discussion: Rotate audit logs daily to preserve audit file system space and to conform to the DISA requirement. If it is not rotated daily and moved to another location, then there is more of a chance for the compromise of audit data by malicious users.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check for any crontab entries that rotate audit logs.
#Procedure:
# crontab -l
#If such a cron job is found, this is not a finding.
#
#Otherwise, query the SA. If there is a process that automatically rotates audit logs, this is not a finding. If the SA manually rotates audit logs, this is still a finding, because if the SA is not there, it will not be accomplished. If the audit output is not archived daily, to tape or disk, this is a finding. This can be ascertained by looking at the audit log directory and, if more than one file is there, or if the file does not have today’s date, this is a finding.
#
#Fix Text: Configure a cron job or other automated process to rotate the audit logs on a daily basis.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002860

#Start-Lockdown

#This is done by default on a daily basis
