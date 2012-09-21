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
#Group ID (Vulid): V-4366
#Group Title: At programs umask
#Rule ID: SV-4366r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003440
#Rule Title: "At" jobs must not set the umask to a value less restrictive than 077.
#
#Vulnerability Discussion: The umask controls the default access mode assigned to newly created files. A umask of 077 limits new files to mode 700 or less permissive. Although umask is often represented as a 4-digit number, the first digit representing special access modes is typically ignored or required to be 0.
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Determine what "at" jobs exist on the system.
#Procedure:
# ls /var/spool/cron/atjobs /var/spool/atjobs
#
#If there are no "at" jobs present, this is not applicable.
#
#Determine if any of the "at" jobs atjobs or any scripts referenced execute the "umask" command. Check for any umask setting more permissive than 077.
#
# grep umask <at job or referenced script>
#
#If any "at" job or referenced script sets umask to a value more permissive than 077, this is a finding.
#
#Fix Text: Edit "at" jobs or referenced scripts to remove "umask" commands that set umask to a value less restrictive than 077.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003440

#Start-Lockdown
