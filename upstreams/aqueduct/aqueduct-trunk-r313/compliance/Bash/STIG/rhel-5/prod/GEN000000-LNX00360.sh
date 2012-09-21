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
# Group ID (Vulid): V-1021
# Group Title: GEN000000-LNX00360
# Rule ID: SV-37207r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000000-LNX00360
# Rule Title: The X server must have the correct options enabled.
#
# Vulnerability Discussion: Without the correct options enabled, the 
# Xwindows system would be less secure and there would be no screen timeout.
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

# this is indicative of Xorg starting through gdm. This is the default on 
# RHEL.

# Examine the Xorg line:

# If the "-auth" option is missing this would be a finding.
# If the "-audit" option is missing or not set to 4, this is a finding.
# If the "-s" option is missing or greater than 15, this is a finding.


# If the response to the grep contains X:0 

# /usr/bin/X:0

# this indicates the X server was started with the xinit command with no 
# associated .xserverrc in the home directory of the user. No options are 
# selected by default. This is a finding.

# Otherwise if there are options on the X:0 line:
# If the "-auth" option is missing this is a finding 
# If the "-audit" option is missing or not set to 4, this is a finding.
# If the "-s" option is missing or greater than 15, this is a finding.
#
# Fix Text: 
#
# Enable the following options: -audit (at level 4), -auth and -s with 15 
# minutes as the timeout value.

# Procedure for gdm:
# Edit /etc/gdm/custom.conf and add the following:
# [server-Standard] 
# name=Standard server
# command=/usr/bin/Xorg -br -audit 4 -s 15
# chooser=false
# handled=true
# flexible=true
# priority=0

# Procedure for xinit:
# Edit or create a .xserverrc file in the users home directory containing 
# the startup script for xinit.
# This script must have an exec line with at least these options:

# exec /usr/bin/X -audit 4 -s 15 -auth <Xauth file> &

# The <Xauth file> is created using the "xauth" command and is customarily 
# located in the users home directory with the name ".Xauthority".  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000000-LNX00360
	
# Start-Lockdown

# Confirm that we actually have GDM installed.  Both the directory 
# holding the files for this GEN as well as the GDM RPM must be missing 
# in order for this check to stop execution of the script
if [ ! -d /etc/gdm ] && ! rpm -q gdm >/dev/null 2>&1 ; then
  exit 0
fi


# Use gconftool-2 for RHEL6
grep 'release 6' /etc/redhat-release > /dev/null
if [ $? == 0 ]
then

  # Notes:  gnome has made it so that there is no way to set Xorg arguments
  # without hackish workarounds that will not last an update.  The good thing
  # is that they have audit 4 and the auth options hard coded. This only leaves
  # the gconftool-2 command line tool which is almost usless due to the lack of 
  # and just plain wrong documentation for gnome settings.

  #Start-Lockdown
  IDLE_ENABLED=`gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --get /apps/gnome-screensaver/idle_activation_enabled 2>/dev/null`
  if [ "$IDLE_ENABLED" != "true" ]
  then
    gconftool-2 --direct \
    --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory \
    --type bool \
    --set /apps/gnome-screensaver/idle_activation_enabled true
  fi

  IDLE_DELAY=`gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --get /desktop/gnome/session/idle_delay 2>/dev/null`
  if [ "$IDLE_DELAY" != "15" ]
  then
    gconftool-2 --direct \
    --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory \
    --type int \
    --set  /desktop/gnome/session/idle_delay 15
  fi

else # default to RHEL5

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
