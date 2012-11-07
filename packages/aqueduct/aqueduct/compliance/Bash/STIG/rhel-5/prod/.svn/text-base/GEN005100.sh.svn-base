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
# Group ID (Vulid): V-848
# Group Title: GEN005100
# Rule ID: SV-37564r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN005100
# Rule Title: The TFTP daemon must have mode 0755 or less permissive.
#
# Vulnerability Discussion: If TFTP runs with the setuid or setgid bit 
# set, it may be able to write to any file or directory and may seriously 
# impair system integrity, confidentiality, and availability.
#
# Responsibility: System Administrator
# IAControls: ECPA-1
#
# Check Content:
#
# Check the mode of the TFTP daemon.

# Procedure:
# grep "server " /etc/xinetd.d/tftp
# ls -lL <in.tftpd binary> 

# If the mode of the file is more permissive than 0755, this is a finding.


#
# Fix Text: 
#
# Change the mode of the TFTP daemon.

# Procedure:
# chmod 0755 <in.tftpd binary>     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005100
	
# Start-Lockdown
if [ -a "/usr/sbin/in.tftpd" ]
  then

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' /usr/sbin/in.tftpd`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7022)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&2)) != "0" ] || [ $(($FILEOTHER&2)) != "0" ]
      then
        chmod u-s,g-ws,o-wt /usr/sbin/in.tftpd
    fi
fi

