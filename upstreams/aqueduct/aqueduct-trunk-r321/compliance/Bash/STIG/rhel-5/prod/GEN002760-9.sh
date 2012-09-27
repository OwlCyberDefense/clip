#!/bin/bash

##########################################################################
#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  
#  Vincent C. Passaro (vincent.passaro@gmail.com)
#  Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
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
##########################################################################

###################### Fotis Networks LLC ###############################
# By Vincent C. Passaro                                                 #
# Fotis Networks LLC	                                                #
# Vincent[.]Passaro[@]fotisnetworks[.]com                               #
# www.fotisnetworks.com	                                                #
###################### Fotis Networks LLC ###############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Vincent C. Passaro | 1-Aug-2012 |
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-29248
# Group Title: GEN002760-9
# Rule ID: SV-37664r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002760-9
# Rule Title: The audit system must be configured to audit all 
# administrative, privileged, and security actions.
#
# Vulnerability Discussion: If the system is not configured to audit 
# certain activities and write them to an audit log, it is more difficult 
# to detect and track system compromises and damages incurred during a 
# system compromise.
#
# Responsibility: System Administrator
# IAControls: ECAR-1, ECAR-2, ECAR-3
#
# Check Content:
#
# Check the auditing configuration of the system.

# Procedure:
# cat /etc/audit/audit.rules | grep -e "-a exit,always" | grep -i 
# "sched_setparam"

# If the result does not contain "-S sched_setparam", this is a finding.
#
# Fix Text: 
#
# The "-F arch=<ARCH>"restriction is required on dual-architecture 
# systems (such as x86_64). On dual-architecture systems, two separate 
# rules must exist - one for each architecture supported. Use the generic 
# architectures "b32" and "b64" for specifying these rules.
# On single architecture systems, the "-F arch=<ARCH>"restriction may be 
# omitted, but if present must match either the architecture of the system 
# or its corresponding generic architecture. The architecture of the system 
# may be determined by running "uname -m". See the auditctl(8) manpage for 
# additional details.
# Any restrictions (such as with "-F") beyond those provided in the example 
# rules are not in strict compliance with this requirement, and are a 
# finding unless justified and documented appropriately.
# The use of audit keys consistent with the provided example is encouraged 
# to provide for uniform audit logs, however omitting the audit key or 
# using an alternate audit key is not a finding.
# Procedure:
# A Real Time Operating System (RTOS) provides specialized system 
# scheduling which causes an inordinate number of messages to be produced 
# when the sched_setparam and set_setscheduler are audited. This not only 
# may degrade the system speed to an unusable level but obscures any 
# forensic information which may otherwise have been useful.
# Unless the operating system is a Red Hat 5 based RTOS (including MRG and 
# AS5300) the following should also be present in /etc/audit/audit.rules

# -a exit,always -F arch=<ARCH> -S sched_setparam

# Restart the auditd service.
# service auditd restart  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002760-9
UNAME=$( uname -m )
BIT64='x86_64'
AUDITFILE='/etc/audit/audit.rules'

AUDITCOUNT642=$( grep -c -e "-a exit,always -F arch=b64 -S sched_setparam" $AUDITFILE )
AUDITCOUNT322=$( grep -c -e "-a exit,always -F arch=b32 -S sched_setparam" $AUDITFILE )	

# Start-Lockdown
if [ $UNAME == $BIT64 ]
  then
  	if [ $AUDITCOUNT642 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002760-9#############" >> $AUDITFILE
	    echo "-a exit,always -F arch=b64 -S sched_setparam" >> $AUDITFILE
	    service auditd restart
	fi
	if [ $AUDITCOUNT322 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002760-9#############" >> $AUDITFILE
	    echo "-a exit,always -F arch=b32 -S sched_setparam" >> $AUDITFILE
	    service auditd restart
	fi

else

	if [ $AUDITCOUNT322 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002760-9#############" >> $AUDITFILE
	    echo "-a exit,always -F arch=b32 -S sched_setparam" >> $AUDITFILE
	    service auditd restart
	fi
fi

