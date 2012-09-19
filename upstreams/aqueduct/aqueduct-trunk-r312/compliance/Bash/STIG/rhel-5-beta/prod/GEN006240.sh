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
#Group ID (Vulid): V-1023
#Group Title: INN Documentation
#Rule ID: SV-1023r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006240
#Rule Title: The system must not run an Internet Network News (INN) server.
#
#Vulnerability Discussion: Internet Network News (INN) servers access Usenet newsfeeds and store newsgroup articles. INN servers use the Network News Transfer Protocol (NNTP) to transfer information from the Usenet to the server and from the server to authorized remote hosts.
#
#If this function is necessary to support a valid mission requirement, its use must be authorized and approved in the system accreditation package.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
# ps -ef | egrep "innd|nntpd"
#
#If an Internet Network News server is running, this is a finding.
#
#
#Fix Text: Disable the INN server.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006240

#Start-Lockdown

if [ -a  '/etc/init.d/innd' ]
  then
    rpm -e inn
fi

