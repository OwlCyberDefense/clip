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
#Group ID (Vulid): V-4398
#Group Title: Dedicated Hardware for Routing
#Rule ID: SV-4398r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005580
#Rule Title: A system used for routing must not run other network services or applications.
#
#Vulnerability Discussion: Installing extraneous software on a system that has been designated as a dedicated router poses a security threat to the system and the network. Should an attacker gain access to the router through the unauthorized software, the entire network is susceptible to malicious activity.
#
#Responsibility: System Administrator
#IAControls: DCSP-1
#
#Check Content: 
#Ask the SA if the system is a designated router. If it is not, this is not applicable.
#
#Check the system for non-routing network services.
#
#Procedure:
# netstat -a | grep -i listen
# ps -ef
#
#If non-routing services, including Web servers, file servers, DNS servers, or applications servers, but excluding management services such as SSH and SNMP, are running on the system, this is a finding.
#
#Fix Text: Ensure that only authorized software is loaded on a designated router. Authorized software will be limited to the most current version of routing protocols and SSH for system administration purposes.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005580

#Start-Lockdown

#Manual Check
