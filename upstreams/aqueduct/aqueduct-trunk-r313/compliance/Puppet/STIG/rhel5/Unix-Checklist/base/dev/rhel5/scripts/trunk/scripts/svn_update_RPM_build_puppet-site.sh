#!/bin/bash


cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && rm -rf etc

svn update https://svn.forge.mil/svn/repos/slim/slim/base/dev/rhel5/puppet ~sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet

  rm -f  /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/RPMS/noarch/puppet-site*.rpm
  rm -f  /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/puppet-site*.rpm


cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && mkdir -p puppet-site/etc/puppet/modules/site
cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && mkdir -p puppet-site/etc/puppet/manifests

cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && rsync -av --exclude=".svn" /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/site puppet-site/etc/puppet/modules/
cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && rsync -av --exclude=".svn" /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/manifests/site.pp puppet-site/etc/puppet/manifests/

vi /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SPECS/puppet-site.spec

cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SPECS && rpmbuild -ba puppet-site.spec

cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && rm -rf puppet-site

RPM=`ls  /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/RPMS/noarch/puppet-site*.rpm`

for i in $RPM;do /home/sysutil/scripts/rpm_addsign.sh $i;done

cp /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/RPMS/noarch/puppet-site*.rpm /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/ && svn add /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/puppet-site*.rpm && svn commit -m "updated puppet-site*.rpm" /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/puppet-site*.rpm
