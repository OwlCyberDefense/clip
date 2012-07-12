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
#By Tummy a.k.a Vincent C. Passaro                                   #
#Vincent[.]Passaro[@]gmail[.]com                                     #
#www.vincentpassaro.com                                              #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 06-dec-2011|
#|          |   Creation            |                    |            |
#|__________|_______________________|____________________|____________|
#######################DISA INFORMATION###############################

#11.2 Verify no duplicate userIDs exist
#Description:
#Eliminate duplicate userIDs, unless a mission application cannot function without them.

#This is ok by default... So not going to add logic to fix but will ad their 
#Chatter 

echo "Verify no duplicate userIDs exist."
#dup username
x=`cut -f1 -d: /etc/passwd | sort | uniq -d | tr "\n" " "`
if [ "x$x" != "x" ]
then
echo "The following duplicate usernames found: $x"
fi
#dup uid
x=`cut -f3 -d: /etc/passwd | sort | uniq -d | tr "\n" " "`
if [ "x$x" != "x" ]
then
echo "The following duplicate uids found: $x"
fi
#dup groupname
x=`cut -f1 -d: /etc/group | sort | uniq -d | tr "\n" " "`
if [ "x$x" != "x" ]
then
echo "The following duplicate group names found: $x"
fi
#dup uid
x=`cut -f3 -d: /etc/group | sort | uniq -d | tr "\n" " "`
if [ "x$x" != "x" ]
then
echo "The following duplicate gids found: $x"
fi
echo ""