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
#	Updated by Vincent C. Passaro
	#Documentation Cleanup

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22376
#Group Title: GEN002750
#Rule ID: SV-26519r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN002750
#Rule Title: The audit system must be configured to audit account creation.
#
#Vulnerability Discussion: If the system is not configured to audit 
#certain activities and write them to an audit log, it is more difficult 
#to detect and track system compromises, and damages incurred during a system compromise.
#
#Responsibility: System Administrator
#IAControls: ECAT-1
#
#Check Content: 
#Determine if execution of the useradd and groupadd executable are audited.
# auditctl -l | egrep '(useradd|groupadd)'
#If either useradd or groupadd are not listed with a permissions filter of at least 'x', this is a finding.
#Determine if /etc/passwd, /etc/shadow, /etc/group, and /etc/gshadow are audited for appending.
# auditctl -l | egrep '(/etc/passwd|/etc/shadow|/etc/group|/etc/gshadow)'
#If any of these are not listed with a permissions filter of at least 'a', this is a finding.
#
#Fix Text: Configure execute auditing of the useradd and groupadd executables.
#Add the following to audit.rules:
#-w /usr/sbin/useradd -p x -k useradd
#-w /usr/sbin/groupadd -p x -k groupadd
#Configure append auditing of the passwd, shadow, group, and gshadow files. Add the following to audit.rules:
#-w /etc/passwd -p a -k passwd
#-w /etc/shadow -p a -k shadow
#-w /etc/group -p a -k group
#-w /etc/gshadow -p a -k gshadow
#Restart the auditd service.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002750
AUDITFILE='/etc/audit/audit.rules'
AUDITCOUNT1=$( grep -c -e "-w /usr/sbin/useradd -p x -k useradd" $AUDITFILE )
AUDITCOUNT2=$( grep -c -e "-w /usr/sbin/groupadd -p x -k groupadd" $AUDITFILE )
AUDITCOUNT3=$( grep -c -e "-w /etc/passwd -p a -k passwd" $AUDITFILE )
AUDITCOUNT4=$( grep -c -e "-w /etc/shadow -p a -k shadow" $AUDITFILE )
AUDITCOUNT5=$( grep -c -e "-w /etc/group -p a -k group" $AUDITFILE )
AUDITCOUNT6=$( grep -c -e "-w /etc/gshadow -p a -k gshadow" $AUDITFILE )

#Start-Lockdown

if [ $AUDITCOUNT1 -eq 0 ]
  then
  echo " " >> $AUDITFILE
  echo "#############GEN002750#############" >> $AUDITFILE
  echo "-w /usr/sbin/useradd -p x -k useradd" >> $AUDITFILE
  service auditd restart
fi

if [ $AUDITCOUNT2 -eq 0 ]
  then
  echo " " >> $AUDITFILE
  echo "#############GEN002750#############" >> $AUDITFILE
  echo "-w /usr/sbin/groupadd -p x -k groupadd" >> $AUDITFILE
  service auditd restart
fi

if [ $AUDITCOUNT3 -eq 0 ]
  then
  echo " " >> $AUDITFILE
  echo "#############GEN002750#############" >> $AUDITFILE
  echo "-w /etc/passwd -p a -k passwd" >> $AUDITFILE
  service auditd restart
fi

if [ $AUDITCOUNT4 -eq 0 ]
  then
  echo " " >> $AUDITFILE
  echo "#############GEN002750#############" >> $AUDITFILE
  echo "-w /etc/shadow -p a -k shadow" >> $AUDITFILE
  service auditd restart
fi

if [ $AUDITCOUNT5 -eq 0 ]
  then
  echo " " >> $AUDITFILE
  echo "#############GEN002750#############" >> $AUDITFILE
  echo "-w /etc/group -p a -k group" >> $AUDITFILE
  service auditd restart
fi

if [ $AUDITCOUNT6 -eq 0 ]
  then
  echo " " >> $AUDITFILE
  echo "#############GEN002750#############" >> $AUDITFILE
  echo "-w /etc/gshadow -p a -k gshadow" >> $AUDITFILE
  service auditd restart
fi

