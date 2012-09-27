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
#
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 05-Feb-2012 to check for file existance before removing it.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-12006
#Group Title: Sendmail Help Command
#Rule ID: SV-12507r6_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004540
#Rule Title: The SMTP service HELP command must not be enabled.
#
#Vulnerability Discussion: The HELP command should be disabled to mask version information. The version of the SMTP service software could be used by attackers to target vulnerabilities present in specific software versions.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check if Help is disabled in sendmail.
#
#Procedure:
# telnet localhost 25
#> help
#
#If the help command returns any sendmail version information, this is a finding.
#
#Fix Text: To disable the SMTP HELP command, remove, rename or empty the /etc/mail/helpfile file.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004540

#Start-Lockdown

if [ -e /etc/mail/helpfile ]
then
  rm -f /etc/mail/helpfile
fi
