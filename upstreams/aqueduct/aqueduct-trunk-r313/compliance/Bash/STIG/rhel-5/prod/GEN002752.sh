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
# Group ID (Vulid): V-22378
# Group Title: GEN002752
# Rule ID: SV-26521r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN002752
# Rule Title: The audit system must be configured to audit account 
# disabling.
#
# Vulnerability Discussion: If the system is not configured to audit 
# certain activities and write them to an audit log, it is more difficult 
# to detect and track system compromises and damages incurred during a 
# system compromise.
#
# Responsibility: System Administrator
# IAControls: ECAT-1
#
# Check Content:
#
# Determine if execution of the passwd executable is audited.
# auditctl -l | grep /usr/bin/passwd
# If passwd is not listed with a permissions filter of at least 'x', this 
# is a finding.
#
# Fix Text: 
#
# Configure execute auditing of the passwd executable.  Add the following 
# to the audit.rules file:
# -w /usr/bin/passwd -p x -k passwd

# Restart the auditd service.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002752
AUDITFILE='/etc/audit/audit.rules'
AUDITCOUNT=$( grep -c -e "-w /usr/bin/passwd -p x -k passwd" $AUDITFILE )

#Start-Lockdown

if [ $AUDITCOUNT -eq 0 ]
  then
  echo " " >> $AUDITFILE
  echo "#############GEN002752#############" >> $AUDITFILE
  echo "-w /usr/bin/passwd -p x -k passwd" >> $AUDITFILE
  service auditd restart
fi


