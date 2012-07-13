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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 24-jan-2012 to fix a few typos and cut/paste errors. Also removed 
# broken 32 bit rules x86_64 systems.

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-819
#Group Title: Audit discretionary access control permission
#Rule ID: SV-27313r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002820
#Rule Title: The audit system must be configured to audit all 
#discretionary access control permission modifications.
#
#Vulnerability Discussion: If the system is not configured to audit 
#certain activities and write them to an audit log, it is more difficult 
#to detect and track system compromises and damages incurred during a 
#system compromise.
#
#
#Responsibility: System Administrator
#IAControls: ECAR-1, ECAR-2, ECAR-3
#
#Check Content: 
#Check the system's audit configuration.
#
#Procedure:
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i " chmod "
#If "-S chmod" and "-k perm_mod" are not in the result, this is a finding
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i " fchmod "
#If "-S fchmod" and "-k perm_mod" are not in the result, this is a finding
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i " fchmodat"
#If "-S fchmodat" and "-k perm_mod" are not in the result, this is a finding
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i " chown "
#If "-S chown" and "-k perm_mod" are not in the result, this is a finding
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i " fchown "
#If "-S fchown" and "-k perm_mod" are not in the result, this is a finding
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i " fchownat "
#If "-S fchownat" and "-k perm_mod" are not in the result, this is a finding
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i " lchown "
#If "-S lchown" and "-k perm_mod" are not in the result, this is a finding
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i " setxattr "
#If "-S setxattr" and "-k perm_mod" are not in the result, this is a finding
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i " lsetxattr "
#If "-S lsetxattr" and "-k perm_mod" are not in the result, this is a finding
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i " fsetxattr "
#If "-S fsetxattr" and "-k perm_mod" are not in the result, this is a finding
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i " removexattr "
#If "-S removexattr" and "-k perm_mod" are not in the result, this is a finding
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i " lremovexattr "
#If "-S lremovexattr" and "-k perm_mod" are not in the result, this is a finding
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i " fremovexattr "
#If "-S fremovexattr" and "-k perm_mod" are not in the result, this is a finding
#
#Additionally, the following rules are required in systems supporting 
#the 32-bit syscall table (such as i686 and x86_64):
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i " chown32 "
#If "-S fchown32" and "-k perm_mod" are not in the result, this is a finding
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i " fchown32 "
#If "-S fchown32" and "-k perm_mod" are not in the result, this is a finding
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i " lchown32 "
#If "-S lchown32" and "-k perm_mod" are not in the result, this is a finding
#
#Restart the auditd service.
# service auditd restart

#Fix Text: The "-F arch=<ARCH>" restriction is required on dual-architecture 
#systems (such as x86_64). On dual-architecture systems, two separate rules 
#must exist - one for each architecture supported. Use the generic 
#architectures "b32" and "b64" for specifying these rules.
#On single architecture systems, the "-F arch=<ARCH>" restriction may 
#be omitted, but if present must match either the architecture of the 
#system or its corresponding generic architecture. The architecture of the 
#system may be determined by running "uname -m". See the auditctl(8) 
#manpage for additional details.
#Any restrictions (such as with "-F") beyond those provided in the 
#example rules are not in strict compliance with this requirement, and 
#are a finding unless justified and documented appropriately.
#The use of audit keys consistent with the provided example is 
#encouraged to provide for uniform audit logs, however omitting the 
#audit key or using an alternate audit key is not a finding.
#
#Procedure:
#Edit the audit.rules file and add the following lines to enable
#auditing of discretionary access control permissions modifications.
#-a always,exit -F arch=<ARCH> -S chmod -S fchmod -S fchmodat -S chown -S fchown -k perm_mod
#-a always,exit -F arch=<ARCH> -S fchownat -S lchown -S setxattr -S lsetxattr -S fsetxattr -k perm_mod
#-a always,exit -F arch=<ARCH> -S removexattr -S lremovexattr -S fremovexattr -k perm_mod
#
#Additionally, the following rules are required in systems 
#supporting the 32-bit syscall table (such as i686 and x86_64):
#-a always,exit -F arch=<ARCH> -S chown32 -S fchown32 -S lchown32 -k perm_mod Restart the auditd service.
# service auditd restart 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002820

UNAME=$( uname -m )
BIT64='x86_64'
AUDITFILE='/etc/audit/audit.rules'

AUDITCOUNT641=$( grep -c -e "-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -S chown -S fchown -k perm_mod" $AUDITFILE )
AUDITCOUNT642=$( grep -c -e "-a always,exit -F arch=b64 -S fchownat -S lchown -S setxattr -S lsetxattr -S fsetxattr -k perm_mod" $AUDITFILE )
AUDITCOUNT643=$( grep -c -e "-a always,exit -F arch=b64 -S removexattr -S lremovexattr -S fremovexattr -k perm_mod" $AUDITFILE )
#AUDITCOUNT644=$( grep -c -e "-a always,exit -F arch=b64 -S chown32 -S fchown32 -S lchown32 -k perm_mod" $AUDITFILE )

AUDITCOUNT321=$( grep -c -e "-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -S chown -S fchown -k perm_mod" $AUDITFILE )
AUDITCOUNT322=$( grep -c -e "-a always,exit -F arch=b32 -S fchownat -S lchown -S setxattr -S lsetxattr -S fsetxattr -k perm_mod" $AUDITFILE )
AUDITCOUNT323=$( grep -c -e "-a always,exit -F arch=b32 -S removexattr -S lremovexattr -S fremovexattr -k perm_mod" $AUDITFILE )
AUDITCOUNT324=$( grep -c -e "-a always,exit -F arch=b32 -S chown32 -S fchown32 -S lchown32 -k perm_mod" $AUDITFILE )


#Start-Lockdown

if [ $UNAME == $BIT64 ]
  then
	if [ $AUDITCOUNT641 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002820#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -S chown -S fchown -k perm_mod" >> $AUDITFILE
            service auditd restart
        fi

	if [ $AUDITCOUNT642 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002820#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b64 -S fchownat -S lchown -S setxattr -S lsetxattr -S fsetxattr -k perm_mod" >> $AUDITFILE
            service auditd restart
        fi
        
	if [ $AUDITCOUNT643 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002820#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b64 -S removexattr -S lremovexattr -S fremovexattr -k perm_mod" >> $AUDITFILE
            service auditd restart
        fi

	# This rule breaks on a x86_64 bit system.
	#if [ $AUDITCOUNT644 -eq 0 ]
	#  then
	#    echo " " >> $AUDITFILE
	#    echo "#############GEN002820#############" >> $AUDITFILE
	#    echo "-a always,exit -F arch=b64 -S chown32 -S fchown32 -S lchown32 -k perm_mod" >> $AUDITFILE
        #    service auditd restart
        #fi
        
#THIS ENDS THE SECTION FOR 64 BIT SPECIFIC FLAGS

	if [ $AUDITCOUNT321 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002820#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -S chown -S fchown -k perm_mod" >> $AUDITFILE
            service auditd restart
        fi
        
	if [ $AUDITCOUNT322 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002820#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S fchownat -S lchown -S setxattr -S lsetxattr -S fsetxattr -k perm_mod" >> $AUDITFILE
            service auditd restart
        fi

	if [ $AUDITCOUNT323 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002820#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S removexattr -S lremovexattr -S fremovexattr -k perm_mod" >> $AUDITFILE
            service auditd restart
        fi
        
	if [ $AUDITCOUNT324 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002820#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S chown32 -S fchown32 -S lchown32 -k perm_mod" >> $AUDITFILE
            service auditd restart
        fi

else

#BEGIN 32Bit ONLY SECTION

	if [ $AUDITCOUNT321 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002820#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -S chown -S fchown -k perm_mod" >> $AUDITFILE
            service auditd rester
        fi
        
	if [ $AUDITCOUNT322 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002820#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S fchownat -S lchown -S setxattr -S lsetxattr -S fsetxattr -k perm_mod" >> $AUDITFILE
            service auditd restart
        fi

	if [ $AUDITCOUNT323 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002820#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S removexattr -S lremovexattr -S fremovexattr -k perm_mod" >> $AUDITFILE
            service auditd restart
        fi
        
	if [ $AUDITCOUNT324 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002820#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S chown32 -S fchown32 -S lchown32 -k perm_mod" >> $AUDITFILE
            service auditd restart
        fi


fi
