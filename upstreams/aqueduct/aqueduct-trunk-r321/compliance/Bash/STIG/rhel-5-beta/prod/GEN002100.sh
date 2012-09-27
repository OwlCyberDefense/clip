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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 16-jan-2012 to catch all pam entries involving pam_rhosts.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-11989
#Group Title: The .rhosts supported in PAM
#Rule ID: SV-27233r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN002100
#Rule Title: The .rhosts file must not be supported in PAM.
#
#Vulnerability Discussion: The Berkeley r-commands are legacy services 
#which allow cleartext remote access and have an insecure trust model 
#and should never be used. The ability to use .rhosts files, which are 
#used to specify a list of hosts that are permitted remote access to a 
#particular account without authenticating, should be disabled.
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Check the PAM configuration for rhosts_auth.
#
#Example:
# grep rhosts_auth /etc/pam.d/*
#
#If a rhosts_auth entry is found, this is a finding.
#
#Fix Text: Edit the file(s) in /etc/pam.d referencing the rhosts_auth 
#module, and remove the references to the rhosts_auth module.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002100

#Start-Lockdown

for PAMFILE in `egrep -i '^[^#].*pam_rhosts_' /etc/pam.d/* | awk -F':' '{print $1}'`
do
  sed -i -e 's/^[^#].*pam_rhosts_auth.*$/#&/g' $PAMFILE

done
