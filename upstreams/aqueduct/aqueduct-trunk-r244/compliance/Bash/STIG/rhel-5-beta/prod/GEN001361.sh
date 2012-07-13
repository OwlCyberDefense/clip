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
# on 09-jan-2012 to include an ACL check before running setfacl.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22318
#Group Title: GEN001361
#Rule ID: SV-26383r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001361
#Rule Title: NIS/NIS+/yp command files must not have extended ACLs.
#
#Vulnerability Discussion: NIS/NIS+/yp files are part of the system's 
#identification and authentication processes and are, therefore, critical 
#to system security. ACLs on these files could result in unauthorized 
#modification, which could compromise these processes and the system.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that NIS/NIS+/yp files have no extended ACLs.
# ls -lL /var/yp/*
#If the permissions include a '+', the file has an extended ACL, 
#this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /var/yp/*   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001361

#Start-Lockdown
for CURFILE in `find /var/yp -type f`
do
  ACLOUT=`getfacl --skip-base $CURFILE 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all $CURFILE
  fi
done

