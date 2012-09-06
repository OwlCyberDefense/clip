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
# Group ID (Vulid): V-4087
# Group Title: GEN001940
# Rule ID: SV-37433r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001940
# Rule Title: User start-up files must not execute world-writable 
# programs.
#
# Vulnerability Discussion: If start-up files execute world-writable 
# programs, especially in unprotected directories, they could be 
# maliciously modified to become trojans that destroy user files or 
# otherwise compromise the system at the user, or higher, level.  If the 
# system is compromised at the user level, it is much easier to eventually 
# compromise the system at the root and network level.
#
# Responsibility: System Administrator
# IAControls: DCSW-1
#
# Check Content:
#
# Check local initialization files for any executed world-writable 
# programs or scripts and scripts executing from world writable directories.

# Procedure:
# For each home directory on the system make a list of files referenced 
# within any local initialization script.
# Show the mode for each file and its parent directory.

# FILES=".bashrc .bash_login .bash_logout .bash_profile .cshrc .kshrc 
# .login .logout .profile .tcshrc .env .dtprofile .dispatch .emacs .exrc";

# for HOMEDIR in `cut -d: -f6 /etc/passwd|sort|uniq`;do for INIFILE in 
# $FILES;do REFLIST=`egrep " [\"~]?/" ${HOMEDIR}/${INIFILE} 2>null|sed 
# "s/.*\([~ \"]\/[\.0-9A-Za-z_\/\-]*\).*/\1/"`;for REFFILE in $REFLIST;do 
# FULLREF=`echo $REFFILE|sed "s:\~:${HOMEDIR}:g"|sed "s:^\s*::g"`;dirname 
# $FULLREF|xargs stat -c "dir:%a:%n";stat -c "file:%a:%n" 
# $FULLREF;done;done;done|sort|uniq

# This command outputs a list of files and directories and their associated 
# access modes.

# If any local initialization file executes a world-writable program or 
# script or a script from a world-writable directory, this is a finding.
#
# Fix Text: 
#
# Remove the world-writable permission of files referenced by local 
# initialization scripts, or remove the references to these files in the 
# local initialization scripts.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001940
	
# Start-Lockdown

# Turns out there shoudn't be any world writables files by default so the list
# should be small.  For each file in the list lets check the user dot files for
# an entry.  If the entry exists fix it.
for WWFILE in $(find / -xdev -path /proc -prune -o -perm -002 -type f | grep -v '/proc')
do
  COMMAND=`basename $WWFILE`
  for USERNAME in root `awk -F ':' '{if ($3 >= 500 && $3 != 65534)print $1}' /etc/passwd`
  do
    USERHDIR=`egrep "^${USERNAME}" /etc/passwd | awk -F ':' '{print $6}'`
    for DOTFILE in .cshrc .login .logout .profile .bash_profile .bashrc .env .dtprofile .dispatch .emacs .exrc .ldaprc .vimrc .muttrc .kshrc .tcshrc
    do
      if [ -e "${USERHDIR}/${DOTFILE}" ]
      then

        # found the command in a dot file.  Fix it
        grep -r "${COMMAND}" "${USERHDIR}/${DOTFILE}" > /dev/null
        if [ $? == 0 ]
        then
          chmod o-w $WWFILE
        fi

      fi
    done
  done

done
