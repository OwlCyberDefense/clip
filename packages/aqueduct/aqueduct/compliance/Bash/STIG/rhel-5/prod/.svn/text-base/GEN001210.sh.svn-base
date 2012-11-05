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
# Group ID (Vulid): V-22314
# Group Title: GEN001210
# Rule ID: SV-37210r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001210
# Rule Title: All system command files must not have extended ACLs.
#
# Vulnerability Discussion: Restricting permissions will protect system 
# command files from unauthorized modification.  System command files 
# include files present in directories used by the operating system for 
# storing default system executables and files present in directories 
# included in the system's default executable search paths.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check all system command files have no extended ACLs.
# ls -lL /etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin
# If the permissions include a '+', the file has an extended ACL. If the 
# file has an extended ACL and it has not been documented with the IAO, 
# this is a finding.


#
# Fix Text: 
#
# Remove the extended ACL from the file.
# setfacl --remove-all [file with extended ACL]     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001210
	
# Start-Lockdown

for CHKDIR in /etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin
do

  if [ -d "$CHKDIR" ]
  then
    for FILENAME in `find $CHKDIR ! -type l`
    do

      if [ -e "$FILENAME" ]
      then
        ACLOUT=`getfacl --skip-base $FILENAME 2>/dev/null`;
        if [ "$ACLOUT" != "" ]
        then
          setfacl --remove-all $FILENAME
        fi
      fi

    done  # End "for FILENAME ..." loop

  fi  # End "if [ -d $CHKDIR..." conditional

done  # End "for CHKDIR ..." for loop


