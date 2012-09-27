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
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 09-Feb-2012 to move from dev and add fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22477
#Group Title: GEN005528
#Rule ID: SV-26771r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN005528
#Rule Title: The SSH daemon must not accept environment variables from the client or must only accept those pertaining to locale.

#Vulnerability Discussion: Environment variables can be used to change the behavior of remote sessions and should be limited. Locale environment variables specify the language, character set, and other features that modify the operation of software to match the user's preferences.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the SSH daemon configuration for the AcceptEnv setting.
## grep -i AcceptEnv /etc/ssh/sshd_config | grep -v '^#'
#If any line is returned other than those permitting "LOCALE" or "LC_*" environment variables, this is a finding.
#
#Fix Text: Edit the SSH daemon configuration and remove or edit the AcceptEnv setting(s) to only accept "LOCALE" or "LC_*" environment variables.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005528

#Start-Lockdown

if [ -e /etc/ssh/sshd_config ]
then

  # Parse through all of the Accept Env options
  for ENVVAR in `grep 'AcceptEnv' /etc/ssh/sshd_config | sed -e 's/^AcceptEnv //g' | tr '\n' ' '`
  do

    # If it doesn't match LANGUAGE, LANG or LC_* remove it.
    echo $ENVVAR | egrep '^LC_' > /dev/null
    if [ $? -ne 0 -a "$ENVVAR" != "LANGUAGE" -a "$ENVVAR" != "LANG" ]
    then
      sed -i -e "s/^\(AcceptEnv.*\)${ENVVAR} *\(.*\)/\1\2/g" /etc/ssh/sshd_config
    fi
  done

fi

