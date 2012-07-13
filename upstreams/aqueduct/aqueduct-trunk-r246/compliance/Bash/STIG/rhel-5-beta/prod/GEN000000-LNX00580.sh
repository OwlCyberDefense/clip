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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 28-dec-2011 to make it comment out the existing entry in /etc/inittab
# and not add a new one if missing.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-4342
#Group Title: Ctrl-Alt-Delete Sequence
#Rule ID: SV-4342r5_rule
#Severity: CAT I
#Rule Version (STIG-ID): GEN000000-LNX00580
#Rule Title: The x86 CTRL-ALT-DELETE key sequence must be disabled.
#
#Vulnerability Discussion: Undesirable reboots can occur if the 
#CTRL-ALT-DELETE key sequence is not disabled. Such reboots may 
#cause a loss of data or loss of access to critical information.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Verify that Linux systems have disabled the <CTRL><ALT><DELETE> key sequence by performing:
#
# grep ctrlaltdel /etc/inittab
#
#If the line returned is not commented out then this is a finding.
#
#
#Fix Text: Ensure that the CTRL-ALT-DELETE key sequence has been disabled. 
#If necessary, comment out the following line in the /etc/inittab file:
#ca::ctrlaltdel:/sbin/shutdown -t3 -r now   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN000000-LNX00580

#Start-Lockdown
CTRLALTDEL=`grep -c "^ca::ctrlaltdel" /etc/inittab`

#Start-Lockdown
if [ $CTRLALTDEL -ne 0 ]
  then
    sed -i -e 's/ca::ctrlaltdel/#Commented out to meet GEN000000-LNX00580\n#ca::ctrlaltdel/g' /etc/inittab
fi
