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
#|    1.0   |   Initial Script      | Vincent C. Passaro | 17-Dec-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#######################PCI INFORMATION###############################
#Risk = High
#######################PCI INFORMATION###############################

#Global Variables#


#Start-Lockdown

if [ -a /etc/samba/smb.conf ]
  then
    sed -i 's/[[:blank:]]security[[:blank:]]=[[:blank:]]user/security = user/g' /etc/samba/smb.conf
    sed -i 's/encrypt[[:blank:]]passwords = no/encrypt passwords = yes/g' /etc/samba/smb.conf
    sed -i 's|smb[[:blank:]]passwd[[:blank:]]file[[:blank:]]=|smb passwd file = /etc/samba/passwd|g' /etc/samba/smb.conf
    sed -i 's/[[:blank:]]guest[[:blank:]]ok[[:blank:]]=[[:blank:]]yes/guest ok = no/g' /etc/samba/smb.conf
    sed -i 's/client[[:blank:]]lanman[[:blank:]]auth[[:blank:]]=[[:blank:]]yes/client lanman auth = no/g' /etc/samba/smb.conf
    sed -i 's/client[[:blank:]]ntlmv2[[:blank:]]auth[[:blank:]]=[[:blank:]]no/client ntlmv2 auth = yes/g' /etc/samba/smb.conf
    sed -i 's|.*\(smb passwd file = \).*|\1/etc/samba/passwd|' <<< $'smb passwd file = a\n# smb passwd file = b' /etc/samba/smb.conf
    sed -i 's/server[[:blank:]]signing[[:blank:]]=[[:blank:]].*/server signing = mandatory/g' /etc/samba/smb.conf
    sed -i 's/client[[:blank:]]signing[[:blank:]]=[[:blank:]].*/server signing = mandatory/g' /etc/samba/smb.conf
fi

 smb passwd file = /etc/samba/passwd                                                                                 |  --------------------------------------------------------------------------------------------------------------------
  server signing = mandatory                                                                                          |  --------------------------------------------------------------------------------------------------------------------
  encrypt passwords = yes                                                                                             |  --------------------------------------------------------------------------------------------------------------------
  client signing = mandatory                                                                                          |  --------------------------------------------------------------------------------------------------------------------
  guest ok = no                                                                                                       |  --------------------------------------------------------------------------------------------------------------------
  client ntlmv2 auth = yes                                                                                            |  --------------------------------------------------------------------------------------------------------------------
  client lanman auth = no    
