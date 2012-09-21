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
# Group ID (Vulid): V-825
# Group Title: GEN001780
# Rule ID: SV-37289r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN001780
# Rule Title: Global initialization files must contain the "mesg -n" or 
# "mesg n" commands.
#
# Vulnerability Discussion: If the "mesg -n" or "mesg n" command is not 
# placed into the system profile, messaging can be used to cause a Denial 
# of Service attack.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check global initialization files for the presence of "mesg -n" or 
# "mesg n".

# Procedure:
# grep "mesg" etc/bashrc /etc/csh.cshrc /etc/csh.login /etc/csh.logout 
# /etc/environment /etc/ksh.kshrc /etc/profile /etc/suid_profile 
# /etc/profile.d/* 

# If no global initialization files contain "mesg -n" or "mesg n", this is 
# a finding.
#
# Fix Text: 
#
# Edit /etc/profile or another global initialization script, and add the 
# "mesg -n" command.    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001780
	
# Start-Lockdown

for INITFILE in /etc/.login /etc/profile /etc/bashrc /etc/security/environ `ls /etc/profile.d/*` /etc/ksh.kshrc /etc/suid_profile /etc/csh.logout /etc/csh.login /etc/csh.cshrc
do
  if [ -e $INITFILE ]
  then
    grep 'mesg n' $INITFILE > /dev/null
    if [ $? -ne 0 ]
    then
      echo "" >> $INITFILE
      echo "#Added to meet GEN001780" >> $INITFILE
      echo "mesg n" >> $INITFILE
    fi
  fi
done
