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
#By Tummy a.k.a Vincent C. Passaro							                     #
#Vincent[.]Passaro[@]gmail[.]com																     #
#www.vincentpassaro.com																					     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 29-Feb-2012|
#|	  	    |   Creation	          |                    |            |
#|__________|_______________________|____________________|____________|
#######################PCI INFORMATION###############################
#Risk =
#######################PCI INFORMATION###############################

#Global Variables#

ISINSTALLED=$( rpm -qa|grep -ci vsftpd )

#Start-Lockdown

#Check if vsftpd is installed

if [ $ISINSTALLED -eq 1 ]
  then
    if [ ! -f /etc/vsftpd/ftpusers ]
      then
        touch /etc/vsftpd/ftpusers
    fi
fi


if [ -e /etc/xinetd.d/gssftp ]
then
    if [ ! -f /etc/ftpusers ]
    then
        touch /etc/ftpusers
    fi
fi

# Lets assume that the system accounts shouldn't be able to log in by default.
# And leave it up to the users to add more and check as needed.
for SYSACCT in `awk -F':' '{if($3 < 500) print $1}' /etc/passwd`
do
  if [ -e /etc/vsftpd/ftpusers ]
  then
    grep "^$SYSACCT" /etc/vsftpd/ftpusers > /dev/null
    if [ $? -ne 0 ]
    then
      echo $SYSACCT >> /etc/vsftpd/ftpusers
    fi
  fi

  if [ -e /etc/vsftpd.ftpusers ]
  then
    grep "^$SYSACCT" /etc/vsftpd.ftpusers > /dev/null
    if [ $? -ne 0 ]
    then
      echo $SYSACCT >> /etc/vsftpd.ftpusers
    fi
  fi

  if [ -e /etc/ftpusers ]
  then
    grep "^$SYSACCT" /etc/ftpusers > /dev/null
    if [ $? -ne 0 ]
    then
      echo $SYSACCT >> /etc/ftpusers
    fi
  fi

done