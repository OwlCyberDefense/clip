#!/bin/bash

# CURRENTAVVDAT=`ls /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES/avvdat*.tar`
#RPM=`ls  /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/RPMS/noarch/avvdatspawar*.rpm`

# cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && wget --reject $CURRENTAVVDAT -rnH --cut-dirs=3 ftp://ftp.mcafee.com/pub/datfiles/english/avvdat*.tar

# if [ `ls /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES/avvdat* | grep -v $CURRENTAVVDAT` != "" ]; then

  #cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && find ./avvdat-* -mtime +1 -exec rm {} \;

  #rm -f  /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/RPMS/noarch/uvscanspawar*.rpm

  #echo "get the new avvdat version number to update the spec file"
  #echo "then hit enter"
  #read

  rm -f  /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/RPMS/x86_64/uvscanspawar*.rpm
  rm -f  /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/uvscan/uvscanspawar*.rpm

  vi /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SPECS/uvscanspawar.spec

  cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SPECS && rpmbuild -ba uvscanspawar.spec

RPM=`ls  /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/RPMS/x86_64/uvscanspawar*.rpm`

for i in $RPM;do /home/sysutil/scripts/rpm_addsign.sh $i;done

  cp /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/RPMS/x86_64/uvscanspawar*.rpm /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/uvscan/ && svn add /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/uvscan/uvscanspawar*.rpm && svn commit -m "updated uvscanspawar*.rpm" /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/uvscan/uvscanspawar*.rpm
# fi