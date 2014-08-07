#!/bin/bash -u
set -e
echo -e "Creating an environment for building software and ISOs can be a little 
complicated.  This script will automate some of those tasks.  Keep in mind that 
this script isn't exhaustive; depending on a variety of factors you may have to
install some additional packages.\n\nYour user *must* have sudo access for any 
of this to work.

If you are using RHEL enter 'r'.
If you are using CentOS 'c'."
read distro

# install packages that we need but aren't commonly present on default RHEL installs.
for i in createrepo rpm-build; do
	/bin/rpm -q "$i" >/dev/null || sudo /usr/bin/yum install -y $i
done;

# if we're on RHEL add the Opt channel
if [ "$distro" == "r" ]; then
	echo "We're going to try to subscribe to the RHEL Optional channel for your distro.
This might not work if you don't have credentials or you're out of entitlements.
We *NEED* packages from Opt to be installed on the build host *and* need to pull
packages from there to put on the generated installable media.  If you're using
RHEL want to work-around this issue (hack): 
1. Grab a CentOS ISO.
2. Mount it.
3. Add it as a yum repo:
	http://docs.oracle.com/cd/E37670_01/E37355/html/ol_create_repo.html
4. Re-run this script and pick CentOS.
5. Refer to the same path in the CONFIG_REPOS file.
Press enter to continue.
"
	read
	sudo rhn-channel --add --channel=rhel-x86_64-server-optional-`/bin/awk '{ print $7; }' /etc/redhat-release`.z
fi
/bin/rpm -q "python-kid" >/dev/null || sudo /usr/bin/yum install -y python-kid || if [ "$?" != "0" ]; then
	echo "WARNING: we couldn't find a package we need to install on the build 
host.  This is usually the result of using RHEL without a subscription to RHN. Try this:
1. Grab a CentOS ISO.
2. Mount it.
3. Add it as a yum repo:
        http://docs.oracle.com/cd/E37670_01/E37355/html/ol_create_repo.html
4. Re-run this script and pick CentOS.
5. Refer to the same path in the CONFIG_REPOS file.
"
fi

# install packages from epel that we carry in CLIP
pushd . >/dev/null
cd host_packages 
for i in `find ./ -iname *.rpm`; do
	NAME=`/bin/rpm -qp --queryformat '%{NAME}' $i 2>/dev/null`
	/bin/rpm -q "$NAME" > /dev/null|| sudo /usr/bin/yum localinstall -y $i
done
popd > /dev/null
sudo /usr/sbin/usermod -aG mock `id -un`

# Fourth, roll pungi
if ! rpm -q pungi >/dev/null; then
	/usr/bin/make pungi-rpm
	pushd . > /dev/null  
	cd repos/my-repo
	sudo /usr/bin/yum localinstall -y pungi*
	popd > /dev/null
fi

echo -e "Basic bootstrapping of build host is complete.\nPress 'enter' to run 'make clip-rhel6-iso' or ctrl-c to quit."
read
make clip-rhel6-iso
