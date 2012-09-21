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

if [ -a /etc/php.ini ]
  then
    sed -i 's/register_globals = On/register_globals = Off/g' /etc/php.ini
    sed -i 's/register_globals = on/register_globals = Off/g' /etc/php.ini
    sed -i 's/magic_quotes_gpc = On/magic_quotes_gpc = Off/g' /etc/php.ini
    sed -i 's/magic_quotes_gpc = on/magic_quotes_gpc = Off/g' /etc/php.ini
    sed -i 's/magic_quotes_runtime = Off/magic_quotes_runtime = On/g' /etc/php.ini
    sed -i 's/magic_quotes_runtime = off/magic_quotes_runtime = On/g' /etc/php.ini
    sed -i 's/magic_quotes_sybase = Off/magic_quotes_sybase = On/g' /etc/php.ini
    sed -i 's/magic_quotes_sybase = off/magic_quotes_sybase = On/g' /etc/php.ini
    sed -i 's/allow_url_fopen = On/allow_url_fopen = Off/g' /etc/php.ini
    sed -i 's/allow_url_fopen = on/allow_url_fopen = Off/g' /etc/php.ini
    sed -i 's/expose_php = On/expose_php = Off/g' /etc/php.ini
    sed -i 's/expose_php = on/expose_php = Off/g' /etc/php.ini
fi

