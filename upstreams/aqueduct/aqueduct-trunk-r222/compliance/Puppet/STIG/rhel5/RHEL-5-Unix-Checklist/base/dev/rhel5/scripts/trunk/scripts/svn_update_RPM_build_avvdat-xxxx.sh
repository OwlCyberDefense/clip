#!/bin/bash -x

#CURRENTAVVDAT=`cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES/ && ls avvdat*.tar`
# RPM=`ls  /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/RPMS/noarch/avvdatspawar*.rpm`
#read
  cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && find ./avvdat-* -exec rm {} \;

cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && wget --reject $CURRENTAVVDAT -rnH --cut-dirs=3 ftp://ftp.mcafee.com/pub/datfiles/english/avvdat*.tar

#if [ ! `cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES/ && ls avvdat* | grep -v "${CURRENTAVVDAT}"` == "" ]; then

  #cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && find ./avvdat-* -mtime +1 -exec rm {} \;
  # cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SOURCES && find ./avvdat-* -exec rm {} \;

  svn add /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SPECS && svn commit -m "updated avvdatspawar*.rpm" /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SPECS

  rm -f  /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/RPMS/noarch/avvdatspawar*.rpm
  rm -f  /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/uvscan/avvdatspawar*.rpm

  echo "get the new avvdat version number to update the spec file"
  echo "then hit enter"
  read

  vi /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SPECS/avvdatspawar.spec

  cd /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/SPECS && rpmbuild -ba avvdatspawar.spec

  RPM=`ls  /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/RPMS/noarch/avvdatspawar*.rpm`

  for i in $RPM;do /home/sysutil/scripts/rpm_addsign.sh $i;done

  cp /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/src/redhat/RPMS/noarch/avvdatspawar*.rpm /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/uvscan/ && svn add /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/uvscan/avvdatspawar*.rpm && svn commit -m "updated avvdatspawar*.rpm" /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/rpm/trunk/channels/x86_64/uvscan/avvdatspawar*.rpm

#fi