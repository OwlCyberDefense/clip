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
#By Tummy a.k.a Vincent C. Passaro		                   		     #
#Vincent[.]Passaro[@]gmail[.]com				     				 #
#www.vincentpassaro.com						     					 #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	   		|   Creation		    |                    |            |
#|__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################
# Group ID (Vulid): V-812
# Group Title: GEN002680
# Rule ID: SV-38645r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002680
# Rule Title: System audit logs must be owned by root
#
# Vulnerability Discussion: Failure to give ownership of system audit log files to root provides the designated owner and unauthorized users with the potential to access sensitive information.
#
# Responsibility: Administrator
# IAControls: ECTP-1
#
# Check Content: System audit logs must be owned by root
#
# Fix Text: Change the ownership of the audit log file(s). Procedure: # chown root <audit log file
# 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002680
LOGFILES=$( grep "^log_file" /etc/audit/auditd.conf|sed s/^[^\/]*//|xargs stat -c %U:%n | cut -d ":" -f 2 )
BADELOGFILES=$(for line in $LOGFILES; do find $line ! -user root; done )

#Start-Lockdown

for file in $BADELOGFILES
  do
    chown root $file
done

