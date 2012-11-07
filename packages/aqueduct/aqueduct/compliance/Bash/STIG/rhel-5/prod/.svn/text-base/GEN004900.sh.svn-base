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
# Group ID (Vulid): V-841
# Group Title: GEN004900
# Rule ID: SV-37532r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN004900
# Rule Title: The ftpusers file must contain account names not allowed to 
# use FTP.
#
# Vulnerability Discussion: The ftpusers file contains a list of accounts 
# not allowed to use FTP to transfer files. If the file does not contain 
# the names of all accounts not authorized to use FTP, then unauthorized 
# use of FTP may take place.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# Check the contents of the ftpusers file. 
# For gssftp:
# more /etc/ftpusers

# For vsftp:
# more /etc/vsftpd.ftpusers /etc/vfsftpd/ftpusers
# If the system has accounts not allowed to use FTP and not listed in the 
# ftpusers file, this is a finding.
#
# Fix Text: 
#
# For gssftp:
# Add accounts not allowed to use FTP to the /etc/ftpusers file.
# For vsftp:
# Add accounts not allowed to use FTP to the /etc/vfsftpd.ftpusers or 
# /etc/vfsftpd/ftpusers file (as appropriate). 
  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004900
	
# Start-Lockdown
# Lets assume that the system accounts shouldn't be able to log in by default.
# And leave it up to the users to add more and check as needed.
for SYSACCT in `awk -F':' '{if($3 < 500) print $1}' /etc/passwd`
do
  if [ -e /etc/vsftpd/ftpusers ]
  then
    grep "^$SYSACCT" /etc/vsftpd/ftpusers > /dev/null
    if [ $? -ne 0 ]
    then
      echo $SYSACCT >> /etc/vsftpd/ftpusers
    fi
  fi

  if [ -e /etc/vsftpd.ftpusers ]
  then
    grep "^$SYSACCT" /etc/vsftpd.ftpusers > /dev/null
    if [ $? -ne 0 ]
    then
      echo $SYSACCT >> /etc/vsftpd.ftpusers
    fi
  fi

  if [ -e /etc/ftpusers ]
  then
    grep "^$SYSACCT" /etc/ftpusers > /dev/null
    if [ $? -ne 0 ]
    then
      echo $SYSACCT >> /etc/ftpusers
    fi
  fi

done

