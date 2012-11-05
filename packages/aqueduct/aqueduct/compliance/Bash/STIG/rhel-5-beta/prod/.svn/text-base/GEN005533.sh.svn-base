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
#Group ID (Vulid): V-22482
#Group Title: GEN005533
#Rule ID: SV-26776r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN005533
#Rule Title: The SSH daemon must limit connections to a single session.
#
#Vulnerability Discussion: The SSH protocol has the ability to provide multiple sessions over a single connection without reauthentication. A compromised client could use this feature to establish additional sessions to a system without consent or knowledge of the user.
#
#Alternate per-connection session limits may be documented if needed for a valid mission requirement. Greater limits are expected to be necessary in situations where TCP or X11 forwarding are used.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the SSH daemon configuration for the MaxSessions setting.
# grep -i MaxSessions /etc/ssh/sshd_config | grep -v '^#'
#If the setting is not present, or not set to "1", this is a finding.
#
#Fix Text: Edit the SSH daemon configuration and add or edit the "MaxSessions" setting value to "1".   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005533
#MAXSESSION=$( grep -i MaxSessions /etc/ssh/sshd_config | grep -v '^#' | wc -l )
#MAXSESSIONNUMBER=$( cat /etc/ssh/sshd_config | grep MaxSessions | awk '{print $2}' )
#Start-Lockdown

#This doesn't work in RHEL 5, should in RHEL 6


#if [ $MAXSESSION -eq 0 ]
#  then
#    echo "#Added for DISA GEN005533" >> /etc/ssh/sshd_config
#    echo "MaxSessions 1" >> /etc/ssh/sshd_config
#    service sshd restart
#else
#  if [ $MAXSESSIONNUMBER -ne 1 ]
#    then
#      sed -i '/MaxSessions/d' /etc/ssh/sshd_config
#      echo "MaxSessions 1" >> /etc/ssh/sshd_config
#      service sshd restart
#  fi
#fi
