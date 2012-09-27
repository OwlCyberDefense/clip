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
#  - update by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 04-feb-2012 to add USERCTL=no to interfaces files who are missing the
# config.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22408
#Group Title: GEN003581
#Rule ID: SV-26620r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003581
#Rule Title: Network interfaces must not be configured to allow user control.
#
#Vulnerability Discussion: Configuration of network interfaces should be limited to privileged users. Manipulation of network interfaces may result in a denial of service or bypass of network security mechanisms.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the system for user-controlled network interfaces.
# grep -l '^USERCTL=yes' /etc/sysconfig/network-scripts/ifcfg*
#If any results are returned, this is a finding.
#
#Fix Text: Edit the configuration for the user-controlled interface and remove the "USERCTL=yes" configuration line or set to "USERCTL=no".   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003581

#Start-Lockdown
for NICCONF in `ls /etc/sysconfig/network-scripts/ifcfg*`
do
  grep USERCTL $NICCONF > /dev/null
  if [ $? -eq 0 ]
  then
    sed -i 's/USERCTL=yes/USERCTL=no/g' $NICCONF
  else
    echo "USERCTL=no" >> $NICCONF
  fi
done
