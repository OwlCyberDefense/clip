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
# on 18-Feb-2012 to fix if entry exists and is true.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22549
#Group Title: GEN007850
#Rule ID: SV-26933r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN007850
#Rule Title: The DHCP client must not send dynamic DNS updates.
#
#Vulnerability Discussion: Dynamic DNS updates transmit unencrypted information about a system including its name and address and should not be used unless needed.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check that the DHCP client is configured to not send dynamic DNS updates.
#
#Procedure:
# grep do-forward-updates /etc/dhclient.conf
#
#If the file is not present, does not contain this configuration, or has the setting set to "true", this is a finding.
#
#Fix Text: Edit or add the /etc/dhclient.conf file and add or edit the "do-forward-updates" setting to false.
#
#Procedure:
# echo "do-forward-updates false;" >> /etc/dhclient.conf   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN007850
#Start-Lockdown

   

if [ ! -f /etc/dhclient.conf ]
  then
    touch /etc/dhclient.conf
    echo "#File creation by Aqueduct"  >> /etc/dhclient.conf
    echo " " >> /etc/dhclient.conf
    echo "#Added for DISA GEN007850" >> /etc/dhclient.conf
    echo "do-forward-updates false;" >> /etc/dhclient.conf
fi

FORWARDUP=$( grep do-forward-updates /etc/dhclient.conf | wc -l )

if [ $FORWARDUP -eq 0 ]
  then
    echo "#Added for DISA GEN007850" >> /etc/dhclient.conf
    echo "do-forward-updates false;" >> /etc/dhclient.conf
  else
    egrep "do-forward-updates.*true;" /etc/dhclient.conf > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/do-forward-updates.*$/do-forward-updates false;/' /etc/dhclient.conf
    fi
fi
 




