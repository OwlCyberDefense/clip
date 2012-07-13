#!/bin/bash


cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && rm -rf etc
cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && rm -rf var

svn update https://svn.forge.mil/svn/repos/slim/slim/base/dev/rhel5/puppet ~sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet

  rm -f  /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/RPMS/noarch/puppet-stig*.rpm
  rm -f  /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/puppet-stig*.rpm


cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && mkdir -p puppet-stig/etc/puppet/modules/stig
cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && mkdir -p puppet-stig/etc/puppet/manifests
cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && mkdir -p puppet-stig/var

cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && rsync -av --exclude=".svn" /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/stig puppet-stig/etc/puppet/modules/
cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && rsync -av --exclude=".svn" /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/manifests/stig.pp puppet-stig/etc/puppet/manifests/
cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && rsync -av --exclude=".svn" /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/COPYING puppet-stig/etc/puppet/
cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && rsync -av --exclude=".svn" /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/var/ puppet-stig/var/


vi /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SPECS/puppet-stig.spec

cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SPECS && rpmbuild -ba puppet-stig.spec

cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && rm -rf puppet-stig

RPM=`ls  /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/RPMS/noarch/puppet-stig*.rpm`

for i in $RPM;do /home/sysutil/scripts/rpm_addsign.sh $i;done

cp /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/RPMS/noarch/puppet-stig*.rpm /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/ && svn add /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/puppet-stig*.rpm && svn commit -m "updated puppet-stig*.rpm" /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/puppet-stig*.rpm
