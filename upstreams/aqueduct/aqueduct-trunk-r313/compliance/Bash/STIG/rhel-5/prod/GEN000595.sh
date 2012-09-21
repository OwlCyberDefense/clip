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

##################### Fusion Technology LLC #############################
# By Shannon Mitchell                                                   #
# Fusion Technology LLC                                                 #
# Shannon[.]Mitchell[@]fusiontechnology-llc[.]com                       #
# www.fusiontechnology-llc.com                                          #
##################### Fusion Technology LLC #############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Shannon Mitchell   | 15-jul-2012|
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-22304
# Group Title: GEN000595
# Rule ID: SV-26316r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000595
# Rule Title: The password hashes stored on the system must have been 
# generated using a FIPS 140-2 approved cryptographic hashing algorithm.
#
# Vulnerability Discussion: Systems must employ cryptographic hashes for 
# passwords using the SHA-2 family of algorithms or FIPS 140-2 approved 
# successors.  The use of unapproved algorithms may result in weak password 
# hashes more vulnerable to compromise.
#
# Responsibility: System Administrator
# IAControls: DCNR-1, IAIA-1, IAIA-2
#
# Check Content:
#
# Check all password hashes in /etc/passwd or /etc/shadow begin with 
# '$5$' or '$6$'.

# Procedure:
# cut -d ':' -f2 /etc/passwd
# cut -d ':' -f2 /etc/shadow

# Any password hashes present not beginning with '$5$' or '$6$',  is a 
# finding.
#
# Fix Text: 
#
#  Change the passwords for all accounts using non-compliant password 
# hashes. 

# (This requires GEN000590 is already met.)     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000595
	
# Start-Lockdown

FOUNDACCOUNTS=`cat /etc/shadow|grep -v ':\\$6\\$' | grep -v ':\\$5\\$' | grep -v ':!!:' | grep -v ':\*:' | cut -d ":" -f 1 | wc -l`
#Start-Lockdown

if [ $FOUNDACCOUNTS -ge 1 ]
then
 echo "------------------------------" > $PDI-AESACCOUNT.log
 echo "The following accounts need to have their passwords change" >> $PDI-AESACCOUNT.log
 echo "since they appear to not have their hashes stored in aes256" >> $PDI-AESACCOUNT.log
 echo "or aes512" >> $PDI-AESACCOUNT.log
 echo " " >> $PDI-AESACCOUNT.log
 cat /etc/shadow|grep -v ':\$6\$' | grep -v ':\$5\$' | grep -v ':!!:' | grep -v ':\*:' | cut -d ":" -f 1 >> $PDI-AESACCOUNT.log
fi
