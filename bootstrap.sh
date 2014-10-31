#!/bin/bash -ue
# Copyright (C) 2013 Quark Security, Inc
# Copyright (C) 2013 Cubic Corporation
#
# Authors: Spencer Shimko <spencer@quarksecurity.com>
/bin/echo -e "Creating an environment for building software and ISOs can be a little 
complicated.  This script will automate some of those tasks.  Keep in mind that 
this script isn't exhaustive; depending on a variety of factors you may have to
install some additional packages.\n\nYour user *must* have sudo access for any 
of this to work.

If you are using RHEL enter 'r'.
If you are using CentOS 'c'."
read distro
/bin/echo -e "CLIP uses yum repositories for building packages and generting ISOs.
These must be directories of packages, not RHN channels.  E.g. a directory with
a bunch of packages and a repodata/ sub-directory.  If you do not have yum 
repositories like this available CLIP will not work!  Please see Help-FAQ.txt!\n\n"

tmpfile=''
while :; do
	/bin/echo -e "
Enter a name for this yum repo.  Just leave empty if you are done adding, or don't wish to change, the repositories.\n"
	read name
	[ x"$name" == "x" ] && break
	/bin/echo -e "
Enter a fully qualified path for this yum repo.  Just leave empty if you are done adding, or don't wish to change, the repositories.\n"
	read path
	[ x"$path" == "x" ] && break

	if [ x"$tmpfile" == "x" ]; then
		tmpfile=`/bin/mktemp`
		/bin/cat CONFIG_REPOS | /bin/sed -e 's/^\([a-zA-Z0-9].*\)$/#\1/' > $tmpfile
	fi
	/bin/echo -e "# INSERTED BY BOOTSTRAP.SH\n$name = $path" >> $tmpfile
done

if [ x"$tmpfile" != "x" ]; then
	mv $tmpfile CONFIG_REPOS
fi

arch=`rpm --eval %_host_cpu`
# TODO Using the yum variable $releasever evaluates to 7Server which is incorrect.
# For now, this variable needs to be incremented during each major RHEL release until we
# find a better way to get the release version to set for EPEL
releasever="7"

# always have the latest epel rpm
if ! rpm -q epel-release > /dev/null; then
	echo "***epel rpm not installed - install and enable repo"
	# if the epel.repo file does not exist write it and enable the repo
	if [ ! -f /etc/yum.repos.d/epel.repo ]; then
		echo "
[epel]
name=Bootstrap EPEL
mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$arch
failovermethod=priority
enabled=1
gpgcheck=0
		" | sudo tee --append /etc/yum.repos.d/epel.repo
		sudo yum --enablerepo=epel -y install epel-release
	fi
fi

/bin/rpm -q "python-kid" >/dev/null || /usr/bin/sudo /usr/bin/yum install -y python-kid || if [ "$?" != "0" ]; then
	/bin/echo "WARNING: we couldn't find a package we need to install on the build 
host.  This is usually the result of using RHEL without a subscription to RHN. Try this:
1. Grab a CentOS ISO.
2. Mount it.
3. Add it as a yum repo:
        http://docs.oracle.com/cd/E37670_01/E37355/html/ol_create_repo.html
4. Re-run this script and pick CentOS.
5. Refer to the same path in the CONFIG_REPOS file.
"
fi

PACKAGES="mock pigz createrepo repoview rpm-build lorax make"
sudo yum install -y $PACKAGES

/usr/bin/sudo /usr/sbin/usermod -aG mock `id -un`

/bin/echo -e "This is embarassing but due to a bug (bz #861281) you must do builds in permissive.\nhttps://bugzilla.redhat.com/show_bug.cgi?id=861281"
/bin/echo "So this is a heads-up we're going to configure your system to run in permissive mode.  Sorry!"
/bin/echo "You can bail by pressing ctrl-c or hit enter to continue."
read user_input
/usr/bin/sudo /usr/sbin/setenforce 0
/usr/bin/sudo /bin/sed -i -e 's/^SELINUX=.*/SELINUX=permissive/' /etc/selinux/config

# Fourth, roll pungi
if ! rpm -q pungi >/dev/null; then
	/usr/bin/make pungi-rpm
	pushd . > /dev/null  
	cd repos/clip-repo
	/usr/bin/sudo /usr/bin/yum localinstall -y pungi*
	popd > /dev/null
fi

if ! rpm -q "livecd-tools-13.4.4-99.el7.noarch" > /dev/null; then 
	if rpm -q "livecd-tools" > /dev/null; then
		/bin/echo "You have livecd-tools installed, but not our version. Our version contains 
fixes for generating live media.  We will compile our version and replace your 
version free of charge.
Press the any key to continue or ctrl-c to exit.
"
		read user_input
		/usr/bin/sudo /usr/bin/yum remove livecd-tools 2>/dev/null || true
		/usr/bin/sudo /usr/bin/yum remove python-imgcreate 2>/dev/null || true
	else 
		/usr/bin/make livecd-tools-rpm
		/usr/bin/sudo /usr/bin/yum localinstall -y livecd-tools* python-imgcreate*
	fi
	/usr/bin/make livecd-tools-rpm
	pushd . > /dev/null
	cd repos/clip-repo
	/usr/bin/sudo /usr/bin/yum localinstall -y livecd-tools* and python-imgcreate*
	popd > /dev/null
fi

/bin/echo -e "Basic bootstrapping of build host is complete.\nPress 'enter' to run 'make clip-rhel7-iso' or ctrl-c to quit."
read user_input
/usr/bin/make clip-rhel7-iso
