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
# on 30-dec-2011 to include an ACL check before running setfacl.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22322
#Group Title: GEN001365
#Rule ID: SV-26398r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001365
#Rule Title: The /etc/resolv.conf file must not have an extended ACL.
#
#Vulnerability Discussion: The resolv.conf (or equivalent) file configures 
#the system's DNS resolver. DNS is used to resolve host names to IP 
#addresses. If DNS configuration is modified maliciously, host name 
#resolution may fail or return incorrect information. DNS may be used 
#by a variety of system security functions such as time synchronization, 
#centralized authentication, and remote system logging.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that /etc/resolv.conf has no extended ACL.
# ls -l /etc/resolv.conf
#If the permissions include a '+', the file has an extended ACL, 
#this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /etc/resolv.conf    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001365

#Start-Lockdown

if [ -a "/etc/resolv.conf" ]
  then
    ACLOUT=`getfacl --skip-base /etc/resolv.conf 2>/dev/null`;
    if [ "$ACLOUT" != "" ]
      then
      setfacl --remove-all /etc/resolv.conf
    fi
  else
    echo "------------------------------" > $PDI-error.log
    date >> $PDI-error.log
    echo " " >> $PDI-error.log
    echo "/etc/resolv.conf does not exist." >> $PDI-error.log
    echo "Could not remove ACL from /etc/resolv.conf" >> $PDI-error.log
    echo "------------------------------" >> $PDI-error.log
fi
