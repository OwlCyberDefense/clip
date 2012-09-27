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
# 1 May 2012 / Lee Kinser / lkinser@redhat.com:  corrected erroneous 
# null redirect

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-11983
#Group Title: Global Initialization Files Group Ownership
#Rule ID: SV-12484r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001760
#Rule Title: All global initialization files must be group-owned by root,
#sys, bin, other, system, or the system default.
#
#Vulnerability Discussion: Global initialization files are used to configure 
#the user's shell environment upon login. Malicious modification of these files 
#could compromise accounts upon logon. Failure to give ownership of sensitive 
#files or utilities to root or bin provides the designated owner and unauthorized 
#users with the potential to access sensitive information or change the system 
#configuration which could weaken the system's security posture.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of global initialization files.
#
#Procedure:
# ls -lL /etc/.login /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc 
#/etc/environment /etc/security/environ /etc/profile.d/*
#or:
# ls -lL /etc/.login /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc 
#/etc/environment /etc/security/environ /etc/profile.d/* 2>null|sed "s/^[^\/]*//"|
#xargs stat -L -c %G:%n|egrep -v "^(root|sys|bin|other):"
#will show you only the group and filename of files not owned by one of the 
#approved groups.
#
#If any global initialization file is not group-owned by root, sys, bin, 
#other, system, or the system default, this is a finding.
#
#Fix Text: Change the group ownership of the global initialization file(s) 
#with incorrect group ownership.
#
#Procedure:
# chgrp root <global initialization file>
#or:
# ls -lL /etc/.login /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc 
#/etc/environment /etc/security/environ /etc/profile.d/* 2>null|sed "s/^[^\/]*//"|
#xargs stat -L -c %G:%n|egrep -v "^(root|sys|bin|other):"|cut -d: -f2|xargs chgrp root
#will set the group of all files not currently owned by an approved group to root.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001760
BADGLOBALFILE=$( ls -lL /etc/.login /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc /etc/environment /etc/security/environ /etc/profile.d/* 2>/dev/null|sed "s/^[^\/]*//"|xargs stat -L -c %G:%n|egrep -v "^(root|sys|bin|other):" | cut -d ":" -f 2 )
#Start-Lockdown


if [ -n $BADGLOBALFILE ];
  then
    for file in $BADGLOBALFILE
      do
        chgrp root $file
  done
fi

