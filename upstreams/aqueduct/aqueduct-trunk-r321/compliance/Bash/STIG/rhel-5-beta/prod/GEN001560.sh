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
# on 14-jan-2012 to modify user check for users >= 500, fixed the dotfiles to
# be excluded and added the fix to the find. Simplified the find/fix command.
#
#  - Updated by Chris Short (chris@chrisshort.net) 
# On 17-Apr-2012 found that STIG specifies and thus this script looks for
# .bbashrc files as opposed to .bashrc files


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-915
#Group Title: Home Directories File Permissions
#Rule ID: SV-915r6_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN001560
#Rule Title: All files and directories contained in user home directories must have mode 0750 or less permissive.
#
#Vulnerability Discussion: Excessive permissions allow unauthorized access to user files.
#
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#For each user in the /etc/passwd file, check for files and directories that have a mode more permissive than 0750.
#
#Procedure:
# find /<usershomedirectory> ! -fstype nfs ! \( -name .login -o -name .cshrc -o -name .logout -o -name .profile -o -name .bash_profile -o -name .bbashrc -o -name .env -o -name .dtprofile -o -name .dispatch -o -name .emacs -o -name .exrc \) \( -perm -0001 -o -perm -0002 -o -perm -0004 -o -perm -0020 -o -perm -2000 -o -perm -4000 \) -exec ls -ld {} \;
#
#If user home directories contain files or directories more permissive than 0750, this is a finding.
#
#Fix Text: Change the mode of files and directories within user home directories to 0750.
#
#Procedure:
# chmod 0750 filename
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001560
DotFiles='( -name .cshrc
                -o -name  .login
                -o -name  .logout
                -o -name  .profile
                -o -name  .bash_profile
                -o -name  .bashrc
                -o -name  .env
                -o -name  .dtprofile
                -o -name  .dispatch
                -o -name  .emacs
                -o -name  .exrc )'

# Start Lockdown
#
#  - SLM: For the current series of home directory checks we have been looking
# at interactive users (UIDs >= 500).   Even though it doesn't specify in the
# description, we are going to stick with the same theme.  The main reason
# being that some of the system home directories are /bin and /sbin.  Removing 
# other execute bits may cause some issues.
for UserName in `awk -F':' '!/nfsnobody/{if($3 >= 500) print $1}' /etc/passwd`
do
    if [ `echo $UserName | cut -c1` != '+' ]
    then
        PwTest=`grep "^${UserName}:" /etc/passwd | cut -d: -f6`
        PwHomeDir=${PwTest:-NOVALUE}
        if [ "${PwHomeDir}" != "NOVALUE" -a "${PwHomeDir}" != " " ]
        then
            if [ -d ${PwHomeDir} ]
            then
                if [ ${PwHomeDir} = '/' ]
                then
                    echo 'WARNING:  Home directory for "'${UserName}'"' \
                    '("'${PwHomeDir}'") excluded from check.'
                else

                    find ${PwHomeDir} -xdev ! -fstype nfs  ! ${DotFiles} -perm /7027 -exec chmod o-s,g-ws,o-rwxt {} \;

                fi
            fi
        fi
    fi
done
