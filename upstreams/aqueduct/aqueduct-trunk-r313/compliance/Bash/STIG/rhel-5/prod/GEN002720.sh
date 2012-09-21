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
# Group ID (Vulid): V-814
# Group Title: GEN002720
# Rule ID: SV-38645r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002720
# Rule Title: The audit system must be configured to audit failed 
# attempts to access files and programs.
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
# Verify auditd is configured to audit failed file access attempts.

# There must be an audit rule for each of the access syscalls logging all 
# failed accesses (-F success=0) or there must both an "-F exit=-EPERM" and 
# "-F exit=-EACCES" for each access syscall.

# Procedure:
# cat /etc/audit/audit.rules | grep -e "-a exit,always" | grep -e "-S 
# creat" | grep -e "-F success=0"
# cat /etc/audit/audit.rules | grep -e "-a exit,always" | grep -e "-S 
# creat" | grep -e "-F exit=-EPERM"
# cat /etc/audit/audit.rules | grep -e "-a exit,always" | grep -e "-S 
# creat" | grep -e "-F exit=-EACCES"

# If an "-S creat" audit rule with "-F success" does not exist and no 
# separate rules containing "-F exit=-EPERM" and "-F exit=-EACCES" for 
# "creat" exist, then this is a finding.
#
# Fix Text: 
#
# Edit the audit.rules file and add the following line(s) to enable 
# auditing of failed attempts to access files and programs:

# either:
# -a exit,always -F arch=<ARCH> -S creat -F success=0

# or both:
# 
# -a exit,always -F arch=<ARCH> -S creat -F exit=-EACCES

# Restart the auditd service.
# service auditd restart  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002720
UNAME=$( uname -m )
BIT64='x86_64'
AUDITFILE='/etc/audit/audit.rules'

#AUDITRULE64='-a exit,always -F arch=b64 -S creat -F exit=-EACCES'
#AUDITRULE32='-a exit,always -F arch=b32 -S creat -F exit=-EACCES'
#AUDITRULE164='-a exit,always -F arch=b64 -S creat -F exit=-EPERM'
#AUDITRULE132='-a exit,always -F arch=b32 -S creat -F exit=-EPERM'
AUDITRULE264='-a exit,always -F arch=b64 -S creat -F success=0'
AUDITRULE232='-a exit,always -F arch=b32 -S creat -F success=0'

#AUDITCOUNT64=$( grep -c "a exit,always -F arch=b64 -S creat -F exit=-EACCES" $AUDITFILE )
#AUDITCOUNT32=$( grep -c "a exit,always -F arch=b32 -S creat -F exit=-EACCES" $AUDITFILE )
#AUDITRULE164=$( grep -c "a exit,always -F arch=b64 -S creat -F exit=-EPERM" $AUDITFILE )
#AUDITRULE132=$( grep -c "a exit,always -F arch=b32 -S creat -F exit=-EPERM" $AUDITFILE )
AUDITRULE264=$( grep -c "a exit,always -F arch=b64 -S creat -F success=0" $AUDITFILE )
AUDITRULE232=$( grep -c "a exit,always -F arch=b32 -S creat -F success=0" $AUDITFILE )

#Start-Lockdown

if [ $UNAME == $BIT64 ]
  then
    			
#	if [ $AUDITCOUNT64 -eq 0 ]
#	  then
#	    echo " " >> $AUDITFILE
#	    echo "#############GEN002720#############" >> $AUDITFILE
#	    echo "-a exit,always -F arch=b64 -S creat -F exit=-EACCES" >> $AUDITFILE
#	    service auditd restart
#	fi
#	
#	if [ $AUDITRULE164 -eq 0 ]
#	  then
#	    echo " " >> $AUDITFILE
#	    echo "#############GEN002720#############" >> $AUDITFILE
#	    echo "-a exit,always -F arch=b64 -S creat -F exit=-EPERM" >> $AUDITFILE
#	    service auditd restart
#	fi
#	
	if [ $AUDITRULE264 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002720#############" >> $AUDITFILE
	    echo "-a exit,always -F arch=b64 -S creat -F success=0" >> $AUDITFILE
	    service auditd restart
	fi
	
	
#32 Bit instances for 64 Bit OS
	
#	if [ $AUDITCOUNT32 -eq 0 ]
#	  then
#	    echo " " >> $AUDITFILE
#	    echo "#############GEN002720#############" >> $AUDITFILE
#	    echo "-a exit,always -F arch=b32 -S creat -F exit=-EACCES" >> $AUDITFILE
#	    service auditd restart
#	fi
#	if [ $AUDITRULE132 -eq 0 ]
#	  then
#	    echo " " >> $AUDITFILE
#	    echo "#############GEN002720#############" >> $AUDITFILE
#	    echo "-a exit,always -F arch=b32 -S creat -F exit=-EPERM" >> $AUDITFILE
#	    service auditd restart
#	fi
#	
	if [ $AUDITRULE232 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002720#############" >> $AUDITFILE
	    echo "-a exit,always -F arch=b32 -S creat -F success=0" >> $AUDITFILE
	    service auditd restart
	fi	

#32 Bit OS Only	
else
    			
#	if [ $AUDITCOUNT32 -eq 0 ]
#	  then
#	    echo " " >> $AUDITFILE
#	    echo "#############GEN002720#############" >> $AUDITFILE
#	    echo "-a exit,always -F arch=b32 -S creat -F exit=-EACCES" >> $AUDITFILE
#	    service auditd restart
#	fi
#	if [ $AUDITRULE132 -eq 0 ]
#	  then
#	    echo " " >> $AUDITFILE
#	    echo "#############GEN002720#############" >> $AUDITFILE
#	    echo "-a exit,always -F arch=b32 -S creat -F exit=-EPERM" >> $AUDITFILE
#	    service auditd restart
#	fi
	
	if [ $AUDITRULE232 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002720#############" >> $AUDITFILE
	    echo "-a exit,always -F arch=b32 -S creat -F success=0" >> $AUDITFILE
	    service auditd restart
	fi

fi
