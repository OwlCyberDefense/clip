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
#Group ID (Vulid): V-4690
#Group Title: Sendmail DEBUG Command
#Rule ID: SV-4690r6_rule
#Severity: CAT I
#Rule Version (STIG-ID): GEN004620
#Rule Title: The Sendmail server must have the debug feature disabled.
#
#Vulnerability Discussion: Debug mode is a feature present in older versions of Sendmail which, if not disabled, may allow an attacker to gain access to a system through the Sendmail service.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check for an enabled "debug" command provided by the SMTP service.
#
#Procedure:
# telnet localhost 25
#debug
#
#If the command does not return a 500 error code of "command unrecognized", this is a finding.
#
#Fix Text: Obtain and install a more recent version of Sendmail, which does not implement the DEBUG feature.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004620

#Start-Lockdown

#This is off by defauly in RHEL 5
