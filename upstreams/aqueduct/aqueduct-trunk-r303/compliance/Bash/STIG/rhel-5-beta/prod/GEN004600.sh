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
# on 05-Feb-2012 to check if packages are installed before updating them.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4689
#Group Title: Sendmail Version
#Rule ID: SV-4689r8_rule
#Severity: CAT I
#Rule Version (STIG-ID): GEN004600
#Rule Title: The SMTP service must be an up-to-date version.
#
#Vulnerability Discussion: The SMTP service version on the system must be current to avoid exposing vulnerabilities present in unpatched versions.
#
#Responsibility: System Administrator
#IAControls: VIVM-1
#
#Check Content: 
#Determine the version of the SMTP service software.
#
#Procedure:
#rpm -q sendmail
#RedHat sendmail 8.13.8-8 is the latest required version.
#If the RedHat sendmail is installed and the version is not at least 8.13.8-8, this is a finding.
#
#rpm -q postfix
#RedHat postfix-2.5.1-0.4.rhel5 is the latest required version.
#If the postfix is installed and the version is not at least 2-5.1-0.4, this is a finding.
#
#Fix Text: Obtain and install a newer version of Sendmail from RedHat.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004600

#Start-Lockdown
rpm -q sendmail > /dev/null
if [ $? -eq 0 ]
then
  yum update -y sendmail
fi

rpm -q postfix > /dev/null
if [ $? -eq 0 ]
then
  yum update -y postfix
fi

