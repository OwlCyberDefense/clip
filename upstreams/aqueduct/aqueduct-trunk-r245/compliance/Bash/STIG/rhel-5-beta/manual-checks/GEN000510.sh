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
#Group ID (Vulid): V-22301
#Group Title: GEN000510
#Rule ID: SV-25948r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN000510
#Rule Title: The system must display a publicly-viewable pattern during a graphical desktop environment session lock.
#
#Vulnerability Discussion: To protect the on-screen content of a session, it must be replaced with a publicly-viewable pattern upon session lock (such as a blank screen). This requirement applies to graphical desktop environments provided by the system to locally attached displays and input devices as well as to graphical desktop environments provided to remote systems using remote access protocols.
#
#Responsibility: System Administrator
#IAControls: PESL-1
#
#Check Content: 
#Determine if a publicly-viewable pattern is displayed during a session lock. If the session lock pattern is not publicly-viewable this is a finding.

#Fix Text: Configure the system to display a publicly-viewable pattern during a session lock.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000510

#Start-Lockdown

