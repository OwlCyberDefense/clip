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
# on 05-Feb-2012 to include an ACL check before running setfacl.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22439
#Group Title: GEN004390
#Rule ID: SV-26685r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004390
#Rule Title: The sendmail alias file must not have an extended ACL.
#
#Vulnerability Discussion: Excessive permissions on the alias files may 
#permit unauthorized modification. If an alias file is modified by an 
#unauthorized user, they may modify the file to run malicious code or 
#redirect e-mail.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the /etc/mail/aliases file.
# ls -lL /etc/aliases /etc/aliases.db
#If the permissions include a '+', the file has an extended ACL, 
#this is a finding.
#
#Fix Text: Check the permissions of the alias files.
#
#Procedure:
# setfacl --remove-all /etc/aliases /etc/aliases.db
#If the permissions include a '+', the file has an extended ACL, 
#this is a finding.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004390

#Start-Lockdown

if [ -a "/etc/aliases" ]
then
  ACLOUT=`getfacl --skip-base /etc/aliases 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all /etc/aliases
  fi
fi

if [ -a "/etc/aliases.db" ]
then
  ACLOUT=`getfacl --skip-base /etc/aliases.db 2>/dev/null`;
  if [ "$ACLOUT" != "" ]
  then
    setfacl --remove-all /etc/aliases.db
  fi
fi

