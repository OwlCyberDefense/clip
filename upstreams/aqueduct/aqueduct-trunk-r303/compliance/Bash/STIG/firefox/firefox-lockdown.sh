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
#By Tummy a.k.a Vincent C. Passaro				     #
#Vincent[.]Passaro[@]gmail[.]com	         		     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 8-MAR-2012|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
								     
#Check if firefox has been installed 
FIREFOX64=$( find /usr/lib64/ -name all-redhat.js -print | grep firefox | wc -l  )
FIREFOX32=$( find /usr/lib/ -name all-redhat.js -print | grep firefox | wc -l )

if [ $FIREFOX64 -eq 1 ]
  then
	FIREFOX64=$( find /usr/lib64/ -name all-redhat.js -print | grep firefox )		
	GENCONFIGVAL64=$( cat $FIREFOX64 | grep 'pref("general.config.obscure_value", 0);' | wc -l ) 
	GENCONFIGNAM64=$( cat $FIREFOX64 | grep 'pref("general.config.filename", "mozilla-aqueduct-stig.cfg");' | wc -l )
	CONFIGDIR64=$( find /usr/lib64/ -name all-redhat.js -print | grep firefox | cut -d '/' -f 1-4 )
	AQUEDUCT64=$( find /usr/lib64/ -name mozilla-aqueduct-stig.cfg -print | grep firefox | wc -l )
  
  #Begin Lockdown

			if [ $GENCONFIGVAL64 -eq 0 ]
				then
					echo "//" >> $FIREFOX64
					echo "//Adding General Config Value for Aqueduct Mozilla Firefox DISA STIG Lockdown" >> $FIREFOX64
					echo "//" >> $FIREFOX64
					echo 'pref("general.config.obscure_value", 0);' >> $FIREFOX64
					echo 'pref("general.config.filename", "mozilla-aqueduct-stig.cfg");' >> $FIREFOX64
			fi
		#Now we make sure the mozilla-aqueduct.cfg file is there.  If not, we create it and set proper permission so nobody goof's with it. 
			if [ $AQUEDUCT64 -eq 0 ]
				then

					#Set perms before deployment | We do this because SVN depends on the umask settings of the user that checks out
					#Also, its safe to assume that in the silly DoD world, people will be copying Aqueduct content to / from Windowz boxes

					chown root:root mozilla-aqueduct-stig.cfg
					chmod 644 mozilla-aqueduct-stig.cfg

					cp mozilla-aqueduct-stig.cfg $CONFIGDIR64
			fi
  else					
		echo "Firefox 64 bit not installed"
fi #End the entire Firefox 64 Bit lockdown script

if [ $FIREFOX32 -eq 1 ]
  then
		FIREFOX32=$( find /usr/lib/ -name all-redhat.js -print | grep firefox )
		GENCONFIGVAL32=$( cat $FIREFOX32 | grep 'pref("general.config.obscure_value", 0);' | wc -l )
		GENCONFIGNAM32=$( cat $FIREFOX32 | grep 'pref("general.config.filename", "mozilla-aqueduct-stig.cfg");' | wc -l )
		CONFIGDIR32=$( find /usr/lib/ -name all-redhat.js -print | grep firefox | cut -d '/' -f 1-4 )
		AQUEDUCT32=$( find /usr/lib/ -name mozilla-aqueduct-stig.cfg -print | grep firefox | wc -l  )
  
			if [ $GENCONFIGVAL32 -eq 0 ]
				then
					echo "//" >> $FIREFOX32
					echo "//Adding General Config Value for Aqueduct Mozilla Firefox DISA STIG Lockdown" >> $FIREFOX32
					echo "//" >> $FIREFOX32
					echo 'pref("general.config.obscure_value", 0);' >> $FIREFOX32
					echo 'pref("general.config.filename", "mozilla-aqueduct-stig.cfg");' >> $FIREFOX32
			fi
		#Now we make sure the mozilla-aqueduct.cfg file is there.  If not, we create it and set proper permission so nobody goof's with it. 
			if [ $AQUEDUCT32 -eq 0 ]
				then

					#Set perms before deployment | We do this because SVN depends on the umask settings of the user that checks out
					#Also, its safe to assume that in the silly DoD world, people will be copying Aqueduct content to / from Windowz boxes

					chown root:root mozilla-aqueduct-stig.cfg
					chmod 644 mozilla-aqueduct-stig.cfg

					cp mozilla-aqueduct-stig.cfg $CONFIGDIR32
			fi
  else					
		echo "Firefox 32 bit not installed"

fi #End the entire Firefox 32 Bit lockdown script

