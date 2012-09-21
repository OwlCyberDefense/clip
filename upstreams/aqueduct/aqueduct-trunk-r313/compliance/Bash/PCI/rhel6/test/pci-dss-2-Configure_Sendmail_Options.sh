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
#|    1.0   |   Initial Script      | Vincent C. Passaro | 17-Dec-2011|
#|	  	    |   Creation	          |                    |            |
#|__________|_______________________|____________________|____________|
#######################PCI INFORMATION###############################
#Risk =
#######################PCI INFORMATION###############################

#Global Variables#
MAILOGLEVEL=$( grep LogLevel /etc/mail/sendmail.cf | cut -d '=' -f 2)
MAILCHECK=$(cat /etc/mail/sendmail.cf | egrep "^O" | egrep "SmtpGreetingMessage=$j" | egrep "$v/$Z" | wc -l )
NOEXPN=$( grep -v "^#" /etc/mail/sendmail.cf |grep -ci noexpn )
BOGHELO=$( grep -c "#O AllowBogusHELO=False" /etc/mail/sendmail.cf
BOGHELO2=$( grep -c "O AllowBogusHELO=False" /etc/mail/sendmail.cf
#Start-Lockdown

if [ $MAILOGLEVEL -lt 9 ]
  then
    sed -i "s/O LogLevel=[0-9]/O LogLevel=9/g" /etc/mail/sendmail.cf
fi

if [ $MAILCHECK -eq 1 ]
  then
  	sed -i '/SmtpGreetingMessage/ c\
  	O SmtpGreetingMessage= Mail Server Ready ; $b' /etc/mail/sendmail.cf
fi

if [ $NOEXPN -eq 0 ]
  then
    sed -i '/.*O PrivacyOptions.*/s/$/,noexpn/' /etc/mail/sendmail.cf
fi

if [ $BOGHELO -eq 1 ] 
  then
  	sed -i 's/#O AllowBogusHELO=False/O AllowBogusHELO=False/g' /etc/mail/sendmail.cf
fi

if [ $BOGHELO2 -eq 0 ]
  then
	 echo "#Added for PCI Compliance >> /etc/mail/sendmail.cf
   echo "O AllowBogusHELO=False" >> /etc/mail/sendmail.cf
fi

#Remove the entire line containing the ForwardPath line and replace with the proper
sed -i "/ForwardPath=/ c\ForwardPath=/dev/null" /etc/mail/sendmail.cf


