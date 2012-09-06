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
#8.9 Restrict NFS Client Requests To Privileged Ports
#Description:
#Setting the secure parameter causes the NFS server process on the local 
#system to ignore NFS client requests that do not originate from the 
#privileged port range (ports less than 1024); and this is the default 
#behavior for RHEL5. This should not hinder normal NFS operations but 
#may block some automated NFS attacks that are run by unprivileged users.

echo "/etc/exports size is (`wc -c /etc/exports | cut -d' ' -f1`)."
  
  if [ `wc -c /etc/exports | cut -d' ' -f1` == 0 ]
    then
    echo "Ok - No changes were necessary to /etc/exports."
  else
echo "Size (for /etc/exports) is greater than 0"

perl -i.orig -pe 'next if (/^\s*#/ || /^\s*$/);
($res, @hst) = split(" ");
foreach $ent (@hst) {
undef(%set);
($optlist) = $ent =~ /\((.*?)\)/;
foreach $opt (split(/,/, $optlist)) {
$set{$opt} = 1;
}
delete($set{"insecure"});
$set{"secure"} = 1;
$ent =~ s/\(.*?\)//;
$ent .= "(" . join(",", keys(%set)) . ")";
}
$hst[0] = "(secure)" unless (@hst);
$_ = "$res\t" . join(" ", @hst) . "\n";' /etc/exports
fi

chown root:root /etc/exports
chmod 0644 /etc/exports
