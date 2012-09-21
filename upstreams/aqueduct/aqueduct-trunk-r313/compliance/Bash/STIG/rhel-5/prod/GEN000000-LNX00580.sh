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
# Group ID (Vulid): V-4342
# Group Title: GEN000000-LNX00580
# Rule ID: SV-37327r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN000000-LNX00580
# Rule Title: The x86 CTRL-ALT-DELETE key sequence must be disabled.
#
# Vulnerability Discussion: Undesirable reboots can occur if the 
# CTRL-ALT-DELETE key sequence is not disabled.  Such reboots may cause a 
# loss of data or loss of access to critical information.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Verify that reboot  using the CTRL-ALT-DELETE key sequence  has been 
# disabled by performing:
# grep ctrlaltdel /etc/inittab
#  If the line returned does not specifiy "/usr/bin/logger" or is not 
# commented out then this is a finding.
#
# Fix Text: 
#
# Ensure the CTRL-ALT-DELETE key sequence has been disabled and attempts 
# to use the sequence are logged.
# In the /etc/inittab file replace:
# ca::ctrlaltdel:/sbin/shutdown -t3 -r now
# with
# ca:nil:ctrlaltdel:/usr/bin/logger -p security.info "Ctrl-Alt-Del was 
# pressed"
  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000000-LNX00580
	
# Start-Lockdown


#Start-Lockdown

# Check for upstart config and use it if it exists
if [ -e "/etc/init/control-alt-delete.conf" ]
then

  grep '^[a-zA-Z]' /etc/init/control-alt-delete.conf > /dev/null
  if [ $? == 0 ]
  then
    sed -i -e 's/\(^[a-zA-Z]\)/#\1/g' /etc/init/control-alt-delete.conf
  fi

# default to the /etc/inittab file
else

  grep  "^ca::ctrlaltdel" /etc/inittab > /dev/null
  if [ $? == 0 ]
  then
    sed -i -e 's/ca::ctrlaltdel/#Commented out to meet GEN000000-LNX00580\n#ca::ctrlaltdel/g' /etc/inittab
  fi

fi
