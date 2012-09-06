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
# Group ID (Vulid): V-22383
# Group Title: GEN002825
# Rule ID: SV-38652r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002825
# Rule Title: The audit system must be configured to audit the loading 
# and unloading of dynamic kernel modules.
#
# Vulnerability Discussion: Actions concerning dynamic kernel modules 
# must be recorded as they are substantial events.  Dynamic kernel modules 
# can increase the attack surface of a system.  A malicious kernel module 
# can be used to substantially alter the functioning of a system, often 
# with the purpose of hiding a compromise from the SA.
#
# Responsibility: System Administrator
# IAControls: ECAR-1
#
# Check Content:
#
# Determine if the init_module syscall is audited.

# cat /etc/audit/audit.rules | grep -e "-a exit,always" | grep -i 
# "init_module"

# If the result does not contain "-S init_module", this is a finding.
#
# Fix Text: 
#
# The "-F arch=<ARCH>" restriction is required on dual-architecture 
# systems (such as x86_64). On dual-architecture systems, two separate 
# rules must exist - one for each architecture supported. Use the generic 
# architectures "b32" and "b64" for specifying these rules.
# On single architecture systems, the "-F arch=<ARCH>" restriction may be 
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
# Configure auditing of the init_module syscalls.
# Add the following to the "etc/audit/audit.rules" or "etc/audit.rules" 
# file:

# -a exit,always -S init_module

# Restart the auditd service.
# service auditd restart
  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002825

AUDITFILE='/etc/audit/audit.rules'
AUDITCOUNT1=$( grep -c -e "-a exit,always -S init_module " $AUDITFILE )

# Start-Lockdown
  	if [ $AUDITCOUNT1 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002825#############" >> $AUDITFILE
	    echo "-a exit,always -S init_module " >> $AUDITFILE
	    service auditd restart
	fi
