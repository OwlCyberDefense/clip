#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com )
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

#!/bin/bash

######################################################################
#By Shannon Mitchell                                                 #
#shannon.mitchell@fusiontechnology-llc.com                           #
######################################################################
#
#   - Created by shannon.mitchell@fusiontechnology-llc.com on 08-apr-2012.
# Newer version of gnome have disabled the ability to change Xorg command line
# arguments through gdm.  The audit and auth entries are hard coded and correct.
# This script setts the idle_delay option to 15 minutes for the screensaver.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-1021
#Group Title: X Server Options Enabled
#Rule ID: SV-1021r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000000-LNX00360
#Rule Title: The X server must have the correct options enabled.
#
#Vulnerability Discussion: Without the correct options enabled, 
#the Xwindows system would be less secure and there would be no screen timeout.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Verify the options of the running Xwindows server are correct.
#
#Procedure:
#
#Get the running xserver information
#
# ps -ef |grep X
#
#If the response contains /usr/X11R6/bin/Xorg:0
#
#      /usr/X11R6/bin/Xorg:0 -br -audit 0 -auth /var/gdm/:0.Xauth -nolisten tcp vt7

#This is indicative of Xorg starting through gdm. This is the default 
#and most common gui on RHEL5.

#Examine the Xorg line:
#
#If the "-auth" option is missing this would be a finding . However 
#gdm always automatically uses the '-auth' option. This is never a finding.
#If the "-audit" option is missing or not set to 4, this is a finding.
#If the "-s" option is missing or greater than 15, this is a finding.
#
#
#If the response to the grep contains X:0
#
#/usr/bin/X:0
#
#This indicates that the X server was started with the xinit 
#command with no associated .xserverrc in the home directory of 
#the user. No options are selected by default. This is a finding.
#
#Otherwise if there are options on the X:0 line:
#If the "-auth" option is missing this is a finding
#If the "-audit" option is missing or not set to 4, this is a finding.
#If the "-s" option is missing or greater than 15, this is a finding.
#
#
#Fix Text: Enable the following options: -audit (at level 4), -auth and -s with 15 minutes as the timeout value.
#
#Procedure for gdm:
#Edit /etc/gdm/custom.conf and add the following:
#[server-Standard]
#name=Standard server
#command=/usr/bin/Xorg -br -audit 4 -s 15
#chooser=false
#handled=true
#flexible=true
#priority=0
#
#Procedure for xinit:
#Edit or create a .xserverrc file in the users home directory 
#containing the startup script for xinit.
#This script must have an exec line with at least these options:

#exec /usr/bin/X -audit 4 -s 15 -auth <Xauth file> &
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000000-LNX00360

# Notes:  gnome has made it so that there is no way to set Xorg arguments
# without hackish workarounds that will not last an update.  The good thing
# is that they have audit 4 and the auth options hard coded. This only leaves
# the gconftool-2 command line tool which is almost usless due to the lack of 
# and just plain wrong documentation for gnome settings.

#Start-Lockdown
IDLE_ENABLED=`gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --get /apps/gnome-screensaver/idle_activation_enabled`
if [ "$IDLE_ENABLED" = "true" ]
then
  gconftool-2 --direct \
  --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory \
  --type bool \
  --set /apps/gnome-screensaver/idle_activation_enabled true
fi

IDLE_DELAY=`gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --get /desktop/gnome/session/idle_delay`
if [ "$IDLE_DELAY" = "15" ]
then
  gconftool-2 --direct \
  --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory \
  --type int \
  --set  /desktop/gnome/session/idle_delay 15
fi

