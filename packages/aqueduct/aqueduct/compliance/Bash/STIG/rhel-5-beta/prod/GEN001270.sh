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
#By Tummy a.k.a Vincent C. Passaro				     #
#Vincent[.]Passaro[@]gmail[.]com	         		     #
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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 09-jan-2012 to add a check for existing file permissions before running
# the setfacl.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22315
#Group Title: GEN001270
#Rule ID: SV-26367r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001270
#Rule Title: All system log files must not have extended ACLs.
#
#Vulnerability Discussion: If the system log files are not protected, 
#unauthorized users could change the logged data, eliminating its 
#forensic value. Authorized software may be given log file access 
#through the use of extended ACLs when needed and configured to 
#provide the least privileges required.
#
#Responsibility: System Administrator
#IAControls: ECLP-1, ECTP-1
#
#Check Content: 
#Check that system log files have no extended ACLs.
#
#Procedure:
# ls -lL /var/log
#
#If the permissions include a '+', the file has an extended ACL. 
#If an extended ACL exists, verify with the SA if the ACL is required 
#to support authorized software and provides the minimum necessary 
#permissions. If an extended ACL exists that provides access beyond 
#the needs of authorized software, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
#
#Procedure:
# setfacl --remove-all [file with extended ACL]   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001270

#MAKE SURE YOU EXCLUDE WTMP!!!
LOGFILES=`find /var/log/ -type f`

#Start-Lockdown

for LOGFILETOFIX in $LOGFILES
  do
    ACLOUT=`getfacl --skip-base $LOGFILETOFIX 2>/dev/null`;
    if [ "$ACLOUT" != "" ]
      then
      setfacl --remove-all $LOGFILETOFIX
    fi

done

