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
# on 09-jan-2012 to check for 2 nameserver entries in the /etc/resolv.conf
# only if dns is enabled.



#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22331
#Group Title: GEN001375
#Rule ID: SV-26424r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN001375
#Rule Title: For systems using DNS resolution, at least two name servers 
#must be configured.
#
#Vulnerability Discussion: To provide availability for name resolution 
#services, multiple redundant name servers are mandated. A failure in 
#name resolution could lead to the failure of security functions requiring 
#name resolution, which may include time synchronization, centralized
#authentication, and remote system logging.

#Responsibility: System Administrator
#IAControls: ECSC-1

#Check Content: 
#Determine if DNS is enabled on the system.
# grep dns /etc/nsswitch.conf
#If no line is returned, or any returned line is commented out, the 
#system does not use DNS, and this is not applicable.
#
#Determine the name servers used by the system.
# grep nameserver /etc/resolv.conf
#If less than two lines are returned that are not commented out, this 
#is a finding. 
#Fix Text: Edit /etc/resolv.conf and add additional "nameserver" lines 
#until at least two are present.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001375

#Start-Lockdown

# From the text we need to check if dns is enabled and only check for 2 dns 
# servers in the /etc/resolv.conf if it is.
egrep '^hosts.*dns' /etc/nsswitch.conf > /dev/null
if [ $? -eq 0 ]
then
  COUNT=`grep '^nameserver' /etc/resolv.conf | wc -l`
  if [ $COUNT -lt 2 ]
  then
    echo "------------------------------" > $PDI-error.log
    date >> $PDI-error.log
    echo " " >> $PDI-error.log
    echo "$PDI: You need at least 2 nameserver entries in /etc/resolv.conf" >> $PDI-error.log
    echo "------------------------------" >> $PDI-error.log

  fi
fi
