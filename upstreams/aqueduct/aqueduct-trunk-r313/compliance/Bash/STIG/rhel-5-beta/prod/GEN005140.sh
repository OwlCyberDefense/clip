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
# on 05-Feb-2012 to check if the service is enabled before disabling it.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4695
#Group Title: TFTP Documentation
#Rule ID: SV-28424r1_rule
#Severity: CAT I
#Rule Version (STIG-ID): GEN005140
#Rule Title: Any active TFTP daemon must be authorized and approved in the system accreditation package.
#
#Vulnerability Discussion: TFTP is a file transfer protocol often used by embedded systems to obtain configuration data or software. The service is unencrypted and does not require authentication of requests. Data available using this service may be subject to unauthorized access or interception.
#
#Responsibility: System Administrator
#IAControls: DCSW-1
#
#Check Content: 
#Determine if the TFTP daemon is active.
# chkconfig -list | grep tftp
#
#Or
# chkconfig tftp
#
#If TFTP is found enabled, it is a finding if it is not documented using site-defined procedures.
#
#Fix Text: Disable the TFTP daemon.
# chkconfig tftp off
# service xinetd restart   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005140

#Start-Lockdown

chkconfig --list tftp 2>/dev/null | grep 'on' > /dev/null
if [ $? -eq 0 ]
then
  chkconfig tftp off
  service xinetd restart
fi
