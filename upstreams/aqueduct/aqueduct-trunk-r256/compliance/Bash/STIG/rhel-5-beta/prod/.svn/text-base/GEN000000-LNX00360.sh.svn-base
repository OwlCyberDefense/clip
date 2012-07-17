#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  Vincent C. Passaro (vincent.passaro@gmail.com)
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
#By Tummy a.k.a Vincent C. Passaro				     #
#Vincent[.]Passaro[@]gmail[.]com	         		     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#
# Updated by Vincent C. Passaro 4/30/2012.  Added checking for file 
# before running lockdown.
# Added more error checking 'logic'								     
#
# Updated by Lee Kinser (lkinser@redhat.com) 30 April 2012.  Expanded on
# verification logic to ensure GDM is installed prior to acting on it.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-1021
#Group Title: X Server Options Enabled
#Rule ID: SV-1021r5_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN000000-LNX00360
#Rule Title: The X server must have the correct options enabled.
#
#Vulnerability Discussion: Without the correct options enabled, 
#the Xwindows system would be less secure and there would be no screen 
#timeout.
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


#Start-Lockdown

# Confirm that we actually have GDM installed.  Both the directory holding the files for this GEN
# as well as the GDM RPM must be missing in order for this check to stop execution of the script
if [ ! -d /etc/gdm ] && ! rpm -q gdm >/dev/null 2>&1 ; then
	exit 0
fi



if [ -e /etc/gdm/custom.conf ]
	then
		XAUDITLEVEL=$( grep -c "command=/usr/bin/Xorg -br -audit 4 -s 15" /etc/gdm/custom.conf )
		if [ $XAUDITLEVEL -eq 0	]
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
		fi

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

fi
