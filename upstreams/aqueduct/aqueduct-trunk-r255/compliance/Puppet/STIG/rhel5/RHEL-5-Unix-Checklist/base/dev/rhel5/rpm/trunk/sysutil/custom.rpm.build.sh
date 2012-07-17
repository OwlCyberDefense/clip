#!/bin/bash -x

HOME="/home/sysutil"
hostname=`hostname -s`
        ## get the latest $hostname content from svn
rm -rf $HOME/redhat/SOURCES/etc
        ## get additional puppet content for $hostname and the latest
svn co https://svn.forge.mil/svn/repos/slim/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/defaults.custom.rpm $HOME/svn.forge.mil/slim/base/dev/rhel5/puppet/modules/$hostname/
svn co https://svn.forge.mil/svn/repos/slim/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/$hostname $HOME/svn.forge.mil/slim/base/dev/rhel5/puppet/modules/$hostname/
        ## clean up from previous runs, previous versions
rm -f  $HOME/redhat/RPMS/noarch/puppet-$hostname*.rpm
rm -f  $HOME/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/noarch/puppet/puppet-$hostname*.rpm

 mkdir -p $HOME/redhat/SOURCES/puppet-$hostname/etc/puppet/modules/hosts/
 mkdir -p $HOME/redhat/SOURCES/puppet-$hostname/etc/puppet/manifests
        ## move the svn/puppet content into place for rpm build
rsync -av --exclude=".svn" $HOME/svn.forge.mil/slim/base/dev/rhel5/puppet/modules/hosts/$hostname/ $HOME/redhat/SOURCES/puppet-$hostname/etc/puppet/modules/$hostname/
chown -R sysutil.sysutil $HOME/
rsync -av --exclude=".svn" $HOME/svn.forge.mil/slim/base/dev/rhel5/puppet/modules/hosts/$hostname $HOME/redhat/SOURCES/puppet-$hostname/etc/puppet/modules/
rsync -av --exclude=".svn" $HOME/svn.forge.mil/slim/base/dev/rhel5/puppet/manifests/$hostname.pp $HOME/redhat/SOURCES/puppet-$hostname/etc/puppet/manifests/
        ## increment Version in the rpm spec file
for OLD in `grep Version: $HOME/redhat/SPECS/puppet-$hostname.spec | cut -d. -f3`;do NUMBER=$(echo "$OLD" | tr -d [:alpha:]) && STRING=$(echo "$OLD" | tr -d [:digit:]) && NEW=$STRING$(($NUMBER+1)) && sed -i "s/$OLD/$NEW/" $HOME/redhat/SPECS/puppet-$hostname.spec;done
        ## RPM build
rpmbuild -ba $HOME/redhat/SPECS/puppet-$hostname.spec
RPM=`ls  $HOME/redhat/RPMS/noarch/puppet-$hostname*.rpm`
rm -rf $HOME/redhat/SOURCES/puppet-$hostname
for i in $RPM;do $HOME/rpm_addsign.sh $i;done
mkdir -p $HOME/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/noarch/puppet/
cp $HOME/redhat/RPMS/noarch/puppet-$hostname*.rpm $HOME/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/ && svn add $HOME/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/puppet-$hostname*.rpm && svn commit -m "updated puppet-$hostname*.rpm" $HOME/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/puppet-$hostname*.rpm