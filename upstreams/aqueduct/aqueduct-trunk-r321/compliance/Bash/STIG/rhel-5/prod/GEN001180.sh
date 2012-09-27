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
# Group ID (Vulid): V-786
# Group Title: GEN001180
# Rule ID: SV-37194r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001180
# Rule Title: All network services daemon files must have mode 0755 or 
# less permissive.
#
# Vulnerability Discussion: Restricting permission on daemons will 
# protect them from unauthorized modification and possible system 
# compromise.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the mode of network services daemons.
# find /usr/sbin -type f -perm +022 -exec stat -c %a:%n {} \;

# This will return the octal permissions and name of all files that are 
# group or world writable.
# If any network services daemon listed is world or group writable (either 
# or both of the 2 lowest order digits contain a 2, 3 or 6), this is a 
# finding.
# Note: Network daemons not residing in these directories (such as httpd or 
# sshd) must also be checked for the correct permissions.


#
# Fix Text: 
#
# Change the mode of the network services daemon.
# chmod go-w <path>   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001180
	
# Start-Lockdown

# Note: Even though the STIG has the 0 in the special bit filed, I'm leaving
# those commented out as they can break the system.
for CURFILE in `find /usr/sbin/ ! -type l`
do
  if [ -e "$CURFILE" ]
  then
    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' $CURFILE`

    # Break the actual file octal permissions up per entity
    #FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7022)
    #if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&2)) != "0" ] || [ $(($FILEOTHER&2)) != "0" ]
    if [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&2)) != "0" ] || [ $(($FILEOTHER&2)) != "0" ]
    then
      #chmod u-s,g-ws,o-wt $CURFILE
      chmod g-w,o-w $CURFILE
    fi
  fi
done


# Note: Some SUID/SGID bits will be remove that might break some things.  Here
# is the default list from RHEL 5.7:
#-rws--x--x 1 root root 32192 Mar 11  2009 /usr/sbin/userhelper
#-rwxr-sr-x 1 root smmsp 775064 Aug 11 13:24 /usr/sbin/sendmail.sendmail
#-rwxr-sr-x 1 root lock 12080 Jan  9  2007 /usr/sbin/lockdev
#-rwsr-xr-x 1 root root 8672 Sep 19  2009 /usr/sbin/userisdnctl
#-r-s--x--- 1 root apache 14264 Oct 20 17:05 /usr/sbin/suexec
#-rwsr-xr-x 1 root root 8224 Jan  6  2007 /usr/sbin/ccreds_validate
#-rwsr-xr-x 1 root root 8848 Aug 19 11:31 /usr/sbin/usernetctl

