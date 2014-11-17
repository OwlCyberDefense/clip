#!/bin/bash -ue
# Copyright (C) 2013 Quark Security, Inc
# Copyright (C) 2013 Cubic Corporation
#
# Authors: Spencer Shimko <spencer@quarksecurity.com>

check_and_create_repo_dir ()
{
	repo_name=$1
	repo_path=`sed -rn "s/^$repo_name = (.*)/\\1/p" CONFIG_REPOS`

	if [ ! -d $repo_path ]; then
		/bin/echo "$repo_name repo directory: $repo_path does not exist. Creating the directory."
		/bin/mkdir -p $repo_path
	fi

	/bin/echo $repo_path
}

rsync_and_createrepo ()
{
	repo_path=$1
	usage="y - update the directory with RPMs from a provided path\n\
q - abort the bootstrap process\n\
? - print help\n"

	if [ -d $repo_path/repodata ]; then
		return
	fi

	/bin/echo "Repodata is missing in $repo_path. Running createrepo."

	while :; do
		/bin/echo "Would you like to update your RPM directory with the latest RPMs [y, q, ?]: "
		read user_input
		if [ x"${user_input,,}" == x"y" ]; then
			break
		elif [ x"${user_input,,}" == x"q" ]; then
			exit
		elif [ x"${user_input,,}" == x"?" ]; then
			/bin/echo -e $usage
		else
			/bin/echo -e $usage
		fi
	done

	while :; do
		/bin/echo -e "Please provide a full path where to rsync RPMs from.\n\
If you enter 'rhel', we will try to find, mount, and copy RPMs from your CD/DVD drive\n"
		read user_input
		[ x"$user_input" == "x" ] && break

		if [ x"${user_input,,}" == x"rhel" ]; then
			tmpdir=`/bin/mktemp -d`
			sudo /usr/bin/mount /dev/sr0 $tmpdir
			/usr/bin/rsync --progress $tmpdir/Packages/* $repo_path/
			sudo /usr/bin/umount $tmpdir
			/bin/rm -rf $tmpdir
		else
			/usr/bin/rsync --progress $user_input $repo_path/
		fi

		break
	done

	/usr/bin/createrepo -d $repo_path/
}

prompt_to_enter_repo_path ()
{
    local originalname=${1-}
    local originalpath=${2-}
    if [ -z $originalpath ]; then
            /bin/echo -e "
There is no default path set for the $originalname repo.  You must provide a path for the $originalname repo or the script will
exit immediately."
            /bin/echo -e "
Enter a fully qualified path for the $originalname repo.\n"
            read path
            if [ x"$path" == "x" ]; then
                /bin/echo -e"
No default path exists for the $originalname repo and none provided - Exiting"
                exit
            else
                tmpfile=`/bin/mktemp`
                /bin/sed -r "s/^($originalname.*)$/#\1/" CONFIG_REPOS > $tmpfile
                /bin/echo "$originalname = $path" >> $tmpfile
                /bin/mv $tmpfile CONFIG_REPOS
            fi
    else
            /bin/echo -e "
Enter a fully qualified path for the $originalname repo.  If you do not enter a path then the default path
will be used in CONFIG_REPOS.  The default path for the $originalname yum repo is $originalpath\n"
            /bin/echo -e "
Enter a fully qualified path for the [ $originalname ] repo [ default: $originalpath ]\n"
            read path
            if [ ! x"$path" == "x" ]; then
                tmpfile=`/bin/mktemp`
                /bin/sed -r "s/^($originalname.*)$/#\1/" CONFIG_REPOS > $tmpfile
                /bin/echo "$originalname = $path" >> $tmpfile
                /bin/mv $tmpfile CONFIG_REPOS
            fi
    fi

}

check_and_build_rpm ()
{
	name=$1
	version=$2

	/usr/bin/rpm -q $name | /usr/bin/grep -q $version && LATEST_INSTALLED=1 || LATEST_INSTALLED=0
	if [ $LATEST_INSTALLED -eq 0 ]; then
		/bin/echo "need to roll $name"
		/usr/bin/make $name-rpm
		pushd . > /dev/null
		cd repos/clip-repo
		/usr/bin/sudo /usr/bin/yum localinstall -y $name*
		popd > /dev/null
	fi
}

/bin/echo "Checking if registered with RHN. Will attempt to register if we are not current."
/usr/bin/sudo /usr/bin/subscription-manager status | grep -q "Current" || /usr/bin/sudo /usr/bin/subscription-manager --auto-attach register

PACKAGES="mock pigz createrepo repoview rpm-build make"
/usr/bin/sudo /usr/bin/yum install -y $PACKAGES

/bin/echo -e "Creating an environment for building software and ISOs can be a little 
complicated.  This script will automate some of those tasks.  Keep in mind that 
this script isn't exhaustive; depending on a variety of factors you may have to
install some additional packages.\n\nYour user *must* have sudo access for any 
of this to work.\n\n"

/bin/echo -e "CLIP uses yum repositories for building packages and generting ISOs.
These must be directories of packages, not RHN channels.  E.g. a directory with
a bunch of packages and a repodata/ sub-directory.  If you do not have yum 
repositories like this available CLIP will not work!  Please see Help-FAQ.txt!\n\n"

# get the name/path for any existing yum repos from CONFIG_REPO
rhelreponame=rhel
rhelrepopath=`/bin/sed -rn 's/^rhel = (.*)/\1/p' CONFIG_REPOS`
optreponame=opt
optrepopath=`/bin/sed -rn 's/^opt = (.*)/\1/p' CONFIG_REPOS`

# prompt user for rhel/opt path
prompt_to_enter_repo_path $rhelreponame $rhelrepopath
prompt_to_enter_repo_path $optreponame $optrepopath

# prompt the user to add additional yum repos if necessary
/bin/echo -e "
Adding additional yum repos if necessary"
while :; do
	/bin/echo -e "
Enter a name for this yum repo.  Just leave empty if you are done adding, or don't wish to change, the repositories.\n"
	read name
	[ x"$name" == "x" ] && break
	/bin/echo -e "
Enter a fully qualified path for this yum repo.  Just leave empty if you are done adding, or don't wish to change, the repositories.\n"
    read path
    [ x"$path" == "x" ] && break
    /bin/echo -e "# INSERTED BY BOOTSTRAP.SH\n$name = $path" >> CONFIG_REPOS
done

rhelrepopath=$(check_and_create_repo_dir "rhel")
optrepopath=$(check_and_create_repo_dir "opt")

rsync_and_createrepo $rhelrepopath

/bin/echo "Checking if RHEL optional repo is enabled..."
sudo /bin/yum repolist enabled | /usr/bin/grep -q rhel-7-server-optional-rpms && OPT_SUBSCRIBED=1 || OPT_SUBSCRIBED=0
if [ $OPT_SUBSCRIBED -eq 0 ]; then
	/bin/echo "RHEL optional channel is disabled...enabling"
	sudo /usr/bin/subscription-manager repos --enable=rhel-7-server-optional-rpms
else
	/bin/echo "RHEL optional channel is already enabled"
fi
# download the required rpms from the rhel optional channel
OPT_PACKAGES="anaconda-dracut at-spi tigervnc-server-module bitmap-fangsongti-fonts"
sudo /bin/yumdownloader --destdir $optrepopath $OPT_PACKAGES
/usr/bin/createrepo -d $optrepopath

arch=`rpm --eval %_host_cpu`
# TODO Using the yum variable $releasever evaluates to 7Server which is incorrect.
# For now, this variable needs to be incremented during each major RHEL release until we
# find a better way to get the release version to set for EPEL
releasever="7"

# always have the latest epel rpm
if ! rpm -q epel-release > /dev/null; then
	/bin/echo "***epel rpm not installed - install and enable repo"
	# if the epel.repo file does not exist write it and enable the repo
	if [ ! -f /etc/yum.repos.d/epel.repo ]; then
		/bin/echo "
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

/usr/bin/sudo /usr/sbin/usermod -aG mock `id -un`

if [ x"`cat /sys/fs/selinux/enforce`" == "x1" ]; then
	/bin/echo -e "This is embarassing but due to a bug (bz #861281) you must do builds in permissive.\nhttps://bugzilla.redhat.com/show_bug.cgi?id=861281"
	/bin/echo "So this is a heads-up we're going to configure your system to run in permissive mode.  Sorry!"
	/bin/echo "You can bail by pressing ctrl-c or hit enter to continue."
	read user_input
	/usr/bin/sudo /usr/sbin/setenforce 0
	/usr/bin/sudo /bin/sed -i -e 's/^SELINUX=.*/SELINUX=permissive/' /etc/selinux/config
fi

# Roll lorax
check_and_build_rpm "lorax" "lorax-19.6.45-1.el7"

# Roll pungi
check_and_build_rpm "pungi" "pungi-2.13-3.el7"

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
