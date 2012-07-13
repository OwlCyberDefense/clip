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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com) on
# 08-jan-2012 to output an error in the standard error file if a hash
# is found in /etc/passwd.



#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22347
#Group Title: GEN001470
#Rule ID: SV-26467r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001470
#Rule Title: The /etc/passwd file must not contain password hashes.
#
#Vulnerability Discussion: If password hashes are readable by 
#non-administrators, the passwords are subject to attack through lookup 
#tables or cryptographic weaknesses in the hashes.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that no password hashes are present in /etc/passwd.
# cut -d : -f 2 /etc/passwd | grep -v '^(x|\*)$'
#If any password hashes are returned, this is a finding.
#
#Fix Text: Migrate /etc/passwd password hashes to /etc/shadow.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001470

#Start-Lockdown	

# Lets go ahead and make sure an error is reported just in case.
BADHASH=`awk -F ':' '{if($2 != "x" && $2 != "*") print $1}' /etc/passwd | tr "\n" " "`  
if [ "$BADHASH" != "" ]
then

    echo "------------------------------" > $PDI-error.log
    date >> $PDI-error.log
    echo " " >> $PDI-error.log
    echo "$PDI: The following users have password hashes in the /etc/passwd file." >> $PDI-error.log
    echo "${BADHASH}" >> $PDI-error.log
    echo "------------------------------" >> $PDI-error.log

fi

