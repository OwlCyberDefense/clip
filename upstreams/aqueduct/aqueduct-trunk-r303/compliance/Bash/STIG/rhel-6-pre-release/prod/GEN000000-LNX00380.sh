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
# arguments through gdm.  The -ac -core and -nolock options are not hard 
# coded into gdm by default, so these shouldn't be a problem.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-1022
#Group Title: X Server Options Not Enabled
#Rule ID: SV-1022r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000000-LNX00380
#Rule Title: An X server must have none of the following options 
#enabled: -ac, -core (except for debugging purposes), or -nolock.
#
#Vulnerability Discussion: These options will detract from the 
#security of the Xwindows system.
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
#
#This is indicative of Xorg starting through gdm. This is the default 
#and most common gui on RHEL5.
#
#Examine the Xorg line or alternatively:
# egrep "^(command|\[server)" /usr/share/gdm/defaults.conf
# egrep "^(command|\[server)" /etc/gdm/custom.conf
#Lines in custom.conf overide the corresponding lines in defaults.conf.
#
#If the "-ac" option is found, this is a finding.
#If the "-core" option is found, this is a finding.
#If the "-nolock" option is found, this is a finding.
#
#
#If the response to the grep contains X:0
#
#/usr/bin/X:0
#
#Examine the X:0 line:
#
#If the "-ac" option is found, this is a finding.
#If the "-core" option is found, this is a finding.
#If the "-nolock" option is found, this is a finding.
#
#
#Fix Text: Disable the unwanted options:
#Procedure:
#For gdm:
#Remove the -ac, -core and -nolock options by creating a "command" 
#entry in the custom.conf file with the options removed.
#
#For Xwindows started by xinit:
#Create or modify the .xserverrc script in the users home directory 
#to remove the -ac, -core and -nolock options from the exec /usr/bin/X command.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000000-LNX00380

#Start-Lockdown

# There is no longer a way to edit Xorg command line arguments in gnome. The -ac
# -core and -nolock options are not hard coded into gdm by default, so these 
# shouldn't be a problem.
