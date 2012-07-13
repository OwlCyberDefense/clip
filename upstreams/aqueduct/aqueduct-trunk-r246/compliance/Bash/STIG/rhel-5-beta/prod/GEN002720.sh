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
# Updated by Vincent C. Passaro | Apr 11th 2012
		#Documentation cleanup
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-814
#Group Title: Audit failed file and program access attempts
#Rule ID: SV-27291r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002720
#Rule Title: The audit system must be configured to audit failed 
#attempts to access files and programs.
#
#Vulnerability Discussion: If the system is not configured to 
#audit certain activities and write them to an audit log, it is 
#more difficult to detect and track system compromises and damages 
#incurred during a system compromise.
#
#
#Responsibility: System Administrator
#IAControls: ECAR-1, ECAR-2, ECAR-3
#
#Check Content: 
#Check that auditd is configured to audit failed file access attempts.
#
# cat /etc/audit.rules /etc/audit/audit.rules | grep -e "-a always,exit" | grep -i "open"
#If no results are returned, or the results do not contain "-S open" and "-F success=0", this is a finding.
#
#
#
#Fix Text: Edit the audit.rules file and add the following line 
#to enable auditing of failed attempts to access files and programs:
#-a always,exit -F arch=<ARCH> -S open -F success=0 Restart the auditd service.
# service auditd restart 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002720
UNAME=$( uname -m )
BIT64='x86_64'
AUDITRULE64='-a always,exit -F arch=b64 -S open -F success=0'
AUDITRULE32='-a always,exit -F arch=b32 -S open -F success=0'
AUDITFILE='/etc/audit/audit.rules'
AUDITCOUNT64=$( grep -c "a always,exit -F arch=b64 -S open -F success=0" $AUDITFILE )
AUDITCOUNT32=$( grep -c "a always,exit -F arch=b32 -S open -F success=0" $AUDITFILE )

#Start-Lockdown

if [ $UNAME == $BIT64 ]
  then
    			
	if [ $AUDITCOUNT64 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002720#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b64 -S open -F success=0" >> $AUDITFILE
	    service auditd restart
	fi

	if [ $AUDITCOUNT32 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002720#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S open -F success=0" >> $AUDITFILE
	    service auditd restart
	fi

else
    			
	if [ $AUDITCOUNT32 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002720#############" >> $AUDITFILE
	    echo "-a always,exit -F arch=b32 -S open -F success=0" >> $AUDITFILE
	    service auditd restart
	fi

fi



