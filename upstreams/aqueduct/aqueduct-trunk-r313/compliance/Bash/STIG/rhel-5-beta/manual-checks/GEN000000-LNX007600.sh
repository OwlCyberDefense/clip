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
#By Tummy a.k.a Vincent C. Passaro											   	 		     #
#Fotis Networks LLC						     																	 #
#Vincent[.]Passaro[@]fotisnetworks[.]com												     #
#www.fotisnetworks.com						     															 #
######################Fotis Networks LLC##############################

#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	  		  |   Creation	  		    |                    |            |
#|__________|_______________________|____________________|____________|
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22536
#Group Title: GEN000000-LNX007600
#Rule ID: SV-26907r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000000-LNX007600
#Rule Title: The PF_LLC protocol handler must be prevented from 
#dynamic loading.
#
#Vulnerability Discussion: The Packet Family - Logical Link Control 
#(PF_LLC) protocol handler provides a sockets interface for applications 
#to communicate over the LLC sublayer. This interface is not commonly 
#used and may increase the attack surface of the system.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#The PF_LLC protocol handler is not part of the RHEL5 distribution. 
#This is not a finding.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000000-LNX007600

#Start-Lockdown

