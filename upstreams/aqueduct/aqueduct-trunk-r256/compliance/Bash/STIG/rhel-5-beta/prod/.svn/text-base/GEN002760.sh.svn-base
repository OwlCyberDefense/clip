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
#	Updated by Vincent C. Passaro:
#		Documentation update
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-816
#Group Title: Audit administrative, privileged, security actions
#Rule ID: SV-27302r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002760
#Rule Title: The audit system must be configured to audit all 
#administrative, privileged, and security actions.
#
#Vulnerability Discussion: If the system is not configured to 
#audit certain activities and write them to an audit log, it is 
#more difficult to detect and track system compromises and 
#damages incurred during a system compromise.
#
#
#Responsibility: System Administrator
#IAControls: ECAR-1, ECAR-2, ECAR-3
#
#Check Content: 
#Check the auditing configuration of the system.
#
#Procedure:
# cat /etc/audit.rules /etc/audit/audit.rules | grep -i "auditd.conf"
#If no results are returned, or the line does not start with "-w",this is a finding.
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -i "audit.rules"
#If no results are returned, or the line does not start with "-w",this is a finding.
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i "adjtime"
#If the result does not contain "-S adjtime" and "-k time-change",this is a finding.
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i "settimeofday"
#If the result does not contain "-S settimeofday" and "-k time-change",this is a finding.
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i "stime"
#If the result does not contain "-S stime" and "-k time-change",this is a finding.
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i "clock_settime"
#If the result does not contain "-S clock_settime" and "-k time-change",this is a finding.
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i "sethostname"
#If the result does not contain "-S sethostname" and "-k system-locale",this is a finding.
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i "setdomain"
#If the result does not contain "-S setdomain" and "-k system-locale",this is a finding.
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i "sched_setparam"
#If the result does not contain "-S sched_setparam", this is a finding.
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i "sched_setscheduler"
#If the result does not contain "-S sched_setscheduler", this is a finding.
#
#
#Fix Text: The "-F arch=<ARCH>"restriction is required on dual-architecture 
#systems (such as x86_64). On dual-architecture systems, two separate 
#rules must exist - one for each architecture supported. Use the g
#eneric architectures “b32” and “b64” for specifying these rules.

#On single architecture systems, the "-F arch=<ARCH>"restriction 
#may be omitted, but if present must match either the architecture 
#of the system or its corresponding generic architecture. The 
#architecture of the system may be determined by running “uname -m”. 
#See the auditctl(8) manpage for additional details.

#Any restrictions (such as with “-F”) beyond those provided in the 
#example rules are not in strict compliance with this requirement, 
#and are a finding unless justified and documented appropriately.
#The use of audit keys consistent with the provided example is 
#encouraged to provide for uniform audit logs, however omitting 
#the audit key or using an alternate audit key is not a finding.
#Procedure:
#Add the following lines to the audit.rules file to enable 
#auditing of administrative, privileged, and security actions:
#
#-w /etc/auditd.conf
#-w /etc/audit/auditd.conf
#-w /etc/audit.rules
#-w /etc/audit/audit.rules
#-a always,exit -F arch=<ARCH> -S adjtimex -S settimeofday -S stime -k time-change
#-a always,exit -F arch=<ARCH> -S sethostname -S setdomainname -k system-locale
#-a always,exit -F arch=<ARCH> -S clock_settime -k time-change
#
#A Real Time Operating System (RTOS) provides specialized system 
#scheduling which causes an inordinate number of messages to be 
#produced when the sched_setparam and set_setscheduler are audited. 
#This not only may degrade the system speed to an unusable level 
#but obscures any forensic information which may otherwise have been useful.
#Unless the operating system is a Red Hat 5 based RTOS (including 
#MRG and AS5300) the following should also be present in /etc/audit/audit.rules
#
#-a always,exit -F arch=<ARCH> -S sched_setparam -S sched_setscheduler
#
#
#Restart the auditd service.
# service auditd restart 
#######################DISA INFORMATION###############################

#AND AGAIN DISA STATEMENT IS CORRECT (THIS IS GETTING OLD)
#
#The stime flag is the same as settimeofday, which is only valid for 32bit platforms.  SO! We need to remove it, but were still going to grep for it so we don't throw any false positives.
#

#Global Variables#
PDI=GEN002760
UNAME=$( uname -m )
BIT64='x86_64'
AUDITFILE='/etc/audit/audit.rules'

AUDITCOUNT641=$( grep -c -e "-a always,exit -F arch=b64 -S adjtimex -S settimeofday -S stime -k time-change" $AUDITFILE )
AUDITCOUNT642=$( grep -c -e "-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale" $AUDITFILE )
AUDITCOUNT643=$( grep -c -e "-a always,exit -F arch=b64 -S clock_settime -k time-change" $AUDITFILE )
AUDITCOUNT644=$( grep -c -e "-a always,exit -F arch=b64 -S sched_setparam -S sched_setscheduler" $AUDITFILE )

AUDITCOUNT321=$( grep -c -e "-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change" $AUDITFILE )
AUDITCOUNT322=$( grep -c -e "-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale" $AUDITFILE )
AUDITCOUNT323=$( grep -c -e "-a always,exit -F arch=b32 -S clock_settime -k time-change" $AUDITFILE )
AUDITCOUNT324=$( grep -c -e "-a always,exit -F arch=b32 -S sched_setparam -S sched_setscheduler" $AUDITFILE )

AUDITCOUNTNOARCH1=$( grep -c -e "-w /etc/auditd.conf" $AUDITFILE )
AUDITCOUNTNOARCH2=$( grep -c -e "-w /etc/audit/auditd.conf" $AUDITFILE )
AUDITCOUNTNOARCH3=$( grep -c -e "-w /etc/audit.rules" $AUDITFILE )
AUDITCOUNTNOARCH4=$( grep -c -e "-w /etc/audit/audit.rules" $AUDITFILE )


#Start-Lockdown

#
#
#THIS BEGINS THE SECTION THAT IS ISN'T ARCH SPECIFIC
#
#

if [ $AUDITCOUNTNOARCH1 -eq 0 ]
  then
    echo " " >> $AUDITFILE
    echo "#############GEN002760#############" >> $AUDITFILE
    echo "-w /etc/auditd.conf" >> $AUDITFILE
    service auditd restart
fi

if [ $AUDITCOUNTNOARCH2 -eq 0 ]
  then
    echo " " >> $AUDITFILE
    echo "#############GEN002760#############" >> $AUDITFILE
    echo "-w /etc/audit/auditd.conf" >> $AUDITFILE
    service auditd restart
fi

if [ $AUDITCOUNTNOARCH3 -eq 0 ]
  then
  echo " " >> $AUDITFILE
  echo "#############GEN002760#############" >> $AUDITFILE
  echo "-w /etc/audit.rules" >> $AUDITFILE
  service auditd restart
fi

if [ $AUDITCOUNTNOARCH4 -eq 0 ]
  then
  echo " " >> $AUDITFILE
  echo "#############GEN002760#############" >> $AUDITFILE
  echo "-w /etc/audit/audit.rules" >> $AUDITFILE
  service auditd restart
fi

#END NON-ARCH SPECIFIC

#
#
#THIS BEGINS THE SECTION THAT IS ARCH SPECIFIC
#
#

#THIS SECTION IS FOR THE 64BIT

if [ $UNAME == $BIT64 ]
  then
	if [ $AUDITCOUNT641 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002760#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change" >> $AUDITFILE
	    service auditd restart
	fi

	if [ $AUDITCOUNT642 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002760#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale" >> $AUDITFILE
	    service auditd restart
	fi

	if [ $AUDITCOUNT643 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002760#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b64 -S clock_settime -k time-change" >> $AUDITFILE
	    service auditd restart
	fi

	if [ $AUDITCOUNT644 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002760#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b64 -S sched_setparam -S sched_setscheduler" >> $AUDITFILE
	    service auditd restart
	fi

#THIS SECTION IS FOR THE 64BIT WITH 32BIT FLAG SET FOR AUDITING

	if [ $AUDITCOUNT321 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002760#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change" >> $AUDITFILE
	    service auditd restart
	fi

	if [ $AUDITCOUNT322 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002760#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale" >> $AUDITFILE
	    service auditd restart
	fi

	if [ $AUDITCOUNT323 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002760#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S clock_settime -k time-change" >> $AUDITFILE
	    service auditd restart
	fi

	if [ $AUDITCOUNT324 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002760#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S sched_setparam -S sched_setscheduler" >> $AUDITFILE
	    service auditd restart
	fi

else

#THIS IS THE SECTION FOR 32BIT ONLY!

	if [ $AUDITCOUNT321 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002760#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change" >> $AUDITFILE
	    service auditd restart
	fi

	if [ $AUDITCOUNT322 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002760#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale" >> $AUDITFILE
	    service auditd restart
	fi

	if [ $AUDITCOUNT323 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002760#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S clock_settime -k time-change" >> $AUDITFILE
	    service auditd restart
	fi

	if [ $AUDITCOUNT324 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002760#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S sched_setparam -S sched_setscheduler" >> $AUDITFILE
	    service auditd restart
	fi
fi
