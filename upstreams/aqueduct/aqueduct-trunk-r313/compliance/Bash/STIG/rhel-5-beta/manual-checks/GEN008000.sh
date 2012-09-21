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
#Group ID (Vulid): V-22556
#Group Title: GEN008000
#Rule ID: SV-26942r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008000
#Rule Title: If the system is using LDAP for authentication or account information, certificates used to authenticate to the LDAP server must be provided from DoD PKI or a DoD-approved external PKI.
#
#Vulnerability Discussion: LDAP can be used to provide user authentication and account information, which are vital to system security. Communication between an LDAP server and a host using LDAP requires authentication.
#
#Responsibility: System Administrator
#IAControls: DCNR-1
#
#Check Content: 
#Check if the system is using NSS LDAP.
# grep -v '^#' /etc/nsswitch.conf | grep ldap
#If no lines are returned, this vulnerability is not applicable.
#
#Check that a certificate is used for client authentication to the server.
# grep -i '^tls_cert' /etc/ldap.conf
#If no line is found, this is a finding.
#
#List the certificate issuer.
# openssl x509 -text -in <cert>
#If the certificate is not issued by DoD PKI or a DoD-approved external PKI, this is a finding.
#
#Fix Text: Edit /etc/ldap.conf and add or edit the 'tls_cert' setting to reference a file containing a client certificate issued by DoD PKI or a DoD-approved external PKI.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008000

#Start-Lockdown

#Manual check
