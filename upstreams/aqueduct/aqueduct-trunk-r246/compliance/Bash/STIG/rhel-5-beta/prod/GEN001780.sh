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
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#
#
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 14-jan-2012 to add 'mesg n' to multiple global init files.

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-825
#Group Title: Global initialization files contain mesg -n
#Rule ID: SV-825r7_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN001780
#Rule Title: Global initialization files must contain the "mesg -n" 
#or "mesg n" commands.
#
#Vulnerability Discussion: If the "mesg -n" or "mesg n" command is 
#not placed into the system profile, messaging can be used to cause 
#a denial of service attack.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check global initialization files for the presence of "mesg -n" or "mesg n".
#
#Procedure:
# grep "mesg" /etc/.login /etc/profile /etc/bashrc /etc/environment 
#/etc/security/environ /etc/profile.d/*
#
#If no global initialization files contain "mesg -n" or "mesg n", 
#this is a finding.
#
#Fix Text: Edit /etc/profile or another global initialization script, 
#and add the "mesg -n" command.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001780

#Start-Lockdown

#   - SLM: Lets check all of the init files and add it.  Past nessus scans 
# have looked in multiple init files and showed up in the scan results if 
# it wasn't in all checked.  That being said, the nessus scans also check 
# for 'mesg -n' which doesn't work with RHEL as it needs to be 'mesg n'
#
#  - SLM: The /etc/environment should be use for environment variables
# assignments such as KEY=VALUE and isn't a script file. The 'mesg n' command
# in the /etc/environment file will cause errors.  Nessus also checks this file
# which results in a false positive.

for INITFILE in /etc/.login /etc/profile /etc/bashrc /etc/security/environ `ls /etc/profile.d/*`
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
