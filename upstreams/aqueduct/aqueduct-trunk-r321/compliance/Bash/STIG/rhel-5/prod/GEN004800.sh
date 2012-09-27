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
# Group ID (Vulid): V-12010
# Group Title: GEN004800
# Rule ID: SV-37515r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN004800
# Rule Title: Unencrypted FTP must not be used on the system.
#
# Vulnerability Discussion: :  FTP is typically unencrypted and presents 
# confidentiality and integrity risks. FTP may be protected by encryption 
# in certain cases, such as when used in a Kerberos environment. SFTP and 
# FTPS are encrypted alternatives to FTP.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Perform the following to determine if unencrypted FTP is enabled:

# chkconfig --list gssftp
# chkconfig --list vsftpd

# If any of these services are found, ask the SA if these services are 
# encrypted. If they are not, this is a finding.
#
# Fix Text: 
#
# Disable the FTP daemons.

# Procedure:
# chkconfig gssftp off
# chkconfig vsftpd off     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004800
	
# Start-Lockdown
for SERVICE in telnet gssftp vsftpd
do
  chkconfig --list $SERVICE 2> /dev/null | egrep 'on' > /dev/null
  if [ $? -eq 0 ]
  then
    chkconfig $SERVICE off
    if [ "$SERVICE" = 'vsftpd' ]
    then 
      service $SERVICE stop > /dev/null
    fi
  fi
done


