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
#Group ID (Vulid): V-926
#Group Title: NIS+ Server at Security Level 2
#Rule ID: SV-926r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006460
#Rule Title: Any NIS+ server must be operating at security level 2.
#
#Vulnerability Discussion: If the NIS+ server is not operating in, at least, security level 2, there is no encryption and the system could be penetrated by intruders and/or malicious users.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#If the system is not using NIS+, this is not applicable.
#
#Check the system to determine if NIS+ security level two is implemented.
#
#Execute this command:
# niscat cred.org_dir
#
#If the second column does not contain ‘DES’, the system is not using NIS+ security level two, this is a finding.
#
#Fix Text: Configure the NIS+ server to use security level 2.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006460

#Start-Lockdown

# Couldn't find any reference to this in the documentation or scripts.  Until
# more or updated info can be provided I'm moving this to a manual check.
