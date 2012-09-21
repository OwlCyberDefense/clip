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
#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4088
#Group Title: Local Initialization files mesg -y
#Rule ID: SV-4088r7_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN001960
#Rule Title: User start-up files must not contain the "mesg -y" or 
#"mesg y" command.
#
#Vulnerability Discussion: The "mesg -y" or "mesg y" command turns 
#on terminal messaging. On systems that do not default to "mesg -n", 
#the system profile (or equivalent) provides it. If the user changes 
#this setting, write access may be provided to the terminal screen 
#which could disrupt processing or cause enough confusion to result 
#in damage to sensitive files. Educate users about the danger of having 
#terminal messaging set on.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#If local initialization files contain the "mesg -y" or "mesg y" 
#command, this is a finding.
#
#Procedure:
# cut -d: -f6 /etc/passwd |xargs -n1 -IDIR find DIR -name ".*" -type f 
#-maxdepth 1 -exec grep -H "mesg" {} \;
#
#
#Fix Text: Edit the local initialization file(s) and remove the 
#"mesg -y" command.   
#######################DISA INFORMATION###############################

#AGAIN DISA's satement is bad.   It checks the .bash_history file.. Its the history file, can't really change that!  Duh!  Some unskilled tester is going to fail a system for that! 
#Global Variables#
PDI=GEN001960
MESGFILES=$( cut -d: -f6 /etc/passwd |xargs -n1 -IDIR find DIR -name ".*" -type f -maxdepth 1 -exec egrep -H '(mesg y|mesg -y)' {} \; | grep -v .bash_history | cut -d ":" -f 1 )

#Start-Lockdown

for line in $MESGFILES
  do
    #echo $line
    sed -i 's/mesg y/mesg n/g' $line
    sed -i 's/mesg -y/mesg -n/g' $line
done

