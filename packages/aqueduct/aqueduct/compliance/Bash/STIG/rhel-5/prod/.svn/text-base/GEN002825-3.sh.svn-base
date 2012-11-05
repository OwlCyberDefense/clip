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
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-jul-2011|
#|	   	    |   Creation		    |                    |            |
#|__________|_______________________|____________________|____________|

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-29284
#Group Title: GEN002825-3
#Rule ID: SV-37734r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002825-3
#Rule Title: The audit system must be configured to audit the loading and unloading of dynamic kernel modules - /sbin/insmod.
#
#
#Vulnerability Discussion: Actions concerning dynamic kernel modules must be recorded as they are substantial events. Dynamic kernel modules can increase the attack surface of a system. A malicious kernel module can be used to substantially alter the functioning of a system, often with the purpose of hiding a compromise from the SA.
#
#Responsibility: System Administrator
#IAControls: ECAR-1, ECAR-2, ECAR-3
#
#Check Content: 
#Determine if /sbin/insmod is audited.
#
# cat /etc/audit/audit.rules | grep "/sbin/insmod"
#
#If the result does not start with "-w" and contain "-p x", this is a finding.
#
#Fix Text: The "-F arch=<ARCH>" restriction is required on dual-architecture systems (such as x86_64). On dual-architecture systems, two separate rules must exist - one for each architecture supported. Use the generic architectures "b32" and "b64" for specifying these rules.
#On single architecture systems, the "-F arch=<ARCH>" restriction may be omitted, but if present must match either the architecture of the system or its corresponding generic architecture. The architecture of the system may be determined by running "uname -m". See the auditctl(8) manpage for additional details.
#Any restrictions (such as with "-F") beyond those provided in the example rules are not in strict compliance with this requirement, and are a finding unless justified and documented appropriately.
#The use of audit keys consistent with the provided example is encouraged to provide for uniform audit logs, however omitting the audit key or using an alternate audit key is not a finding.
#Procedure:
#
#Configure auditing of the /sbin/insmod, files.
#Add the following to the "etc/audit/audit.rules" or "etc/audit.rules" file:
#-w /sbin/insmod -p x
#
#Restart the auditd service.
# service auditd restart   CCI: CCI-000126
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002825-3
AUDITFILE='/etc/audit/audit.rules'
AUDIT3="-w /sbin/insmod -p x"
AUDITCOUNT3=$( grep -c -e "-w /sbin/insmod -p x" $AUDITFILE )

#Start-Lockdown
   
if [ $AUDITCOUNT3 -eq 0 ]
  then
    echo " " >> $AUDITFILE
    echo "#############GEN002825-3#############" >> $AUDITFILE
    echo $AUDIT3 >> $AUDITFILE
    service auditd restart
fi
