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
# Group ID (Vulid): V-23732
# Group Title: GEN000410
# Rule ID: SV-28606r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000410
# Rule Title: The FTPS/FTP service on the system must be configured with 
# the Department of Defense (DoD) login banner.
#
# Vulnerability Discussion: Failure to display the logon banner prior to 
# a logon attempt will negate legal proceedings resulting from unauthorized 
# access to system resources.

# Note:  SFTP and FTPS are encrypted alternatives to FTP to be used in 
# place of FTP.  SFTP is implemented by the SSH service and uses its banner 
# configuration.
#
# Responsibility: System Administrator
# IAControls: ECWM-1
#
# Check Content:
#
# FTP to the system. 
# ftp localhost
# Check for either of the following login banners based on the character 
# limitations imposed by the system. An exact match is required. If one of 
# these banners is not displayed, this is a finding. If the system does not 
# run the FTP service, this is not applicable.

# DoD Login Banners:

# You are accessing a U.S. Government (USG) Information System (IS) that is 
# provided for USG-authorized use only.

# By using this IS (which includes any device attached to this IS), you 
# consent to the following conditions:

# -The USG routinely intercepts and monitors communications on this IS for 
# purposes including, but not limited to, penetration testing, COMSEC 
# monitoring, network operations and defense, personnel misconduct (PM), 
# law enforcement (LE), and counterintelligence (CI) investigations.

# -At any time, the USG may inspect and seize data stored on this IS.

# -Communications using, or data stored on, this IS are not private, are 
# subject to routine monitoring, interception, and search, and may be 
# disclosed or used for any USG-authorized purpose.

# -This IS includes security measures (e.g., authentication and access 
# controls) to protect USG interests--not for your personal benefit or 
# privacy.

# -Notwithstanding the above, using this IS does not constitute consent to 
# PM, LE or CI investigative searching or monitoring of the content of 
# privileged communications, or work product, related to personal 
# representation or services by attorneys, psychotherapists, or clergy, and 
# their assistants. Such communications and work product are private and 
# confidential. See User Agreement for details. 

# OR

# I've read & consent to terms in IS user agreem't.
#
# Fix Text: 
#
# Provide the proper text for the DoD banner to be presented by the FTP 
# server to the user.

# For vsftp:
# Examine the /etc/vsftp.conf file for the "banner_file" entry. (i.e. 
# banner_file = /etc/banner/vsftp)

# For gssftp:
# Examine the /etc/xinetd.d/gssftp file for the "banner" entry. (i.e. 
# banner = /etc/banner/gssftp)

# For both:
# Add the banner entry if one is not found.

# Modify or create the referenced banner file to contain one of the 
# following DoD login banners (based on the character limitations imposed 
# by the system).

# DoD Login Banners:

# You are accessing a U.S. Government (USG) Information System (IS) that is 
# provided for USG-authorized use only.

# By using this IS (which includes any device attached to this IS), you 
# consent to the following conditions:

# -The USG routinely intercepts and monitors communications on this IS for 
# purposes including, but not limited to, penetration testing, COMSEC 
# monitoring, network operations and defense, personnel misconduct (PM), 
# law enforcement (LE), and counterintelligence (CI) investigations.

# -At any time, the USG may inspect and seize data stored on this IS.

# -Communications using, or data stored on, this IS are not private, are 
# subject to routine monitoring, interception, and search, and may be 
# disclosed or used for any USG-authorized purpose.

# -This IS includes security measures (e.g., authentication and access 
# controls) to protect USG interests--not for your personal benefit or 
# privacy.

# -Notwithstanding the above, using this IS does not constitute consent to 
# PM, LE or CI investigative searching or monitoring of the content of 
# privileged communications, or work product, related to personal 
# representation or services by attorneys, psychotherapists, or clergy, and 
# their assistants. Such communications and work product are private and 
# confidential. See User Agreement for details. 

# OR

# I've read & consent to terms in IS user agreem't.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000410
	
# Start-Lockdown

if [ -a "/etc/vsftpd/vsftpd.conf" ]
then
  grep '^banner_file' /etc/vsftpd/vsftpd.conf > /dev/null
  if [ $? != 0 ]
  then
    echo "# Added fix for STIG id GEN000410" >> /etc/vsftpd/vsftpd.conf
    echo "banner_file=/etc/issue" >> /etc/vsftpd/vsftpd.conf
  fi
fi


if [ -a "/etc/xinetd.d/gssftp" ]
then
  grep 'banner = /etc/issue' /etc/xinetd.d/gssftp > /dev/null
  if [ $? != 0 ]
  then
    sed -i -e 's/^\}/\tbanner = \/etc\/issue\n\}/g' /etc/xinetd.d/gssftp
  fi
fi
