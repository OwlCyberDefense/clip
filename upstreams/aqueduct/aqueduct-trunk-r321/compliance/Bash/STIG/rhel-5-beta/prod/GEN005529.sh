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
#Group ID (Vulid): V-22478
#Group Title: GEN005529
#Rule ID: SV-26772r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN005529
#Rule Title: The SSH client must not send environment variables to the server or must only send those pertaining to locale.
#
#Vulnerability Discussion: Environment variables can be used to change the behavior of remote sessions and should be limited. Locale environment variables specify the language, character set, and other features that modify the operation of software to match the user's preferences.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the SSH client configuration for the SendEnv setting.
# grep -i SendEnv /etc/ssh/ssh_config | grep -v '^#'
#If any line is returned other than those permitting "LOCALE" or "LC_*" environment variables, this is a finding.
#
#Fix Text: Edit the SSH client configuration and remove or edit the SendEnv setting(s) to only accept "LOCALE" or "LC_*" environment variables.   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005529

#Start-Lockdown
if [ -e /etc/ssh/ssh_config ]
then

  # Parse through all of the Accept Env options
  for ENVVAR in `grep 'SendEnv' /etc/ssh/ssh_config | sed -e 's/^.*SendEnv //g' | tr '\n' ' '`
  do

    # If it doesn't match LANGUAGE, LANG or LC_* remove it.
    echo $ENVVAR | egrep '^LC_' > /dev/null
    if [ $? -ne 0 -a "$ENVVAR" != "LANGUAGE" -a "$ENVVAR" != "LANG" ]
    then
      sed -i -e "s/^\(.*SendEnv.*\)${ENVVAR} *\(.*\)/\1\2/g" /etc/ssh/ssh_config
    fi
  done

fi
