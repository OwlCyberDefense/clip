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
# is found in /etc/gshadow.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22349
#Group Title: GEN001476
#Rule ID: SV-26448r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001476
#Rule Title: The /etc/gshadow file must not contain any group password hashes.
#
#Vulnerability Discussion: Group passwords are typically shared and should not be used.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the /etc/gshadow file for password hashes.
# cut -d : -f 2 /etc/gshadow | egrep -v '^(x|!!)$'
#If any password hashes are returned, this is a finding.
#
#Fix Text: Edit /etc/gshadow and change the password field to an exclamation 
#point (!) to lock the group password.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001476

#Start-Lockdown

# The following are snippets from the gshadow man page:
#
#   If the password field contains some string that is not a valid
#   result of crypt(3), for instance ! or *, users will not be able to
#   use a unix password to access the group (but group members do not
#   need the password).
#
#   ...
#
# This field may be empty, in which case only the group members can
# gain the group permissions.
# Lets go ahead and make sure an error is reported just in case.
BADHASH=`awk -F ':' '{if($2 != "x" && $2 != "*" && $2 != "" && $2 !~ /^!/) print $1}' /etc/gshadow | tr "\n" " "`  
if [ "$BADHASH" != "" ]
then

    echo "------------------------------" > $PDI-error.log
    date >> $PDI-error.log
    echo " " >> $PDI-error.log
    echo "$PDI: The following groups have password hashes set the /etc/gshadow file." >> $PDI-error.log
    echo "${BADHASH}" >> $PDI-error.log
    echo "------------------------------" >> $PDI-error.log

fi

