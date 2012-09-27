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
# Group ID (Vulid): V-900
# Group Title: GEN001460
# Rule ID: SV-37379r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN001460
# Rule Title: All interactive user home directories defined in the 
# /etc/passwd file must exist.
#
# Vulnerability Discussion: If a user has a home directory defined that 
# does not exist, the user may be given the / directory, by default, as the 
# current working directory upon logon.  This could create a Denial of 
# Service because the user would not be able to perform useful tasks in 
# this location.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Use pwck to verify assigned home directories exist.
# pwck
# If any user's assigned home directory does not exist, this is a finding.


#
# Fix Text: 
#
# If a user has no home directory, determine why. If possible, delete 
# accounts without a home directory. If the account is valid, then create 
# the home directory using the appropriate system administration utility or 
# manually.
# For instance: mkdir directoryname; copy the skeleton files into the 
# directory; chown accountname for the new directory and the skeleton 
# files. Document all changes.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001460
	
# Start-Lockdown

# Using a direct /etc/passwd check, because pwck output differs in
# different versions of RHEL and its output is all over the place.  Previous
# version of this check didn't take into account that pwck also gives output
# for uid and gid issues which broke things.

# Loop through the passwd file.  Only print username, uid, gid and homedir. The
# gecos field tends to have spaces which will break the for loop as I currently
# have it.
for CURLINE in `awk -F ':' '{print $1":"$3":"$4":"$6}' /etc/passwd`
do

   # Break the line into an array
   STR_ARRAY=(`echo $CURLINE | tr ":" "\n"`)

   # Assign array elements to variables to make script easier to read
   CURUSER=${STR_ARRAY[0]}
   CURUID=${STR_ARRAY[1]}
   CURGID=${STR_ARRAY[2]}
   CURHOMEDIR=${STR_ARRAY[3]}

   # If and only if the home directory doesn't exist, create it and modify the
   # permissions on it. If the home directory didn't exist then it should be 
   # safe to use chown and chmod with the -R option. 
   if [ ! -d "$CURHOMEDIR" ]
   then
     # make sure the base directory exists
     mkdir -p `dirname $CURHOMEDIR`
     cp -r /etc/skel $CURHOMEDIR
     chown -R ${CURUID}:${CURGID} $CURHOMEDIR
     chmod -R 750 $CURHOMEDIR
   fi

done

