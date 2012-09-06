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
# Group ID (Vulid): V-4694
# Group Title: GEN004700
# Rule ID: SV-37513r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN004700
# Rule Title: The sendmail service must not have the wizard backdoor 
# active.
#
# Vulnerability Discussion: Very old installations of the Sendmail 
# mailing system contained a feature whereby a remote user connecting to 
# the SMTP port can enter the WIZ command and be given an interactive shell 
# with root privileges.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Log into the sendmail server with telnet and test the "wiz" commmand"

# Procedure:
# telnet localhost 25

# Trying 127.0.0.1...
# Connected to locahost.localdomain (127.0.0.1).
# Escape character ...

# Once the telnet greeting is complete type:
# wiz

# If you do not get a "Command unrecognized: " message, this is a finding.


#
# Fix Text: 
#
# If the WIZ command exists on sendmail then the version of sendmail is 
# archaic and should be replaced with the latest version from RedHat.
# WIZ is not available on any sendmail distrubution of RHEL. However,If the 
# WIZ command is enabled on sendmail, it should be disabled by adding this 
# line to the sendmail.cf configuration file (note that it must be typed in 
# uppercase):

# OW*

# For the change to take effect, kill the sendmail process, refreeze the 
# sendmail.cf file, and restart the sendmail process.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN004700
	
# Start-Lockdown

#This is off by default in RHEL 5

#
#Check if sendmail is installed
if [ -a '/etc/mail/sendmail.cf' ]
  then
    #Check if wiz is enabled
	WIZON=$( cat /etc/mail/sendmail.cf |grep -v "^#" | grep -c wiz )
    if [ $WIZON -ne 0 ]
      then
        sed -i "/wiz/d" /etc/mail/sendmail.cf
        
        #Check if sendmail service is running
        service sendmail status | grep 'is running' > /dev/null
          if [ $? -eq 0 ]
            then
              service sendmail restart
          fi
    fi
fi
