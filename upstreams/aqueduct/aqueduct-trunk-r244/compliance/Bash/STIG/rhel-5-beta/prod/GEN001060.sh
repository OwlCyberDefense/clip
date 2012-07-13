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
#####################Fotis Networks LLC###############################
#By Tummy a.k.a Vincent C. Passaro				     #
#Fotis Networks LLC						     #
#Vincent[.]Passaro[@]fotisnetworks[.]com			     #
#www.fotisnetworks.com						     #
######################Fotis Networks LLC##############################

#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-11980
#Group Title: Log Root Access Attempts
#Rule ID: SV-27156r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001060
#Rule Title: The system must log successful and unsuccessful access 
#to the root account.
#
#Vulnerability Discussion: If successful and unsuccessful logins and 
#logouts are not monitored or recorded, access attempts cannot be 
#tracked. Without this logging, it may be impossible to track 
#unauthorized access to the system.
#
#Responsibility: System Administrator
#IAControls: ECAR-1, ECAR-2, ECAR-3
#
#Check Content: 
#Check the following log files to determine if access to the root 
#account is being logged. Try to "su -" and enter an incorrect password.
# more /var/log/messages
#or
# more /var/adm/sulog
#If root login accounts are not being logged, this is a finding.
#
#Fix Text: Troubleshoot the system logging configuration to provide 
#for logging of root account login attempts.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001060

#Start-Lockdown

#This is done automagicly by RHEL.  Output is contained in the /var/log/secure file.

