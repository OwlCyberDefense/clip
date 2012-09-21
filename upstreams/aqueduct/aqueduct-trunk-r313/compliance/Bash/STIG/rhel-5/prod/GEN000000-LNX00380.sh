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
# Group ID (Vulid): V-1022
# Group Title: GEN000000-LNX00380
# Rule ID: SV-37217r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000000-LNX00380
# Rule Title: An X server must have none of the following options 
# enabled: -ac, -core (except for debugging purposes), or -nolock.

#
# Vulnerability Discussion: These options will detract from the security 
# of the Xwindows system.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Verify the options of the running Xwindows server are correct.

# Procedure:

# Get the running xserver information

# ps -ef |grep X

# If the response contains /usr/bin/Xorg:0 

#       /usr/bin/Xorg:0 -br -audit 0 -auth /var/gdm/:0.Xauth -nolisten tcp 
# vt7

# this is indicative of Xorg starting through gdm. This is the default 
# window manager on RHEL.

# If the "-ac" option is found, this is a finding.
# If the "-core" option is found, this is a finding.
# If the "-nolock" option is found, this is a finding.


# If the response to the grep contains X:0 

# /usr/bin/X:0

# Examine the X:0 line:

# If the "-ac" option is found, this is a finding.
# If the "-core" option is found, this is a finding.
# If the "-nolock" option is found, this is a finding.
#
# Fix Text: 
#
# Disable the unwanted options: 
# Procedure:
# For gdm:
# Remove the -ac, -core and -nolock options by creating a "command" entry 
# in the /etc/gdm/custom.conf file with the options removed.

# For Xwindows started by xinit:
# Create or modify the .xserverrc script in the users home directory to 
# remove the -ac, -core and -nolock options from the exec /usr/bin/X 
# command.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000000-LNX00380
	
# Start-Lockdown


# Confirm that we actually have GDM installed.  Both the directory 
# holding the files for this GEN as well as the GDM RPM must be missing 
# in order for this check to stop execution of the script
if [ ! -d /etc/gdm ] && ! rpm -q gdm >/dev/null 2>&1 ; then
  exit 0
fi

# There is no longer a way to edit Xorg command line arguments in gnome in
# RHEL6. The -ac -core and -nolock options are not hard coded into gdm by 
# default, so these shouldn't be a problem for RHEL6.
grep 'release 5' /etc/redhat-release > /dev/null
if [ $? == 0 ]
then

  if [ -e /etc/gdm/custom.conf ]
  then
    XAUDITLEVEL=$( grep -c "command=/usr/bin/Xorg -br -audit 4 -s 15" /etc/gdm/custom.conf )
    if [ $XAUDITLEVEL -eq 0 ]
    then
      cat <<EOF >> /etc/gdm/custom.conf
#Configured for DISA requirement GEN000000-LNX00360

[server-Standard]
name=Standard server
command=/usr/bin/Xorg -br -audit 4 -s 15
chooser=false
handled=true
flexible=true
priority=0
EOF

    fi # End if [ $XAUDITLEVEL -eq 0 ]

  # If the file isn't there, but the package is, lets create it.
  else

    mkdir /etc/gdm 2> /dev/null
    chmod 755 /etc/gdm 2> /dev/null

    cat <<EOF >> /etc/gdm/custom.conf
#Configured for DISA requirement GEN000000-LNX00360

[server-Standard]
name=Standard server
command=/usr/bin/Xorg -br -audit 4 -s 15
chooser=false
handled=true
flexible=true
priority=0
EOF

  fi # End if [ -e /etc/gdm/custom.conf ] / else check

fi # End RHEL5/RHEL6 check

