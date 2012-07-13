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
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22588
#Group Title: GEN008800
#Rule ID: SV-26990r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN008800
#Rule Title: The system package management tool must cryptographically verify the authenticity of software packages during installation.
#
#Vulnerability Discussion: To prevent the installation of software from unauthorized sources, the system package management tool must use cryptographic algorithms to verify the packages are authentic.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check that RPM signature validatation is not disabled.
# grep nosignature /etc/rpmrc /usr/lib/rpm/rpmrc /usr/lib/rpm/redhat/rpmrc ~root/.rpmrc
#If any configuration is found, this is a finding.
#
#Check that YUM signature validation is not disabled.
# grep gpgcheck /etc/yum.conf /etc/yum.repos.d/*
#If any "gpgcheck" setting is returned that is not equal to 1, this is a finding.
#
#Check that up2date signature validation is not disabled.
# grep gpgcheck /etc/sysconfig/rhn/up2date
#If the file exists and does not contain a "useGPG" setting, or the setting does not have the value of "Yes", this is a finding.
#
#Check Content: 
#Check that RPM signature validatation is not disabled.
# grep nosignature /etc/rpmrc /usr/lib/rpm/rpmrc /usr/lib/rpm/redhat/rpmrc ~root/.rpmrc
#If any configuration is found, this is a finding.
#
#Check that yum signature validation is not disabled.
# grep gpgcheck /etc/yum.conf /etc/yum.repos.d/*
#If any "gpgcheck" setting is returned that is not equal to 1, this is a finding.
#
#Fix Text: Edit the RPM configuration file containing the "nosignature" option and remove the option.
#Edit the /etc/sysconfig/rhn/up2date and add or set the "useGPG" setting to "Yes".
#Edit the YUM configuration containing "gpgcheck=0" and set the value to 1.
#Fix Text: Edit the RPM configuration file containing the "nosignature" option and remove the option.
#Edit the YUM configuration containing "gpgcheck=0" and set the value to 1.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008800

#Start-Lockdown
