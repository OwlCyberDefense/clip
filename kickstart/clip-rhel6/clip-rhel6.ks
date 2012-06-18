# Copyright (C) 2012 Tresys Technology, LLC
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1) Distributed source includes this license and disclaimer,
# 2) Binary distributions must reproduce the license and disclaimer in the 
#    documentation and/or other materials provided with the distribution,
# 3) Tresys and contributors may not be used to endorse or promote products 
#    derived from this software without specific prior written permission
#
# THIS SOFTWARE IS PROVIDED BY TRESYS ``AS IS'' AND ANY EXPRESS OR IMPLIED 
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO 
# EVENT SHALL  TRESYS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND 
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# FIXME: This *must* be changed by the end-user prior to generating a build!!
rootpw neutronbass

lang en_US.UTF-8
keyboard us

#text - is broken bz 785400 anaconda abrt - No module named textw.netconfig_text
cdrom
install
timezone --utc Etc/GMT
auth --useshadow --passalgo=sha512
#network --hostname=clip --noipv6 --bootproto=static --ip=172.16.32.5 --netmask=255.255.255.0 --onboot=yes

selinux --enforcing
firewall --enabled
reboot

# DO NOT REMOVE THE FOLLOWING LINE. NON-EXISTENT WARRANTY VOID IF REMOVED.
#REPO-REPLACEMENT-PLACEHOLDER

zerombr
bootloader --location=mbr --timeout=5 --append="audit=1" --driveorder=sda --password=neutronbass
clearpart --drives=sda --all --initlabel
part /boot --size=200 --fstype ext4 --asprimary --ondisk=sda
part pv.os --size=1   --grow        --asprimary --ondisk=sda

volgroup vg00 --pesize=65536 pv.os
logvol /              --vgname=vg00 --name=root  --fstype=ext4 --size 5500 --maxsize 21000 --grow
logvol /var           --vgname=vg00 --name=var   --fstype=ext4 --size 4000 --fsoptions=defaults,nosuid --grow
logvol /home          --vgname=vg00 --name=home  --fstype=ext4 --size=1    --fsoptions=defaults,nosuid,nodev --percent=10 --grow
logvol swap           --vgname=vg00 --name=swap  --fstype=swap --recommended

logvol /var/log       --vgname=vg00 --name=log   --fstype=ext4 --size 1500 --fsoptions=defaults,nosuid,noexec,nodev --maxsize 25000 --grow
logvol /var/log/audit --vgname=vg00 --name=audit --fstype=ext4 --size 1500 --fsoptions=defaults,nosuid,noexec,nodev --maxsize 25000 --grow
#logvol /tmp           --vgname=vg00 --name=tmp   --fstype=ext4 --size 100  --fsoptions=defaults,bind,nosuid,noexec,nodev --maxsize 6000  --grow
#logvol /var/tmp       --vgname=vg00 --name=vtmp  --fstype=ext4 --size 100  --fsoptions=defaults,nosuid,noexec,nodev --maxsize 5000  --grow
logvol /tmp           --vgname=vg00 --name=tmp   --fstype=ext4 --size 100  --maxsize 6000  --grow
logvol /var/tmp       --vgname=vg00 --name=vtmp  --fstype=ext4 --size 100  --maxsize 5000  --grow

%packages --excludedocs

clip-selinux-policy
clip-selinux-policy-clip
clip-selinux-policy-mls
scap-security-guide
aqueduct
aqueduct-DISA
#aqueduct-ssg-bash
secstate

acl
aide
attr
audit
augeas
authconfig
basesystem
bash
bind-libs
bind-utils
chkconfig
coreutils
cpio
dhclient
e2fsprogs
filesystem
glibc
initscripts
iproute
iptables
iptables-ipv6
iputils
kbd
kernel
ncurses
openscap
openscap-content
openscap-utils
openswan
passwd
perl
policycoreutils
policycoreutils-newrole
policycoreutils-python
procps
puppet
clip-puppet
rootfiles
rpm
rsyslog
ruby
-selinux-policy-targeted
setup
setools-console
shadow-utils
util-linux-ng
vim-minimal
vlock
yum
-Red_Hat_Enterprise_Linux-Release_Notes-6-en-US
-abrt-addon-ccpp
-abrt-addon-kerneloops
-abrt-addon-python
-abrt-cli
-acpid
-alsa-utils
-authconfig
-b43-fwcutter
-b43-openfwwf
-blktrace
-bridge-utils
-cryptsetup-luks
-dbus
-dhclient
-dmraid
-dosfstools
-fprintd
-fprintd-pam
-hicolor-icon-theme
-kexec-tools
-man
-man-pages
-man-pages-overrides
-mdadm
-mlocate
-mtr
-nano
-ntsysv
-pinfo
-postfix
-prelink
-pm-utils
-redhat-indexhtml
-rdate
-readahead
-rhnsd
-setserial
-setuptool
-strace
-subscription-manager
-sysstat
-systemtap-runtime
-system-config-firewall-tui
-system-config-network-tui
-tcpdump
-traceroute
-vconfig
-virt-what
-wget
-yum-rhn-plugin

-aic94xx-firmware
-at
-atmel-firmware
-bfa-firmware
-ipw2100-firmware
-ipw2200-firmware
-ivtv-firmware
-iwl100-firmware
-iwl1000-firmware
-iwl3945-firmware
-iwl4965-firmware
-iwl5000-firmware
-iwl5150-firmware
-iwl6000-firmware
-iwl6000g2a-firmware
-iwl6000g2b-firmware
-iwl6050-firmware
-kernel-firmware
-libertas-usb8388-firmware
-ql2100-firmware
-ql2200-firmware
-ql23xx-firmware
-ql2400-firmware
-ql2500-firmware
-rt61pci-firmware
-rt73usb-firmware
-xorg-x11-drv-ati-firmware
-zd1211-firmware

%end

%post --log=/root/post_install.log
export PATH="/sbin:/usr/sbin:/usr/bin:/bin:/usr/local/bin"

chkconfig --del postfix
chkconfig ntpd on

# install clip refpol, there has to be a better way
semanage login -a -s user_u   __default__
semanage login -a -s sysadm_u root

semanage user -m -Rstaff_r -Rsysadm_r -Rsystem_r  root
semanage user -m -Rstaff_r -Rsysadm_r -Rsystem_r  staff_u
semanage user -m                      -Rsystem_r  system_u

#puppet -d -l /root/install.puppet.log /etc/puppet/manifests/site.pp

# iptables setup
cat >/etc/sysconfig/iptables <<EOF
*filter
:INPUT DROP [0:0]
:FORWARD DROP [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
EOF

chkconfig --add iptables
chkconfig --add ip6tables
chkconfig --level 0123456 netfs off

# scap-security-guide setup
#cat > /root/oscap.sh << EOF
#!/bin/bash
#oscap xccdf eval --profile server --results results.xml --report report.html /usr/local/scap-security-guide/content/rhel6-xccdf-scap-security-guide.xml
#EOF
#chmod u+x /root/oscap.sh

#cat > /root/oscap2.sh << EOF
#!/bin/bash
#oscap xccdf eval --profile server /usr/local/scap-security-guide/content/rhel6-xccdf-scap-security-guide.xml | sed -e "s/^M//" | grep "^R" | awk '
#/Rule ID:/, /Result:/ { printf "%s ", \$0 }
#/Result:/ { print "" }' | sed -e "s/Rule ID:[[:space:]]\+//" -e "s/ Result:[[:space:]]\+/: /"
#EOF
#chmod u+x /root/oscap2.sh

# aqueduct remediation scripts
#sysctl -p /etc/sysctl.conf
#SCRIPTDIR=/usr/local/bin/aqueduct-ssg-bash
#SCRIPTZ=$( ls $SCRIPTDIR/*.sh )
#for script in $SCRIPTZ; do
#   [ "$script" == "$SCRIPTDIR/selinux_policytype_targeted.sh" ] && continue
#   echo $script
#   $script
#done

# relabel with refpol on reboot
touch /.autorelabel

%end
