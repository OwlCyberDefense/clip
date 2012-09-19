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
# Group ID (Vulid): V-22360
# Group Title: GEN001850
# Rule ID: SV-37248r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001850
# Rule Title: Global initialization files' lists of preloaded libraries 
# must contain only absolute paths.
#
# Vulnerability Discussion: The library preload list environment variable 
# contains a list of libraries for the dynamic linker to load before 
# loading the libraries required by the binary.  If this list contains 
# paths to libraries relative to the current working directory, unintended 
# libraries may be preloaded.  This variable is formatted as a 
# space-separated list of libraries.  Paths starting with a slash (/) are 
# absolute paths.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the global initialization files' library preload list.
# grep -r LD_PRELOAD /etc/bashrc /etc/csh.cshrc /etc/csh.login 
# /etc/csh.logout /etc/environment /etc/ksh.kshrc /etc/profile 
# /etc/suid_profile /etc/profile.d/*
# This variable is formatted as a colon-separated list of paths. If there 
# is an empty entry, such as a leading or trailing colon, or two 
# consecutive colons, this is a finding. If an entry begins with a 
# character other than a slash (/) this is a relative path, this is a 
# finding.
#
# Fix Text: 
#
# Edit the global initialization file and remove the relative path entry 
# from the library preload variable.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001850
	
# Start-Lockdown

for INITFILE in /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc /etc/environment /etc/.login /etc/security/environ `ls /etc/profile.d/*` /etc/ksh.kshrc /etc/suid_profile /etc/csh.logout
do

  if [ -e $INITFILE ]
  then

    ## Check bash style settings

    # Remove leading colons
    egrep 'LD_PRELOAD=:' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/LD_PRELOAD=:/LD_PRELOAD=/g' $INITFILE
    fi

    # remove trailing colons
    egrep 'LD_PRELOAD=.*:\s*$' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/\(LD_PRELOAD=.*\):\(\s*$\)/\1\2/g' $INITFILE
    fi

    # remove trailing colons
    egrep 'LD_PRELOAD=.*:\"*\s*$' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/\(LD_PRELOAD=.*\):\(\"*\s*$\)/\1\2/g' $INITFILE
    fi

    # remove begin/end colons with no data
    egrep 'LD_PRELOAD=.*::.*' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e '/LD_PRELOAD=/s/::/:/g' $INITFILE
    fi


    # remove anything that doesn't start with a $ or /
    egrep 'LD_PRELOAD="' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then

      egrep 'LD_PRELOAD="[^$/]' $INITFILE > /dev/null
      if [ $? -eq 0 ]
      then
        sed -i -e '/LD_PRELOAD/s/="[^$/][^:]*:*/="/g' $INITFILE
      fi

    else

      # remove anything that doesn't start with a $ or /
      egrep 'LD_PRELOAD=[^$/]' $INITFILE > /dev/null
      if [ $? -eq 0 ]
      then
        sed -i -e '/LD_PRELOAD/s/=[^$/][^:]*:*/=/g' $INITFILE
      fi


    fi
    egrep 'LD_PRELOAD=.*:[^$/:][^:]*\s*' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e '/LD_PRELOAD=/s/:[^$/:][^:]*//g' $INITFILE
    fi


    ## Check csh style settings

    # Remove leading colons
    egrep 'setenv LD_PRELOAD ":' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/setenv LD_PRELOAD ":/setenv LD_PRELOAD "/g' $INITFILE
    fi

    # remove trailing colons
    egrep 'setenv LD_PRELOAD ".*:"' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/\(setenv LD_PRELOAD ".*\):\("\)/\1\2/g' $INITFILE
    fi

    # remove begin/end colons with no data
    egrep 'setenv LD_PRELOAD ".*::.*' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e '/setenv LD_PRELOAD/s/::/:/g' $INITFILE
    fi

    # remove anything that doesn't start with a $ or /
    egrep 'setenv LD_PRELOAD ".*:[^$/:][^:]*\s*' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e '/setenv LD_PRELOAD/s/:[^$/:][^:"]*//g' $INITFILE
    fi

    egrep 'setenv LD_PRELOAD "[^$/]' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e '/setenv LD_PRELOAD/s/"[^$/][^:"]*:*/"/g' $INITFILE
    fi


  fi

done

