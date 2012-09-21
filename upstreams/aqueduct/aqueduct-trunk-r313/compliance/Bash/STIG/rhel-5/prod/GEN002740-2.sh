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
# Group ID (Vulid): V-29240
# Group Title: GEN002740-2
# Rule ID: SV-37656r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002740-2
# Rule Title: The audit system must be configured to audit file deletions.
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
# Check the system audit configuration to determine if file and directory 
# deletions are audited.

# cat /etc/audit/audit.rules | grep -e "-a exit,always" | grep -i "rmdir"

# If no results are returned, or the results do not contain "-S rmdir", 
# this is a finding.
#
# Fix Text: 
#
# Edit the audit.rules file and add the following line to enable auditing 
# of deletions:
# -a exit,always -S rmdir 

# Restart the auditd service.
# service auditd restart   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002740-2
UNAME=$( uname -m )
BIT64='x86_64'
AUDITFILE='/etc/audit/audit.rules'
AUDITCOUNT64=$( grep -c -e "-a exit,always -F arch=b64 -S rmdir" $AUDITFILE )
AUDITCOUNT32=$( grep -c -e "-a exit,always -F arch=b32 -S rmdir" $AUDITFILE )

#Start-Lockdown
if [ $UNAME == $BIT64 ]
  then
  #For 64 Bit systems
	if [ $AUDITCOUNT64 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002740-2#############" >> $AUDITFILE
	    echo "-a exit,always -F arch=b64 -S rmdir" >> $AUDITFILE
	    service auditd restart
	fi

	if [ $AUDITCOUNT32 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002740-2#############" >> $AUDITFILE
	    echo "-a exit,always -F arch=b32 -S rmdir" >> $AUDITFILE
	    service auditd restart
	fi

else

  #Non 64 Bit Systems
	if [ $AUDITCOUNT32 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002740-2#############" >> $AUDITFILE
	    echo "-a exit,always -F arch=b32 -S rmdir" >> $AUDITFILE
	    service auditd restart
	fi

fi

