#!/bin/bash

cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && rm -rf etc
cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && rm -rf var

svn update https://svn.forge.mil/svn/repos/slim/slim/base/dev/rhel5/puppet ~sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet

cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && mkdir -p etc/puppet
cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && mkdir -p var
cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && rsync -av --exclude=".svn" /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/ etc/puppet/
cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && rsync -av --exclude=".svn" /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/var/ var/
cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && tar zcvf puppet-stig.tar.gz etc var

vi /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SPECS/puppet-stig.spec

cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SPECS && rpmbuild -ba puppet-stig.spec

cp /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/RPMS/noarch/puppet-stig*.rpm /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/ && svn add /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/puppet-stig*.rpm && svn commit -m "updated puppet-stig*.rpm" /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/puppet/puppet-stig*.rpm