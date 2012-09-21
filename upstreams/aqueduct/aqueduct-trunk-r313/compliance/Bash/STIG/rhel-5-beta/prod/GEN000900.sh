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
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com) on 
# 02-jan-2012 to fix the logging conditional. Added a check for root dir's 
# existance before running the mkdir.

								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-774
#Group Title: The root account home directory has not been chang
#Rule ID: SV-774r8_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN000900
#Rule Title: The root user's home directory must not be the root 
#directory (/).
#
#Vulnerability Discussion: Changing the root home directory to something 
#other than / and assigning it a 0700 protection makes it more difficult 
#for intruders to manipulate the system by reading the files that root 
#places in its default directory. It also gives root the same discretionary 
#access control for root's home directory as for the other plain user 
#home directories.
#
#Responsibility: System Administrator
#IAControls: ECCD-1, ECCD-2
#
#Check Content: 
#Determine if root is assigned a home directory other than / by listing 
#its home directory.
#
#Procedure:
# grep "^root" /etc/passwd | awk -F":" '{print $6}'
#
#If the root user home directory is /, this is a finding.
#
#Fix Text: The root home directory should be something other than / 
#(such as /roothome).
#
#Procedure:
# mkdir /rootdir
# chown root /rootdir
# chgrp root /rootdir
# chmod 700 /rootdir
# cp -r /.??* /rootdir/.

#Then, edit the passwd file and change the root home directory 
#to /rootdir. The cp -r /.??* command copies all files and subdirectories 
#of file names that begin with "." into the new root directory, which 
#preserves the previous root environment. Ensure you are in the "/" 
#directory when executing the "cp" command.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000900
BADROOTDIR=`grep "^root" /etc/passwd | awk -F":" '{print $6}' | grep "^/$" | wc -l`

#Start-Lockdown

if [ $BADROOTDIR -ge 1 ]
  then
    if [ ! -e "/root" ]
    then
      mkdir -p /root
    fi
    chown root:root /root
    chmod 700 /root
    sed -i 's/root:\/:/root:\/root:/g' /etc/passwd
fi


