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
PDI=GEN002825
UNAME=$( uname -m )
BIT64='x86_64'
AUDITFILE='/etc/audit/audit.rules'
#Start-Lockdown
AUDIT1="-w /bin/login -p x"
AUDIT2="-w /bin/su"
AUDIT3="-a exit,always -S mknod -S pipe -S mkdir -S creat -F success=0"
AUDIT4="-a exit,always -S open -F success=0"
AUDIT5="-a exit,always -F arch=b32 -S truncate -S ftruncate -F success=0"
AUDIT6="-a exit,always -F arch=b64 -S truncate -S ftruncate -F success=0"
AUDIT7="-a exit,always -S unlink -S rmdir -S rename -F success!=0"
AUDIT8="-w /bin/rm"
AUDIT9="-a exit,always -F arch=b32 -S chmod -S fchmod -S chown -S fchown -S lchown"
AUDIT10="-a exit,always -F arch=b64 -S chmod -S fchmod -S chown -S fchown -S lchown"
AUDIT11="-a exit,always -S chroot -S mount -S umount -S umount2"
AUDIT12="-w /usr/sbin/pwck"
AUDIT13="-a exit,always -S adjtimex -S settimeofday -S kill"
AUDIT14="-w /bin/chgrp"
AUDIT15="-w /usr/bin/newgrp"
AUDIT16="-w /usr/sbin/groupadd"
AUDIT17="-w /usr/sbin/groupmod"
AUDIT18="-w /usr/sbin/groupdel"
AUDIT19="-w /usr/sbin/useradd"
AUDIT20="-w /usr/sbin/userdel"
AUDIT21="-w /usr/sbin/usermod"
AUDIT22="-w /usr/bin/chage"
AUDIT23="-a exit,always -S reboot -S init_module -S delete_module"
AUDIT24="-w /usr/bin/setfacl"
AUDIT25="-w /usr/bin/chacl"
AUDIT26="-a exit,always -S chmod -S fchmod -S link -S symlink"


AUDITCOUNT1=$( grep -c -e "-w /bin/login -p x"  $AUDITFILE )
AUDITCOUNT2=$( grep -c -e  "-w /bin/su" $AUDITFILE )
AUDITCOUNT3=$( grep -c -e  "-a exit,always -S mknod -S pipe -S mkdir -S creat -F success=0" $AUDITFILE )
AUDITCOUNT4=$( grep -c -e  "-a exit,always -S open -F success=0" $AUDITFILE )
AUDITCOUNT5=$( grep -c -e  "-a exit,always -F arch=b32 -S truncate -S ftruncate -F success=0" $AUDITFILE )
AUDITCOUNT6=$( grep -c -e  "-a exit,always -F arch=b64 -S truncate -S ftruncate -F success=0" $AUDITFILE )
AUDITCOUNT7=$( grep -c -e  "-a exit,always -S unlink -S rmdir -S rename -F success!=0"$AUDITFILE )
AUDITCOUNT8=$( grep -c -e  "-w /bin/rm" $AUDITFILE )
AUDITCOUNT9=$( grep -c -e  "-a exit,always -F arch=b32 -S chmod -S fchmod -S chown -S fchown -S lchown" $AUDITFILE )
AUDITCOUNT10=$( grep -c -e  "-a exit,always -F arch=b64 -S chmod -S fchmod -S chown -S fchown -S lchown" $AUDITFILE )
AUDITCOUNT11=$( grep -c -e  "-a exit,always -S chroot -S mount -S umount -S umount2" $AUDITFILE )
AUDITCOUNT12=$( grep -c -e  "-w /usr/sbin/pwck" $AUDITFILE )
AUDITCOUNT13=$( grep -c -e  "-a exit,always -S adjtimex -S settimeofday -S kill" $AUDITFILE )
AUDITCOUNT14=$( grep -c -e  "-w /bin/chgrp" $AUDITFILE )
AUDITCOUNT15=$( grep -c -e  "-w /usr/bin/newgrp" $AUDITFILE )
AUDITCOUNT16=$( grep -c -e  "-w /usr/sbin/groupadd" $AUDITFILE )
AUDITCOUNT17=$( grep -c -e  "-w /usr/sbin/groupmod" $AUDITFILE )
AUDITCOUNT18=$( grep -c -e  "-w /usr/sbin/groupdel" $AUDITFILE )
AUDITCOUNT19=$( grep -c -e  "-w /usr/sbin/useradd"$AUDITFILE )
AUDITCOUNT20=$( grep -c -e  "-w /usr/sbin/userdel" $AUDITFILE )
AUDITCOUNT21=$( grep -c -e  "-w /usr/sbin/usermod" $AUDITFILE )
AUDITCOUNT22=$( grep -c -e  "-w /usr/bin/chage" $AUDITFILE )
AUDITCOUNT23=$( grep -c -e  "-a exit,always -S reboot -S init_module -S delete_module" $AUDITFILE )
AUDITCOUNT24=$( grep -c -e  "-w /usr/bin/setfacl" $AUDITFILE )
AUDITCOUNT25=$( grep -c -e  "-w /usr/bin/chacl" $AUDITFILE )
AUDITCOUNT26=$( grep -c -e  "-a exit,always -S chmod -S fchmod -S link -S symlink"$AUDITFILE )


#Start-Lockdown

if [ $UNAME == $BIT64 ]
  then
        if [ $AUDITCOUNT6 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT6 >> $AUDITFILE
            service auditd restart
        fi

        if [ $AUDITCOUNT10 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT10 >> $AUDITFILE
            service auditd restart
        fi
fi
       if [ $AUDITCOUNT1 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT3 >> $AUDITFILE
            service auditd restart
        fi
        if [ $AUDITCOUNT2 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT2 >> $AUDITFILE
            service auditd restart
        fi
        if [ $AUDITCOUNT3 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT3 >> $AUDITFILE
            service auditd restart
        fi

        if [ $AUDITCOUNT4 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT4 >> $AUDITFILE
            service auditd restart
        fi

        if [ $AUDITCOUNT5 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT5 >> $AUDITFILE
            service auditd restart
        fi
        if [ $AUDITCOUNT7 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT7 >> $AUDITFILE
            service auditd restart
        fi
        if [ $AUDITCOUNT8 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT8 >> $AUDITFILE
            service auditd restart
        fi
        if [ $AUDITCOUNT9 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT9 >> $AUDITFILE
            service auditd restart
        fi
        if [ $AUDITCOUNT11 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT11 >> $AUDITFILE
            service auditd restart
        fi

        if [ $AUDITCOUNT12 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT12 >> $AUDITFILE
            service auditd restart
        fi

        if [ $AUDITCOUNT13 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT13 >> $AUDITFILE
            service auditd restart
        fi

        if [ $AUDITCOUNT14 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT14 >> $AUDITFILE
            service auditd restart
        fi
        if [ $AUDITCOUNT15 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT15 >> $AUDITFILE
            service auditd restart
        fi

        if [ $AUDITCOUNT16 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT16 >> $AUDITFILE
            service auditd restart
        fi

        if [ $AUDITCOUNT17 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT17 >> $AUDITFILE
            service auditd restart
        fi

        if [ $AUDITCOUNT18 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT18 >> $AUDITFILE
            service auditd restart
        fi


        if [ $AUDITCOUNT19 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT19 >> $AUDITFILE
            service auditd restart
        fi


        if [ $AUDITCOUNT20 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT20 >> $AUDITFILE
            service auditd restart
        fi


        if [ $AUDITCOUNT21 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT21 >> $AUDITFILE
            service auditd restart
        fi


        if [ $AUDITCOUNT22 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT22 >> $AUDITFILE
            service auditd restart
        fi


        if [ $AUDITCOUNT23 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT23 >> $AUDITFILE
            service auditd restart
        fi


        if [ $AUDITCOUNT24 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT24 >> $AUDITFILE
            service auditd restart
        fi


        if [ $AUDITCOUNT25 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT25 >> $AUDITFILE
            service auditd restart
        fi


        if [ $AUDITCOUNT26 -eq 0 ]
          then
            echo " " >> $AUDITFILE
            echo "#############PCI AUDIT#############" >> $AUDITFILE
            echo $AUDIT26 >> $AUDITFILE
            service auditd restart
        fi


fi