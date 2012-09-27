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
#Group ID (Vulid): V-818
#Group Title: Audit login, logout, and session initiation
#Rule ID: SV-27307r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002800
#Rule Title: The audit system must be configured to audit login, 
#logout, and session initiation.
#
#Vulnerability Discussion: If the system is not configured to audit 
#certain activities and write them to an audit log, it is more difficult 
#to detect and track system compromises and damages incurred during a 
#system compromise.
#
#
#Responsibility: System Administrator
#IAControls: ECAR-1, ECAR-2, ECAR-3
#
#Check Content: 
#For RHEL-5 in a configuration that has no audit.rules defined the 
#default record types that are recorded to /var/log/audit/audit.log 
#include LOGIN,USER_LOGIN,USER-START,USER_END among others. This is 
#never a finding
#######################DISA INFORMATION###############################

#THEN WHY IN THE HELL DID YOU PUT THIS IN HERE DISA?

#Ugh!


#Global Variables#
PDI=GEN002800

#Start-Lockdown

