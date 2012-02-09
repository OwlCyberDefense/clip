#
# Copyright (C) 2011-2012 Tresys Technology, LLC
#
#REPO-REPLACEMENT-PLACEHOLDER

# disable firstboot (setup agent)
firstboot --disable

# The "install" command tells the system to install a fresh system
# rather than upgrade an existing system.  You must specify the type
# of installation in the form of:  cdrom, harddrive, nfs, url (ftp
# http installation).  The "install" command and the installation
# method command must be on separate lines. Examples: 
# url --url http://<server>/<dir>
#     --url ftp://<username>:<password>@<server>/<dir>   
#           Passwd is in CLEAR with ftp!!!  Not to be used.
# harddrive --partition=hda2--dir=/path/to/install-tree
# nfs --server=nfsserver.example.com --dir=/path/to/install-tree
install

# Perform the kickstart install in Text Mode.  Installs are
# performed in graphical mode by default.
text

# Defaults to a CD based install - disable if using URL or someother media
# Use the network option if installing from a remote installation tree.
#cdrom

# Configure network information for the system.  The "network" 
# option configures networking information for installations from an
# installation tree on a remote server via NFS, FTP, or HTTP. DHCP 
# uses a DHCP server to get the network configuration information.
#network --bootproto dhcp

# The "lang" command sets the language to use during installation.
lang en_US

# The "langsupport" to install on the system.  The --default switch
# must be used if more than one language is specified.
#langsupport --default en_US en_US

# The "keyboard" command is required to set the system keyboard type.
keyboard us

# The "mouse" command is required to configure the mouse type. 
# Giving no options will attempt to automatically detect the mouse.
#mouse

##### WARNING: THIS WILL ERASE YOUR SYSTEM #####

# Specifies how the GRUB bootloader should be installed
#
# ICE driver-specific memory addressing
#
# Set a password to prevent any non-standard boot options (to be changed after install)
#
bootloader --location mbr --password 123)(*qweASD

# Set the authentication options for the system.
# Similar to the authconfig command.
auth --passalgo=sha512 --enableshadow

# Set the defaultroot password.
rootpw 123)(*qweASD

# Set the timezone
timezone --utc GMT

# Enable selinux
selinux --enforcing

# Enable the firewall
firewall --enabled

# Install Packages.  This is site specific.
%packages 
####################################################
# added explicitly to provide local
# yum repository which has no @base group defined
####################################################
MAKEDEV
SysVinit
acl
acpid
amtu
#at
attr
audit
audit-libs
audit-libs-python
authconfig
basesystem
bash
bc
-beecrypt
binutils
bzip2
bzip2-libs
redhat-release
redhat-release-notes
checkpolicy
chkconfig
clip-puppet
-conman
coreutils
cpio
cpuspeed
cracklib
cracklib-dicts
crontabs
cryptsetup-luks
curl
cyrus-sasl
cyrus-sasl-lib
cyrus-sasl-plain
-db4
#dbus
#dbus-glib
#dbus-python
device-mapper
device-mapper-event
device-mapper-multipath
dhclient
diffutils
dmidecode
-dmraid
dosfstools
e2fsprogs
e2fsprogs-libs
ed
eject
elfutils-libelf
epel-release
ethtool
expat
-fbset
filesystem
findutils
gawk
gdbm
glib2
glibc
glibc-common
-glibc-devel
-glibc-headers
gnupg
gnutls
grep
groff
gzip
#hal
-hesiod
hwdata
info
initscripts
iproute
ipsec-tools
iptables
iptstate
iputils
irqbalance
kbd
-kernel-PAE
kernel-rt
-kernel-headers
keyutils-libs
-kpartx
-krb5-libs
-krb5-workstation
-ksh
less
libacl
libaio
libattr
libcap
libdrm
libgcc
libgcrypt
libgomp
libgpg-error
libidn
libpcap
libselinux
libselinux-python
libsemanage
libsepol
libstdc++
libsysfs
libtermcap
libusb
libuser
libutempter
libvolume_id
libxml2-python
logrotate
lsof
lvm2
m2crypto
mailcap
-mailx
make
mcstrans
mgetty
microcode_ctl
mingetty
-mkbootdisk
mkinitrd
mktemp
module-init-tools
mtools
mtr
-nano
-nash
-nc
ncurses
net-tools
-newt
-nscd
nspr
-nss
-nss-tools
-nss_db
-nss_ldap
ntp
ntsysv
#oddjob
#oddjob-libs
-openldap
openssh
openssh-clients
-openssh-server
openssl
pam
pam_ccreds
pam_krb5
pam_passwdqc
pam_pkcs11
pam_tally3
parted
passwd
patch
pax
pciutils
pcmciautils
pcre
-perl
-perl-String-CRC32
pkinit-nss
#pm-utils
policycoreutils
policycoreutils-newrole
popt
procmail
procps
#psacct
psmisc
python
python-argparse
python-hashlib
readahead
readline
rhpl
rmt
rng-utils
rpm
rpm-libs
rpm-python
-rsync
rsyslog
ruby
sed
selinux-policy
selinux-policy-tos
#selinux-policy-clip
#sendmail
setarch
setup
setuptool
shadow-utils
slang
specspo
sqlite
-stunnel
sudo
symlinks
syslinux
sysstat
system-config-securitylevel-tui
tar
-tcp_wrappers
tcsh
termcap
time
tmpwatch
traceroute
tunctl
tzdata
udev
unzip
usbutils
usermode
util-linux
vconfig
vim-minimal
vixie-cron
vlock
-wget
which
words
zip
zlib

#####################################
# remove to keep things minimal/clean
#####################################
-anacron
-aide
-at
-iscsi-initiator-utils
-sendmail
-psacct
# the following are all deps of hal/dbus
-dbus
-dbus-libs
-hal
-oddjob
-oddjob-libs
-pm-utils
-dbus-glib
-dbus-python
-microcode_ctl
-man
-ppp
-rp-pppoe
-mlocate
-logwatch
-conman
-sysstat

#####################################
# remove sysreport because it was in 
# conflict with a replacement package
#####################################
-sysreport

#####################################
# remove firstboot
# because ks directive didn't work
# to stop firstboot from appearing
#####################################
-firstboot

#####################################
# Remove tcpdump per STIG gen003865 #
#####################################
-tcpdump

#####################################
# Remove Packages for PL4 compliance#
#####################################
-xdelta
-nmap
-emacspeak
-byacc
-gimp-help
-splint
-perl-Crypt-SSLeay
-units
-perl-XML-Grove
-perl-XML-LibXML-Common
-perl-XML-SAX
-perl-XML-Twig
-valgrind
-perl-XML-Dumper
-blas
-lapack
-java-1.4.2-gcj-compat
-isdn4k-utils
-vnc
-vnc-server
#e2fsprogs
#kernel-smp
-tog-pegasus
-tog-pegasus-devel
-xchat
-vino
-bluez-utils
-bluez-utils-cups
-bluez-hcidump
-bluez-gnome
-yum-updatesd
-wpa_supplicant
-ypbind
-NetworkManager
-setools
-telnet
-wireless-tools
#@ office
#@ admin-tools
#@ editors
#@ system-tools
#@ gnome-desktop
#@ dialup
#@ base-x
#@ printing
#@ server-cfg
#@ graphical-internet
#kernel
-python-ldap
-system-config-httpd
-psgml
-emacs-leim
-gimp-data-extras
-xcdroast
-perl-XML-LibXML
-gimp-print-plugin
-xsane-gimp
-gimp
#lvm2
-zsh
#net-snmp-utils
#grub
-texinfo
-perl-LDAP
-oprofile
-emacs
#system-config-printer-gui
-doxygen
-tux
-indent
-cdparanoia
-gcc-java
#openoffice.org-i18n
#openoffice.org-libs
#openoffice.org
#firefox
-xsane
-ctags
-cscope
-sane-frontends
-perl-XML-Parser
-php-mysql
-rcs
-perl-XML-NamespaceSupport
#get rid of rlogin
-rsh
-irda-utils
-lm_sensors
-portmap
-nfs-utils
-autofs
-finger
-tftp
-avahi

vlock

#%end
#%pre


%post

echo "Running Puppet"
export PATH="/usr/bin:/bin:/usr/local/bin"
puppet -d -l /root/install.log.puppet /etc/puppet/manifests/site.pp
echo "Done running Puppet"


# TODO: Move the lgather fixes into puppet modules
# lgather fix: ssh_config must have 'Protocol 2' underneath Host *
sed -i '/^[[:space:]]*Host \*[[:space:]]*/ s/Host \*/Host * \nProtocol 2/' /etc/ssh/ssh_config

# lgather fix: /etc/motd doesn't contain an authorized usage only banner
echo "Authorized Users Only" > /etc/motd

# lgather fix: harden TCP/IP stack
sed -i '/max_syn_backlog/ {d}' /etc/sysctl.conf
echo "net.ipv4.tcp_max_syn_backlog = 4096" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.rp_filter = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.secure_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.secure_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.send_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.send_redirects=0" >> /etc/sysctl.conf

# lgather fix: log authpriv events
echo "authpriv.*     /var/log/secure" >> /etc/syslog.conf

# set coresize to 0 for all
echo "*               soft    core            0" >> /etc/security/limits.conf

# fix error: rhosts authentication not deactivated (don't need files so delete)
rm /etc/pam.d/kshell
rm /etc/pam.d/ekshell

# This Will setup the auditd.conf file to rotate the logs correctly.
cat <<-EOF > /etc/audit/auditd.conf
  log_file = /var/log/audit/audit.log
  log_format = RAW
  priority_boost = 3
  flush = INCREMENTAL
  freq = 20
  num_logs = 2
  #dispatcher = /sbin/audispd
  max_log_file = 20
  max_log_file_action = ROTATE
  space_left = 45
  space_left_action = SYSLOG
  action_mail_acct = root
  admin_space_left = 5
  admin_space_left_action = HALT
  disk_full_action = HALT
  disk_error_action = HALT
EOF

# This Will setup the audit.rules file to only capture usefull information.
cat <<-EOF > /etc/audit/audit.rules
  -D
  -e 1
  -b 8192
  -f 2
  -w /etc/passwd -p wa
  -w /etc/shadow -p wa
  -w /etc/group -p wa
  -w /etc/pam.d -p wa
  -w /var/run/utmp -p wa
  -w /var/log/messages -p wa
  -w /var/log/audit/audit.log -p wa
  -w /var/log/audit/audit[1-4].log -p wa
  -w /etc/audit/auditd.conf -p wa
  -w /etc/audit/audit.rules -p wa
  -w /etc/selinux/config -p wa
  -w /etc/login.defs -p wa
  -w /etc/rc.d/init.d -p wa
  -w /etc/inittab -p wa
  -w /etc/ssh/sshd_config -p wa
  -a exit,always -S mkdir -F auid!=0
  -a exit,always -S chmod -S fchmod -F auid!=0
  -a exit,always -S chown -S fchown -S lchown -F auid!=0
  -a exit,always -S setxattr -S lsetxattr -S fsetxattr
  -a exit,always -S removexattr -S lremovexattr -S fremovexattr
EOF

# Set timezone to GMT
/bin/rm -f /etc/localtime
ln -s /usr/share/zoneinfo/GMT /etc/localtime

# trap sigs during init
sed -i -e '2i/bin/stty intr ^-' /etc/rc.sysinit
sed -i -e '3itrap "" INT QUIT TSTP' /etc/rc.sysinit
# disable ctrl keycode so users cant ctrl-c out of init scripts
# for ps2 keyboards
sed -i -e '4isetkeycodes 1d   56 2>/dev/null' /etc/rc.sysinit
sed -i -e '5isetkeycodes e01d 56 2>/dev/null' /etc/rc.sysinit
fi

# disable interactive boot prompt
sed -i -e 's/^PROMPT=.*/PROMPT=no/' /etc/sysconfig/init

# Disable magic sysrq and do it early
sed -i -e '7iecho 0 > /proc/sys/kernel/sysrq' /etc/rc.sysinit

# fix error: netfs rc script is not deactivated
/sbin/chkconfig netfs off

# disable ip6tables as it throws errors since we prevent the ipv6 pf module from loading
/sbin/chkconfig ip6tables off

# disable iptables as it throws errors on bootup due to a kernel module not being loaded
/sbin/chkconfig iptables off

# disable cron like daemons and let the tsc decide to start them
/sbin/chkconfig crond off

# disable sysstat let tsc start them
/sbin/chkconfig sysstat off

# turn off SSH daemon as default
/sbin/chkconfig sshd off

# turn off ntpd at default
/sbin/chkconfig ntpd off

/sbin/chkconfig readahead_early off
/sbin/chkconfig network off
/sbin/chkconfig cpuspeed off
/sbin/chkconfig irqbalance off
/sbin/chkconfig acpid off
/sbin/chkconfig rawdevices off

# dont run restorecond or mcstransd on these types of solutions
/sbin/chkconfig restorecond off
/sbin/chkconfig mcstrans off

# disable lvm monitor service which needs extraneous selinux policy (lvm policy)
/sbin/chkconfig lvm2-monitor off

# Remove nash and lvm.static to prevent rc.sysinit from traversing certain code paths that require additional privileges on raw devices
rm /sbin/lvm.static
rm /sbin/nash

# disable ipv6
echo "alias net_pf_10 off" >> /etc/modprobe.conf
echo "alias ipv6 off" >> /etc/modprobe.conf

# we dont really want these packages installed but they are required earlier during the iso build process so force their removal now
rpm -e iscsi-initiator-utils -e mkinitrd --nodeps

# Set the hostname - this isnt owned by a package so doing it from our %post in a spec file wont work
sed -i -e 's/^\s*HOSTNAME=.*/HOSTNAME=clip/' /etc/sysconfig/network

# SRS: leave this restorecon as the last line to ensure files created in the ks %post get the proper label
/sbin/restorecon -e /proc -e /sys -e /selinux -F -R /

#%end
#END OF KICKSTART FILE POST SETTINGS
