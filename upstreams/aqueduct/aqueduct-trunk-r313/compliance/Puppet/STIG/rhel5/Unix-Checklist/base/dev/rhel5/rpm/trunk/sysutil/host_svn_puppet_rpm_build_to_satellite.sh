#!/bin/bash -x

#HOME="/home/aprayther"
HOME="/home/sysutil"
#USER="aprayther"

## need to put a better check for svn setup.  look at what permanent_svn.sh is doing
ls .subversion/config
if [ $? != "0" ];then
  $HOME/permanent_svn.sh
fi

cd $HOME/redhat/SOURCES && rm -rf etc

## boot strapping svn + rpmbuild env, setting up sysutil home dir
svn co https://svn.forge.mil/svn/repos/slim/slim/base/dev/rhel5/rpm/trunk/sysutil $HOME/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/sysutil
svn co https://svn.forge.mil/svn/repos/slim/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts $HOME/svn.forge.mil/slim/base/dev/rhel5/puppet/modules/hosts
## need to check this out to make a working directory to commit at the end of the rpmbuild process
svn co https://svn.forge.mil/svn/repos/slim/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/ $HOME/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/

  rm -f  $HOME/redhat/RPMS/noarch/puppet-hosts*.rpm
  rm -f  $HOME/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/noarch/puppet/puppet-hosts*.rpm


cd $HOME/redhat/SOURCES && mkdir -p puppet-hosts/home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts
cd $HOME/redhat/SOURCES && mkdir -p puppet-hosts/home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/manifests


cd $HOME/redhat/SOURCES && rsync -av --exclude=".svn" $HOME/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/sysutil/ puppet-hosts/home/sysutil
# rsync is skipping the empty dirs BUILD SRPMS :(
cd $HOME/redhat/SOURCES && mkdir -p puppet-hosts/home/sysutil/redhat/BUILD puppet-hosts/etc/puppet/modules/hosts

 ## this is taking the files and packaging them (putting them in redhat/SOURCE/ for rpmbuild) to be delivered with puppet-hosts.rpm which will then deliver them into the ~sysutil/redhat structure to be packaged into puppet-bait.rpm
 ## eliminating the need for puppet-hosts.rpm after creating puppet-bait.rpm.  puppet-bait.rpm will then be fully self contained.  puppet-hosts.rpm is only needed to automate the creation 
 ## of host specific rpm's.  the host specific rpm can then be delivered with satellite to reprovision that host.
cd $HOME/redhat/SOURCES && rsync -av --exclude="init.pp" --exclude="hosts.pp" --exclude=".svn" $HOME/svn.forge.mil/slim/base/dev/rhel5/puppet/modules/hosts/ puppet-hosts/home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/
cd $HOME/redhat/SOURCES && rsync -av --exclude=".svn" $HOME/svn.forge.mil/slim/base/dev/rhel5/puppet/modules/hosts/puppet/manifests/hosts.pp puppet-hosts/etc/puppet/manifests/
cd $HOME/redhat/SOURCES && rsync -av --exclude=".svn" $HOME/svn.forge.mil/slim/base/dev/rhel5/puppet/modules/hosts/manifests/init.pp puppet-hosts/etc/puppet/modules/hosts/manifests/

## cleaning up so it's not straggling around at time of rpmbuild
## rm -f $HOME/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/manifests/hosts.pp

vi $HOME/redhat/SPECS/puppet-hosts.spec

cd $HOME/redhat/SPECS && rpmbuild -ba puppet-hosts.spec

cd $HOME/redhat/SOURCES && rm -rf puppet-hosts

RPM=`ls  $HOME/redhat/RPMS/noarch/puppet-hosts*.rpm`

for i in $RPM;do $HOME/rpm_addsign.sh $i;done

mkdir -p $HOME/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/

cp $HOME/redhat/RPMS/noarch/puppet-hosts*.rpm $HOME/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/ && svn add $HOME/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/puppet-hosts*.rpm && svn commit -m "updated puppet-hosts*.rpm" $HOME/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/puppet-hosts*.rpm