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
#Group ID (Vulid): V-22340
#Group Title: GEN001430
#Rule ID: SV-26438r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001430
#Rule Title: The /etc/shadow (or equivalent) file must not have an extended ACL.
#
#Vulnerability Discussion: The /etc/shadow file contains the list of 
#local system accounts. It is vital to system security and must be 
#protected from unauthorized modification. The file also contains password 
#hashes which must not be accessible to users other than root.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that /etc/shadow has no extended ACL.
# ls -l /etc/shadow
#If the permissions include a '+', the file has an extended ACL, this 
#is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/shadow  
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001430

#Start-Lockdown

if [ -a "/etc/shadow" ]
  then
    ACLOUT=`getfacl --skip-base /etc/shadow 2>/dev/null`;
    if [ "$ACLOUT" != "" ]
      then
      setfacl --remove-all /etc/shadow
    fi
  else
    echo "------------------------------" > $PDI-error.log
    date >> $PDI-error.log
    echo " " >> $PDI-error.log
    echo "/etc/shadow  does not exist." >> $PDI-error.log
    echo "Could not remove ACL" >> $PDI-error.log
    echo "------------------------------" >> $PDI-error.log
fi



