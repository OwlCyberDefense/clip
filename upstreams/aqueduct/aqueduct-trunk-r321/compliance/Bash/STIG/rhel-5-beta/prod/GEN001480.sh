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
#Group ID (Vulid): V-901
#Group Title: Home Directories Permissions
#Rule ID: SV-901r8_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001480
#Rule Title: All user home directories must have mode 0750 or less 
#permissive.
#
#Vulnerability Discussion: Excessive permissions on home directories 
#allow unauthorized access to user files.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the home directory mode of each user in /etc/passwd.
#
#Procedure:
# cut -d: -f6 /etc/passwd|sort|uniq|xargs -n1 ls -ld
#
#If a user home directory's mode is more permissive than 0750, this is a 
#finding.
#
#Note: Application directories are allowed and may need 0755 permissions 
#(or greater) for correct operation.
#
#Fix Text: Change the mode of user home directories to 0750 or less 
#permissive.
#
#Procedure (example):
# chmod 0750 <home directory>
#
#Note: Application directories are allowed and may need 0755 permissions 
#(or greater) for correct operation.   _ 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001480
#HOMEDIRS=$(cut -d: -f6 /etc/passwd|sort|uniq|xargs -n1 ls -ld | grep home | awk '{print $9}')
USERACCT=$(egrep -v "^\+|^#|^root:|^daemon:|^ident:|^bin:|^sys:|^adm:|^smtp:|^uucp:|^nuucp:|^listen:|^lpd:|^lp:|^ingres:|^apache:|^oracle:|^oracle7:|^oracle8:|^oracle9:|^informix:|^news:|^nobody:|^nobody4:|^noaccess:|^sybase:|^tivoli:|^mqm:|^www:|^ftp:|^tftp:|^hpdb:|^sshd:|^invscout:|^gccs:|^secman:|^sysadmin:|^install:|^staff:|^COE:|^predmail:|^snmp:|^smmsp:|^sm:|^share:|^BIF:|^GCCS:|^JDISS:|^SA:|^SSO:|^SM:|^ftp:|^gccsrv:|^gtnsmint:|^irc:|^Imadmin:|^netadmin:|^halt:|^mail:|^games:|^rpm:|^vcsa:|^nscd:|^rpc:|^rpcuser:|^mailnull:|^pcap:|^xfs:|^ntp:|^gdm:|^sync:|^shutdown:|^halt:|^operator:|^gopher:|^nfsnobody:|^dbus:|^haldaemon:|^netdump:|^webalizer:|^pvm:|^mysql:|^mailman:|^dovecot:|^cyrus:|^amanda:|^pegasus:|^HPSMH:|^hpsmh:|^webadmind:|^webadmin:|^webservd:|^avahi:|^beagleidx:|^hsqldb:|^postfix:|^svctag:|^postgres:|^ids:|^IDS:|^distcache:|^DISTCACHE:|^named:|^canna:|^wnn:|^fax:|^quagga:|^htt" /etc/passwd | cut -d":" -f1)
#Start-Lockdown

#for dir in $HOMEDIRS
#  do
#    chmod 750 $dir
#one
Answer=0
Char1=""
UserName=""
UserDir=""

for UserName in ${USERACCT}
do
    UserDir=`grep "^${UserName}:" /etc/passwd | cut -d':' -f6`
    if [ "${UserDir}X" != "X" -a ${UserDir} != '/' ] # Is HD defined?
    then
        if [ -d "${UserDir}" ]
        then
            PERM=`ls -lLd ${UserDir} |cut -c6,8,9,10`
            if [ ${PERM} != "----" ]
            then
                Answer=1  # Its greater than 750
#                ls -dLl ${UserDir} | tr -s ' ' 
				chmod 750 ${UserDir}
            fi
        fi # It doesn't exist, but G051 detects that too.!
    fi  # Not in PW file
done

