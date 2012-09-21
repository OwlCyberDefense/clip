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
# Group ID (Vulid): V-907
# Group Title: GEN001600
# Rule ID: SV-37202r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001600
# Rule Title: Run control scripts' executable search paths must contain 
# only absolute paths.
#
# Vulnerability Discussion: The executable search path (typically the 
# PATH environment variable) contains a list of directories for the shell 
# to search to find executables.  If this path includes the current working 
# directory or other relative paths, executables in these directories may 
# be executed instead of system commands.  This variable is formatted as a 
# colon-separated list of directories.  If there is an empty entry, such as 
# a leading or trailing colon, or two consecutive colons, this is 
# interpreted as the current working directory.  Paths starting with a 
# slash (/) are absolute paths.
#
# Responsibility: System Administrator
# IAControls: ECCD-1, ECCD-2
#
# Check Content:
#
# Verify run control scripts' library search paths.
# grep -r PATH /etc/rc* /etc/init.d
# This variable is formatted as a colon-separated list of directories. If 
# there is an empty entry, such as a leading or trailing colon, or two 
# consecutive colons, this is a finding. If an entry begins with a 
# character other than a slash (/), this is a relative path, this is a 
# finding.


#
# Fix Text: 
#
# Edit the run control script and remove the relative path entry from the 
# executable search path variable.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001600
	
# Start-Lockdown

for INITFILE in `find /etc/rc.d/ -type f`
do

  if [ -e $INITFILE ]
  then

    ## Check bash style settings

    # Remove leading colons
    egrep '[^_]*PATH=:' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/[^_]*PATH=:/PATH=/g' $INITFILE
    fi

    # remove trailing colons
    egrep '[^_]*PATH=.*:\"*\s*$' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/\([^_]*PATH=.*\):\(\"*\s*$\)/\1\2/g' $INITFILE
    fi

    # remove begin/end colons with no data
    egrep '[^_]*PATH=.*::.*' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e '/[^_]*PATH=/s/::/:/g' $INITFILE
    fi

    # remove anything that doesn't start with a $ or /
    egrep '[^_]*PATH="' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then 
    
      egrep '[^_]*PATH="[^$/]' $INITFILE > /dev/null
      if [ $? -eq 0 ]
      then
        sed -i -e '/[^_]*PATH/s/="[^$/][^:]*:*/="/g' $INITFILE
      fi
    
    else

      # remove anything that doesn't start with a $ or /
      egrep '[^_]*PATH=[^$/]' $INITFILE > /dev/null
      if [ $? -eq 0 ]
      then
        sed -i -e '/[^_]*PATH/s/=[^$/][^:]*:*/=/g' $INITFILE
      fi

    
    fi

    egrep '[^_]*PATH=.*:[^$/:][^:]*\s*' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then 
      sed -i -e '/[^_]*PATH=/s/:[^$/:][^:]*//g' $INITFILE
    fi



    ## Check csh style settings

    # Remove leading colons
    egrep 'setenv PATH ":' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/setenv PATH ":/setenv PATH "/g' $INITFILE
    fi

    # remove trailing colons
    egrep 'setenv PATH ".*:"' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/\(setenv PATH ".*\):\("\)/\1\2/g' $INITFILE
    fi

    # remove begin/end colons with no data
    egrep 'setenv PATH ".*::.*' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e '/setenv PATH/s/::/:/g' $INITFILE
    fi

    # remove anything that doesn't start with a $ or /
    egrep 'setenv PATH ".*:[^$/:][^:]*\s*' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e '/setenv PATH/s/:[^$/:][^:"]*//g' $INITFILE
    fi

    egrep 'setenv PATH "[^$/]' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e '/setenv PATH/s/"[^$/][^:"]*:*/"/g' $INITFILE
    fi


  fi

done

