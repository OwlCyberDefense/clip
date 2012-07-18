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
# on 14-Feb-2012 to move from dev to prod and add fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-12026
#Group Title: NIS Maps Domain Names
#Rule ID: SV-12527r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN006420
#Rule Title: NIS maps must be protected through hard-to-guess domain names.
#
#Vulnerability Discussion: The use of hard-to-guess NIS domain names provides additional protection from unauthorized access to the NIS directory information.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
##
#Check Content: 
#Check the domain name for NIS maps.
#
#Procedure:
# domainname
#
#If the name returned is simple to guess, such as the organization name, building or room name, etc., this is a finding.
#
#Fix Text: Change the NIS domainname to a value difficult to guess. Consult vendor documentation for the required procedure.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN006420

#Start-Lockdown

# Check that ypserv is installed first
rpm -q ypserv > /dev/null
if [ $? -eq 0 ]
then

  DNAME=`cat /dev/urandom | tr -cd "[:upper:]" | head -c ${1:-10}`
  grep 'DOMAINNAME=' /etc/sysconfig/network > /dev/null
  if [ $? -ne 0 ]
  then
    # Generate a random domainname
    echo "# Domainname added for STIG check $PDI" >> /etc/sysconfig/network
    echo "DOMAINNAME=$DNAME" >> /etc/sysconfig/network
  else
    sed -i -e "s/DOMAINNAME=.*/DOMAINNAME=${DNAME}/g" /etc/sysconfig/network
  fi

  grep 'NISDOMAIN=' /etc/sysconfig/network > /dev/null
  if [ $? -ne 0 ]
  then
    # Generate a random domainname
    echo "# Domainname added for STIG check $PDI" >> /etc/sysconfig/network
    echo "NISDOMAIN=$DNAME" >> /etc/sysconfig/network
  else
    sed -i -e "s/NISDOMAIN=.*/NISDOMAIN=${DNAME}/g" /etc/sysconfig/network
  fi
fi
