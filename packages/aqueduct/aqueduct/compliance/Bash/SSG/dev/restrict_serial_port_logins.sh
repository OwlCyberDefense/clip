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
#Boston, MA  02110-1301, USA

#!/bin/bash -u
set -e

# If multiple lines exist default to console
TTYCOUNT=`/bin/cat /etc/securetty | /usr/bin/wc -l`
if [ $TTYCOUNT -gt 1 ]
then
  /bin/echo tty1 > /etc/securetty
else
  # Check the value of the single entry and if its not console or tty1 then fix
  CURTTY=`/bin/cat /etc/securetty`
  if [ "$CURTTY" != "console" -a "$CURTTY" != "tty1" ]
  then
    /bin/echo tty1 > /etc/securetty
  fi
fi
