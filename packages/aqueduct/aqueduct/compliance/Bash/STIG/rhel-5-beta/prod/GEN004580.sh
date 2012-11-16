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
# _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
# |          |   Creation	     |                    |            |
# |--------------------------------------------------------------------|
# |          |   modified syntax for |     Lee Kinser     | 8-Nov-2012 |
# |          |   confFORWARD_PATH    |                    |            |
# |__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4385
#Group Title: .forward files
#Rule ID: SV-4385r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004580
#Rule Title: The system must not use .forward files.
#
#Vulnerability Discussion: The .forward file allows users to automatically forward mail to another system. Use of .forward files could allow the unauthorized forwarding of mail and could potentially create mail loops which could degrade system performance.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#remove forwarding capability from sendmail.
#
#Procedure:
#grep "0 ForwardPath" /etc/mail/sendmail.cf
#
#If the entry contains a file path, this is a finding.
#
#Search for any .forward files on the system by:
#
# find / -name .forward
#
#This is considered a finding if any .forward files are found on the system.
#
#
#Fix Text: Disable forwarding for sendmail and remove .forward files from the system
#
#Procedure:
#Edit the /etc/mail/sendmail.mc file to change the ForwardPath entry to a null path by adding the line.
#define(`confFORWARD_PATH',`')
#rebuild the sendmail.cf file.
#
#Remove all .forward files on the system
# find / -name .forward -delete 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004580

#Start-Lockdown

find / -name .forward -delete 
