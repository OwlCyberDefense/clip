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
# on 30-dec-2011 to include an ACL check before running setfacl.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22334
#Group Title: GEN001390
#Rule ID: SV-26427r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001390
#Rule Title: The /etc/passwd file must not have an extended ACL.
#
#Vulnerability Discussion: File system ACLs can provide access to 
#files beyond what is allowed by the mode numbers of the files. The 
#/etc/passwd file contains the list of local system accounts. It is 
#vital to system security and must be protected from unauthorized 
#modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that /etc/passwd has no extended ACL.
# ls -l /etc/passwd
#If the permissions include a '+', the file has an extended ACL, 
#this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/passwd 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001390

#Start-Lockdown

if [ -a "/etc/passwd" ]
  then
    ACLOUT=`getfacl --skip-base /etc/passwd 2>/dev/null`;
    if [ "$ACLOUT" != "" ]
      then
      setfacl --remove-all /etc/passwd
    fi
  else
    echo "------------------------------" > $PDI-error.log
    date >> $PDI-error.log
    echo " " >> $PDI-error.log
    echo "/etc/passwd does not exist." >> $PDI-error.log
    echo "Could not remove ACL" >> $PDI-error.log
    echo "------------------------------" >> $PDI-error.log
fi





