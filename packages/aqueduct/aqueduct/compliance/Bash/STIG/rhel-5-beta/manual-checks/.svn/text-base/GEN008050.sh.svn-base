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
#Group ID (Vulid): V-24384
#Group Title: GEN008050
#Rule ID: SV-30059r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008050
#Rule Title: If the system is using LDAP for authentication or account information, the /etc/ldap.conf file (or equivalent) must not contain passwords.
#
#Vulnerability Discussion: The authentication of automated LDAP connections between systems must not use passwords since more secure methods are available, such as PKI and Kerberos. Additionally, the storage of unencrypted passwords on the system is not permitted.
#
#Responsibility: System Administrator
#IAControls: IAIA-1, IAIA-2
#
#Check Content: 
#Consult vendor documentation for the procedures concerning the configuration of LDAP for providing authentication and account information. Examine the LDAP configuration file(s). If the LDAP configuration file contains an unencrypted password, this is a finding. If the LDAP configuration file contains an encrypted password that is accessible by regular users on the system, this is a finding.
#
#Fix Text: Consult vendor documentation for the procedures for configuring LDAP for authentication and account information. Remove any passwords from LDAP configuration files.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008050

#Start-Lockdown

#Manual 
