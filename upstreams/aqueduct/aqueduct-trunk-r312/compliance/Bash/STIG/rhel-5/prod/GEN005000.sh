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
# Group ID (Vulid): V-4387
# Group Title: GEN005000
# Rule ID: SV-37549r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN005000
# Rule Title: Anonymous FTP accounts must not have a functional shell.
#
# Vulnerability Discussion: If an anonymous FTP account has been 
# configured to use a functional shell, attackers could gain access to the 
# shell if the account is compromised.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# Check the shell for the anonymous FTP account.

# Procedure:
# grep "^ftp" /etc/passwd

# This is a finding if the seventh field is empty (the entry ends with a 
# ':') or if the seventh field does not contain one of the following:

# /bin/false
# /dev/null
# /usr/bin/false
# /bin/true
# /sbin/nologin


#
# Fix Text: 
#
# Configure anonymous FTP accounts to use a non-functional shell. If 
# necessary, edit the /etc/passwd file to remove any functioning shells 
# associated with the ftp account and replace them with non-functioning 
# shells, such as /dev/null.    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005000
FTPNOLOGIN=$( grep "^ftp" /etc/passwd | grep -c  "/sbin/nologin" )
FTPACCOUNT=$( cat /etc/passwd|grep -c '^ftp' )

#Start-Lockdown

#Is the ftp account there?
if [ $FTPACCOUNT -eq 1 ]
  then
    #Is the shell not /sbin/nologin?
    if [ $FTPNOLOGIN -eq 0 ]
      then
        usermod -s /sbin/nologin ftp
    fi
fi
