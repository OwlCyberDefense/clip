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

SCRIPTZ=$( ls -lah |grep sh |grep -iv aqueduct | awk '{print $9}')
for file in $SCRIPTZ
  do
    echo -e "\e[00;32mEXECUTING $file\e[00m"
 #Lodud Version (lots of errors and misc stuff)  Should be used for testing
    ./$file
 #Quiet.....  For Production type operations
    #./$file &> /dev/null
done
