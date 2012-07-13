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
#Group ID (Vulid): V-22382
#Group Title: GEN002753
#Rule ID: SV-26522r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN002753
#Rule Title: The audit system must be configured to audit account termination.
#
#Vulnerability Discussion: If the system is not configured to audit 
#certain activities and write them to an audit log, it is more 
#difficult to detect and track system compromises and damages incurred during a system compromise.
#
#Responsibility: System Administrator
#IAControls: ECAT-1
#
#Check Content: 
#Determine if execution of the userdel and groupdel executable are audited.
# auditctl -l | egrep '(userdel|groupdel)'
#If either userdel or groupdel are not listed with a permissions filter of at least 'x', this is a finding.
#
#Fix Text: Configure execute auditing of the userdel and groupdel executables. Add the following to the audit.rules file:
#-w /usr/sbin/userdel -p x -k userdel
#-w /usr/sbin/groupdel -p x -k groupdel
#
#Restart the auditd service.  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002753
AUDITFILE='/etc/audit/audit.rules'
AUDITCOUNT1=$( grep -c -e "-w /usr/sbin/userdel -p x -k userdel" $AUDITFILE )
AUDITCOUNT2=$( grep -c -e "-w /usr/sbin/groupdel -p x -k groupdel" $AUDITFILE )

#Start-Lockdown
			#echo "Type is 64 Bit"
if [ $AUDITCOUNT1 -eq 0 ]
  then
  echo " " >> $AUDITFILE
  echo "#############GEN002753#############" >> $AUDITFILE
  echo "-w /usr/sbin/userdel -p x -k userdel" >> $AUDITFILE
  service auditd restart
fi

if [ $AUDITCOUNT2 -eq 0 ]
  then
  echo " " >> $AUDITFILE
  echo "#############GEN002753#############" >> $AUDITFILE
  echo "-w /usr/sbin/groupdel -p x -k groupdel" >> $AUDITFILE
  service auditd restart
fi

