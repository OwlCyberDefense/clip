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
#Group ID (Vulid): V-1013
#Group Title: Disable Boot From Removable Media
#Rule ID: SV-1013r5_rule
#Severity: CAT I
#Rule Version (STIG-ID): GEN008600
#Rule Title: The system must be configured to only boot from the system boot device.
#
#Vulnerability Discussion: The ability to boot from removable media is the same as being able to boot into single user, or maintenance, mode without a password. This ability could allow a malicious user to boot the system and perform changes that could compromise or damage the system. It could also allow the system to be used for malicious purposes by a malicious anonymous user.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Determine if the system is configured to boot from devices other than the system startup media. If so, this is a finding.
#
#Fix Text: Configure the system to only boot from system startup media.
#
#Procedure:
#On systems with a BIOS or system controller use the BIOS interface at startup to remove all but the proper boot device from the boot device list.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008600

#Start-Lockdown
