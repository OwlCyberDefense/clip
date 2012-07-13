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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com) on
#    24-jan-2012 to add arch for 64 and 32 bit.
#  - updated by Vincent C. Passaro (vincent.passaro@fotisnetworks.com) on 
#    April 11th 2012:  Added logic for 32 bit system, cleaned up documentation

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22383
#Group Title: GEN002825
#Rule ID: SV-26523r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002825
#Rule Title: The audit system must be configured to audit the loading and 
#unloading of dynamic kernel modules.
#
#Vulnerability Discussion: Actions concerning dynamic kernel modules must 
#be recorded as they are substantial events. Dynamic kernel modules can 
#increase the attack surface of a system. A malicious kernel module can 
#be used to substantially alter the functioning of a system, often 
#with the purpose of hiding a compromise from the SA.
#
#Responsibility: System Administrator
#IAControls: ECAR-1
#
#Check Content: 
#Determine if the init_module and delete_module syscalls are audited.
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i "init_module"
#If the result does not contain "-S init_module" and "-k modules",this is a finding.
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i "delete_module"
#If the result does not contain "-S delete_module" and "-k modules",this is a finding.
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep "/sbin/insmod"
#If the result does not start with "-w" and contain "-p x" and "-k modules",this is a finding.
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep "/sbin/modprobe"
#If the result does not start with "-w" and contain "-p x" and "-k modules",this is a finding.
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep "/sbin/rmmod"
#If the result does not start with "-w" and contain "-p x" and "-k modules",this is a finding.
#
#
#Fix Text: 
#The "-F arch=<ARCH>" restriction is required on dual-architecture 
#systems (such as x86_64). On dual-architecture systems, two separate 
#rules must exist - one for each architecture supported. Use the 
#generic architectures "b32" and "b64" for specifying these rules.
#On single architecture systems, the "-F arch=<ARCH>" restriction 
#may be omitted, but if present must match either the architecture 
#of the system or its corresponding generic architecture. The 
#architecture of the system may be determined by running "uname -m". 
#See the auditctl(8) manpage for additional details.
#Any restrictions (such as with "-F") beyond those provided in the 
#example rules are not in strict compliance with this requirement, 
#and are a finding unless justified and documented appropriately.
#The use of audit keys consistent with the provided example is 
#encouraged to provide for uniform audit logs, however omitting 
#the audit key or using an alternate audit key is not a finding.
#Procedure:
#Configure auditing of the init_module and delete_module syscalls.
#Add the following to the "etc/audit/audit.rules" or "etc/audit.rules" file:
#
#-a always,exit -S init_module -S delete_module -k modules
#
#Configure auditing of the /sbin/modprobe, /sbin/insmod, and /sbin/rmmod files.
#Add the following to the "etc/audit/audit.rules" or "etc/audit.rules" file:
#-w /sbin/insmod -p x -k modules
#-w /sbin/modprobe -p x -k modules
#-w /sbin/rmmod -p x -k modules
#
#Restart the auditd service.
# service auditd restart
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002825
UNAME=$( uname -m )
BIT64='x86_64'
AUDITFILE='/etc/audit/audit.rules'

AUDIT1="-a always,exit -F arch=b64 -S init_module -S delete_module -k modules"
AUDIT2="-a always,exit -F arch=b32 -S init_module -S delete_module -k modules"
AUDIT3="-w /sbin/insmod -p x -k modules"
AUDIT4="-w /sbin/modprobe -p x -k modules"
AUDIT5="-w /sbin/rmmod -p x -k modules"

AUDITCOUNT1=$( grep -c -e "-a always,exit -F arch=b64 -S init_module -S delete_module -k modules" $AUDITFILE )
AUDITCOUNT2=$( grep -c -e "-a always,exit -F arch=b32 -S init_module -S delete_module -k modules" $AUDITFILE )
AUDITCOUNT3=$( grep -c -e "-w /sbin/insmod -p x -k modules" $AUDITFILE )
AUDITCOUNT4=$( grep -c -e "-w /sbin/modprobe -p x -k modules" $AUDITFILE )
AUDITCOUNT5=$( grep -c -e "-w /sbin/rmmod -p x -k modules" $AUDITFILE )


#Start-Lockdown

if [ $UNAME == $BIT64 ]
  then
	if [ $AUDITCOUNT1 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002825#############" >> $AUDITFILE
	    echo $AUDIT1 >> $AUDITFILE
            service auditd restart
        fi

	if [ $AUDITCOUNT2 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002825#############" >> $AUDITFILE
	    echo $AUDIT2 >> $AUDITFILE
            service auditd restart
        fi
        
	if [ $AUDITCOUNT3 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002825#############" >> $AUDITFILE
	    echo $AUDIT3 >> $AUDITFILE
            service auditd restart
        fi

	if [ $AUDITCOUNT4 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002825#############" >> $AUDITFILE
	    echo $AUDIT4 >> $AUDITFILE
            service auditd restart
        fi

	if [ $AUDITCOUNT5 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002825#############" >> $AUDITFILE
	    echo $AUDIT5 >> $AUDITFILE
            service auditd restart
        fi
else

	if [ $AUDITCOUNT2 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002825#############" >> $AUDITFILE
	    echo $AUDIT2 >> $AUDITFILE
            service auditd restart
        fi
        
	if [ $AUDITCOUNT3 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002825#############" >> $AUDITFILE
	    echo $AUDIT3 >> $AUDITFILE
            service auditd restart
        fi

	if [ $AUDITCOUNT4 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002825#############" >> $AUDITFILE
	    echo $AUDIT4 >> $AUDITFILE
            service auditd restart
        fi

	if [ $AUDITCOUNT5 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002825#############" >> $AUDITFILE
	    echo $AUDIT5 >> $AUDITFILE
            service auditd restart
	fi
        
fi
