#!/bin/bash

##########################################################################
#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  
#  Vincent C. Passaro (vincent.passaro@gmail.com)
#  Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
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
##########################################################################

###################### Fotis Networks LLC ###############################
# By Vincent C. Passaro                                                 #
# Fotis Networks LLC	                                                #
# Vincent[.]Passaro[@]fotisnetworks[.]com                               #
# www.fotisnetworks.com	                                                #
###################### Fotis Networks LLC ###############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Vincent C. Passaro | 1-Aug-2012 |
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-22555
# Group Title: GEN007980
# Rule ID: SV-37627r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN007980
# Rule Title: If the system is using LDAP for authentication or account 
# information, the system must use a TLS connection using FIPS 140-2 
# approved cryptographic algorithms.
#
# Vulnerability Discussion: LDAP can be used to provide user 
# authentication and account information, which are vital to system 
# security. Communication between an LDAP server and a host using LDAP 
# requires protection.
#
# Responsibility: System Administrator
# IAControls: DCNR-1
#
# Check Content:
#
# Check if the system is using NSS LDAP. 
# grep -v '^#' /etc/nsswitch.conf | grep ldap
# If no lines are returned, this vulnerability is not applicable.
# Check if NSS LDAP is using TLS.
# grep '^ssl start_tls' /etc/ldap.conf
# If no lines are returned, this is a finding.
# Check if NSS LDAP TLS is using only FIPS 140-2 approved cryptographic 
# algorithms.
# grep '^tls_ciphers' /etc/ldap.conf
# If the line is not present, or contains ciphers not approved by FIPS 
# 140-2, this is a finding.  FIPS approved ciphers include 3DES and AES.  
# FIPS approved hashes include the SHA hash family.
#
# Fix Text: 
#
# Edit "/etc/ldap.conf" and add a "ssl start_tls" and "tls_ciphers" 
# options with only FIPS 140-2 approved ciphers.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN007980
	
# Start-Lockdown

