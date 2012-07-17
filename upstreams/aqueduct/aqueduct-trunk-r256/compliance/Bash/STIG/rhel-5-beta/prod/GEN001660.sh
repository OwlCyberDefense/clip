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
#Group ID (Vulid): V-4089
#Group Title: Run Control Scripts Ownership
#Rule ID: SV-27211r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001660
#Rule Title: All system start-up files must be owned by root.
#
#Vulnerability Discussion: System start-up files not owned by root 
#could lead to system compromise by allowing malicious users or 
#applications to modify them for unauthorized purposes. This could 
#lead to system and network compromise.
#
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check run control scripts' ownership.
# ls -lL /etc/rc* /etc/init.d
#
#Alternatively:
# find /etc -name "[SK][0-9]*"|xargs stat -L -c %U:%n
#
#If any run control script is not owned by root or bin, this is a 
#finding.
#
#Fix Text: Change the ownership of the run control script(s) that 
#have incorrect ownership.
# find /etc -name "[SK][0-9]*"|xargs stat -L -c %U:%n|egrep -v "^
#root:"|cut -d: -f2|xargs chown root  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001660
BADCONTROLFILES=$( find /etc/rc* /etc/init.d  ! -user root  ! -user bin )
#Start-Lockdown

for FILE in $BADCONTROLFILES
  do
    chown root $FILE
done
