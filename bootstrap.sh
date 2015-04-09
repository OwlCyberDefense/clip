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
		/usr/bin/sudo /bin/mkdir -p $repo_path
	fi
	if [ ! -r $repo_path ] || [ ! -x $repo_path ]; then
		/bin/echo "$repo_path does not have proper permissions to continue. Please change the permissions on the directory and any parent directories and try again."
		exit
	fi
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
		/bin/echo -e "Please provide a full path where to rsync RPMs from.\n
If you enter 'rhel', we will try to find, mount, and copy RPMs from your CD/DVD drive\n
Please ensure your RHEL DVD is inserted into the disk drive if you select 'rhel'\n"
		read user_input
		[ x"$user_input" == "x" ] && break

		if [ x"${user_input,,}" == x"rhel" ]; then
			tmpdir=`/bin/mktemp -d`
			/usr/bin/sudo /usr/bin/mount /dev/sr0 $tmpdir
			/usr/bin/rsync --progress $tmpdir/Packages/* $repo_path/
			/usr/bin/sudo /usr/bin/umount $tmpdir
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
There is no default path set for the [ $originalname ] repo.  You must provide a path for the [ $originalname ] repo to be created on your system
or the script will exit immediately. For example: [ /home/`whoami`/$originalname/ ]"
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

/bin/echo -e "Creating an environment for building software and ISOs can be a little 
complicated.  This script will automate some of those tasks.  Keep in mind that 
this script isn't exhaustive; depending on a variety of factors you may have to
install some additional packages.\n\nYour user *must* have sudo access for any 
of this to work.\n\n"

/bin/echo -e "CLIP uses yum repositories for building packages and generting ISOs.
These must be directories of packages, not RHN channels.  E.g. a directory with
a bunch of packages and a repodata/ sub-directory.  If you do not have yum 
repositories like this available CLIP will not work!  Please see Help-FAQ.txt!\n\n"

/bin/echo "Checking if $USER is in the sudoers file"
/usr/bin/sudo -l -U $USER | grep -q "User $USER is not allowed to run sudo" && /usr/sbin/sudoers adduser $USER sudo

/bin/echo "Checking if registered with RHN. We will attempt to register if we are not current. Please enter your RHN credentials if prompted."
/usr/bin/sudo /usr/bin/subscription-manager status | grep -q "Current" || /usr/bin/sudo /usr/bin/subscription-manager --auto-attach register


arch=`rpm --eval %_host_cpu`
# TODO Using the yum variable $releasever evaluates to 7Server which is incorrect.
# For now, this variable needs to be incremented during each major RHEL release until we
# find a better way to get the release version to set for EPEL
releasever="7"

# always have the latest epel rpm
/bin/echo "Checking if epel is installed and updating to the latest version if our version is older"
/bin/echo "
[epel]
name=Bootstrap EPEL
mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$arch
failovermethod=priority
enabled=1
gpgcheck=0
" | /usr/bin/sudo tee --append /etc/yum.repos.d/epel.repo
/usr/bin/sudo yum --enablerepo=epel -y install epel-release

PACKAGES="mock pigz createrepo repoview rpm-build make python-kid"
/usr/bin/sudo /usr/bin/yum install -y $PACKAGES

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
Enter a name for this yum repo.  Just leave empty if you are done adding, or don't wish to change the repositories.\n"
	read name
	[ x"$name" == "x" ] && break
	/bin/echo -e "
Enter a fully qualified path for this yum repo.  Just leave empty if you are done adding, or don't wish to change, the repositories.\n"
    read path
    [ x"$path" == "x" ] && break
    /bin/echo -e "# INSERTED BY BOOTSTRAP.SH\n$name = $path" >> CONFIG_REPOS
done

check_and_create_repo_dir "rhel"
check_and_create_repo_dir "opt"

# Refresh repo variables
rhelrepopath=`/bin/sed -rn 's/^rhel = (.*)/\1/p' CONFIG_REPOS`
optrepopath=`/bin/sed -rn 's/^opt = (.*)/\1/p' CONFIG_REPOS`

rsync_and_createrepo $rhelrepopath

/bin/echo "Checking if RHEL optional repo is enabled..."
/usr/bin/sudo /bin/yum repolist enabled | /usr/bin/grep -q rhel-7-server-optional-rpms && OPT_SUBSCRIBED=1 || OPT_SUBSCRIBED=0
if [ $OPT_SUBSCRIBED -eq 0 ]; then
	/bin/echo "RHEL optional channel is disabled...enabling"
	/usr/bin/sudo /usr/bin/subscription-manager repos --enable=rhel-7-server-optional-rpms
else
	/bin/echo "RHEL optional channel is already enabled"
fi
# pull opt package versions from pkglist.opt. Otherwise just download the newest
# versions available
OPT_PACKAGES="anaconda-dracut at-spi tigervnc-server-module bitmap-fangsongti-fonts \
GConf2-devel"
CONF=./conf/pkglist.opt
VERSIONED_LIST=
if [ -s $CONF ]; then
    for pkg in $OPT_PACKAGES; do
        pkg=`/bin/sed -rn "s/$pkg-(.*).rpm/$pkg-\1/p" $CONF`
        VERSIONED_LIST="$VERSIONED_LIST $pkg"
    done
else
    VERSIONED_LIST=$OPT_PACKAGES
fi
/usr/bin/sudo /bin/yumdownloader --destdir $optrepopath $VERSIONED_LIST
/usr/bin/createrepo -d $optrepopath

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
check_and_build_rpm "lorax" "lorax-19.6.45-5.el7"

# Roll pungi
check_and_build_rpm "pungi" "pungi-2.13-4.el7"

if ! rpm -q "livecd-tools-20.6-1.el7.x86_64" > /dev/null; then
	if rpm -q "livecd-tools" > /dev/null; then
		/bin/echo "You have livecd-tools installed, but not our version. Our version contains 
fixes for generating live media.  We will compile our version and replace your 
version free of charge.
Press the any key to continue or ctrl-c to exit.
"
		read user_input
		/usr/bin/sudo /usr/bin/yum remove livecd-tools 2>/dev/null || true
		/usr/bin/sudo /usr/bin/yum remove python-imgcreate 2>/dev/null || true
	fi
	/usr/bin/sudo /usr/bin/yum install -y syslinux-extlinux dumpet 2>/dev/null || true
	/usr/bin/make livecd-tools-rpm
	pushd . > /dev/null
	cd repos/clip-repo
	/usr/bin/sudo /usr/bin/yum localinstall -y livecd-tools* and python-imgcreate*
	popd > /dev/null
fi

if ! rpm -q "openscap-1.2.1-1.el7.x86_64" > /dev/null; then
	if rpm -q "openscap" > /dev/null; then
		/bin/echo "You have openscap installed, but not our version. Our version is
required to build scap-security-guide.
Press the any key to continue or ctrl-c to exit.
"
		read user_input
		/usr/bin/sudo /usr/bin/yum remove openscap* 2>/dev/null || true
	fi
	/usr/bin/make openscap-rpm
	pushd . > /dev/null
	cd repos/clip-repo
	/usr/bin/sudo /usr/bin/yum localinstall -y openscap*
	popd > /dev/null
fi

/bin/echo -e "Basic bootstrapping of build host is complete.\nRunning 'make clip-rhel7-iso'"
/usr/bin/make clip-rhel7-iso
