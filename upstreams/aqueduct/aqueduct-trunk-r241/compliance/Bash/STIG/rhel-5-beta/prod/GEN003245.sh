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
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 31-jan-2012 to include an ACL check before running setfacl.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22390
#Group Title: GEN003245
#Rule ID: SV-26548r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003245
#Rule Title: The at.allow file must not have an extended ACL.
#
#Vulnerability Discussion: File system extended ACLs provide access to 
#files beyond what is allowed by the mode numbers of the files. 
#Unauthorized modification of the at.allow file could result in denial 
#of service to authorized "at" users and the granting of the ability 
#to run "at" jobs to unauthorized users.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the file.
# ls -lL /etc/at.allow
#If the permissions include a '+', the file has an extended ACL, 
#this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/at.allow    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003245

#Start-Lockdown
if [ -a "/etc/at.allow" ]
then
  ACLOUT=`getfacl --skip-base /etc/at.allow 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all /etc/at.allow
  fi
fi
