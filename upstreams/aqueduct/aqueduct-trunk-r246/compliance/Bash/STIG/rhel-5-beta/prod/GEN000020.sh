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
#By Tummy a.k.a Vincent C. Passaro				     #
#Vincent[.]Passaro[@]gmail[.]com	         		     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-756
#Group Title: The UNIX host is bootable in single user mode
#Rule ID: SV-27036r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000020
#Rule Title: The system must require authentication 
#upon booting into single-user and maintenance modes.
#
#Vulnerability Discussion: If the system does not require valid root 
#authentication before it boots into single-user or maintenance mode, 
#anyone who invokes single-user or maintenance mode is granted 
#privileged access to all files on the system.
#
#Responsibility: System Administrator
#IAControls: IAIA-1, IAIA-2
#
#Check Content: 
#Check if the system requires a password for entering single-user mode.
# grep ':S:' /etc/inittab
#If /sbin/sulogin is not listed, this is a finding.
#
#Fix Text: Edit /etc/inittab and set sulogin to run in single-user mode.
#Example line in /etc/inittab:
#~:S:wait:/sbin/sulogin 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000020

#Start-Lockdown

SULOGIN=`grep -c "~:S:wait:/sbin/sulogin" /etc/inittab`

#Start-Lockdown

if [ $SULOGIN -eq 0 ]
  then
    echo " " >> /etc/inittab
    echo "#Configured to meet GEN000020" >> /etc/inittab
    echo "~:S:wait:/sbin/sulogin" >> /etc/inittab 
fi


