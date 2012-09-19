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
# Group ID (Vulid): V-818
# Group Title: GEN002800
# Rule ID: SV-37944r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002800
# Rule Title: The audit system must be configured to audit login, logout, 
# and session initiation.
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
# The message types that are always recorded to /var/log/audit/audit.log 
# include LOGIN,USER_LOGIN,USER_START,USER_END among others and do not need 
# to be added to audit_rules. 

# The log files /var/log/faillog and /var/log/lastlog must be protected 
# from tampering of the login records.

# Procedure:

#egrep "faillog|lastlog" /etc/audit/audit.rules|grep "-p (wa|aw)"

# If both /var/log/faillog and /var/log/lastlog entries do not exist, this 
# is a finding.


#
# Fix Text: 
#
# Ensure logins 

# Procedure:
# Modify /etc/audit/audit.rules to contain:

# -w /var/log/faillog -p wa
# -w /var/log/lastlog -p wa

  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002800
AUDITFILE='/etc/audit/audit.rules'
AUDITCOUNTNOARCH1=$( grep -c -e "-w /var/log/faillog -p wa" $AUDITFILE )
AUDITCOUNTNOARCH2=$( grep -c -e "-w /var/log/lastlog -p wa" $AUDITFILE )	
# Start-Lockdown

if [ $AUDITCOUNTNOARCH1 -eq 0 ]
  then
  echo " " >> $AUDITFILE
  echo "#############GEN002800#############" >> $AUDITFILE
  echo "-w /var/log/faillog -p wa" >> $AUDITFILE
  service auditd restart
fi

if [ $AUDITCOUNTNOARCH2 -eq 0 ]
  then
  echo " " >> $AUDITFILE
  echo "#############GEN002800#############" >> $AUDITFILE
  echo "-w /var/log/lastlog -p wa" >> $AUDITFILE
  service auditd restart
fi
