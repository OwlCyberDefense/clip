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

-#!/bin/bash
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
#Group ID (Vulid): V-24357
#Group Title: GEN002870
#Rule ID: SV-30025r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN002870
#Rule Title: The system must be configured to send audit records to a remote audit server.
#
#Vulnerability Discussion: Audit records contain evidence that can be used in the investigation of compromised systems. To prevent this evidence from compromise, it must be sent to a separate system continuously. Methods for sending audit records include, but are not limited to, system audit tools used to send logs directly to another host or through the system's syslog service to another host.
#
#Responsibility: System Administrator
#IAControls: ECTB-1
#
#Check Content: 
#Verify if a remote audit server is configured and that messages are configured to be sent to it. If the system is not configured to provide this function, this is a finding.
#
#Procedure:
#Verify the log server is configured
# grep "\*.\*" etc/syslog.conf (for syslog)
#or:
# grep "\*.\*" etc/rsyslog.conf (for rsyslog)
#
#Verify that syslog is configured for
#If neither of these lines exist then it is a finding.
#
#
#
#Fix Text: Consult vendor documentation for the settings required to configure the system to send audit records to a remote system. Implement the configuration settings.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002870

#Start-Lockdown
