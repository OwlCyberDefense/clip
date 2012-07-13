Name:           puppet-hosts
Version:        .001
Release:        1%{?dist}
Summary:        host puppet content
Packager:       Aaron Prayther aprayther@lce.com Life Cycle Engineering
Group:          Development/Tools
License:        GPL
URL:            https://software.forge.mil/DoDBastile
Source0:        $RPM_SOURCE_DIR/puppet-hosts
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:      noarch
#BuildRequires:
Requires:       puppet >= 0.25, subversion, rpm-build, expect

%description
The puppet content to address, hosts things, like ntp.conf, resolv, etc on RHEL 5.x servers.

# The scriptlets in %pre and %post are respectively run before and after a package is installed. The scriptlets %preun and %postun are run before and after a package is uninstalled. The scriptlets %pretrans and %posttrans are run at start and end of a transaction. On upgrade, the scripts are run in the following order:

# %pretrans of new package
# %pre of new package
# (package install)
# %post of new package
# %preun of old package
# (removal of old package)
# %postun of old package
# %posttrans of new package

%prep
rm -rf $RPM_BUILD_ROOT
mkdir $RPM_BUILD_ROOT

# this is just taking a src file and moving it around /src/redhat/* and /var/tmp/ to keep things straight.. then cleanup.
%install
rm -rf $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)/
mkdir $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
rsync -av $RPM_SOURCE_DIR/puppet-hosts/* $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)/
rsync -av $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)/* %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)/
rm -rf $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)/

%clean
rm -rf $RPM_BUILD_ROOT

%pretrans
chage -l sysutil 2>&1 >/dev/null
  if [ $? != "0" ]; then
    /usr/sbin/useradd -f0 -p '\$1\$quu6T/\$e2KG6O0h1g83MX.aU8INl.' -u 607 -G users,integrators -c "system utility account for automation purposes" -m -d /home/sysutil -s /bin/bash sysutil 2>&1 >/dev/null
  fi
%pre
chage -l sysutil 2>&1 >/dev/null
  if [ $? != "0" ]; then
    /usr/sbin/useradd -f0 -p '\$1\$quu6T/\$e2KG6O0h1g83MX.aU8INl.' -u 607 -G users,integrators -c "system utility account for automation purposes" -m -d /home/sysutil -s /bin/bash sysutil 2>&1 >/dev/null
  fi

chown -R sysutil.sysutil ~sysutil

# this is on the client, right after the rpm package makes it to the client and runs.
%post
mkdir -p ~sysutil/redhat/BUILD ~sysutil/redhat/SRPMS
chown -R sysutil.sysutil ~sysutil
chmod 700 ~sysutil/*.sh ~sysutil/.gnu*
# this puppet will use a template to setup default as well as pull custom content from svn
/usr/bin/puppet -d -l /var/log/puppet/puppet-hosts.log /etc/puppet/manifests/hosts.pp

# this is the uninstall or upgrade from the perspective of: yum remove or yum upgrade on the client
%preun
%postun
if [ $1 = 0 ]; then
        if [ -d /etc/puppet/manifests ]; then
          rm -rf /etc/puppet/manifests/hosts.pp /etc/puppet/modules/hosts
        fi
        if [ -d ~sysutil ]; then
          chage -l sysutil 2>&1 >/dev/null
            if [ $? == "0" ]; then
              userdel sysutil 2>&1 >/dev/null
            fi
        fi
fi
%posttrans

%files
%defattr(-,root,root,-)

   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/defaults.custom.rpm/source/GPG-SPAWAR-KEY
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/defaults.custom.rpm/source/RPM-GPG-KEY-EPEL
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/defaults.custom.rpm/source/RPM-GPG-KEY-oracle
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/defaults.custom.rpm/source/VMWARE-PACKAGING-GPG-KEY.pub
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/defaults.custom.rpm/source/forge-cert.p12
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/defaults.custom.rpm/source/install-linux-45-1470
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/defaults.custom.rpm/source/install-linux-45-1812.sh
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/defaults.custom.rpm/source/check_cpu_perf.sh
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/defaults.custom.rpm/templates/bacula-fd.conf
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/defaults.custom.rpm/templates/hosts
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/defaults.custom.rpm/templates/nrpe.cfg
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/defaults.custom.rpm/templates/snmpd.conf
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/defaults.custom.rpm/templates/snmpd.conf.init
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/defaults.custom.rpm/templates/snmpd.conf.new
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/defaults.custom.rpm/templates/sudoers

   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/templates/template.hosts.pp
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/templates/template.init.pp
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/templates/template.puppet-hosts-cron.sh
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/templates/template.puppet-hosts-yum.sh
   /home/sysutil/svn.forge.mil/slim/base/dev/rhel5/puppet/trunk/etc/puppet/modules/hosts/templates/template.puppet-hosts.spec

   /etc/puppet/modules/hosts/manifests/init.pp
   /etc/puppet/manifests/hosts.pp
   
   /home/sysutil/.gnupg/GPG-SPAWAR-KEY
   /home/sysutil/.gnupg/gpg.conf
   /home/sysutil/.gnupg/pubring.gpg
   /home/sysutil/.gnupg/random_seed
   /home/sysutil/.gnupg/secring.gpg
   /home/sysutil/.gnupg/trustdb.gpg
   /home/sysutil/.ssh/id_rsa
   /home/sysutil/.ssh/id_rsa.pub
   /home/sysutil/.rpmmacros
   /home/sysutil/.subversion/README.txt
   /home/sysutil/.subversion/auth/svn.ssl.server/011bf0895b14f236d333785a19688eb5
   /home/sysutil/.subversion/config
   /home/sysutil/.subversion/servers
   /home/sysutil/forge-cert.p12
   /home/sysutil/host_svn_puppet_rpm_build_to_satellite.sh
   /home/sysutil/permanent_svn.sh
   /home/sysutil/redhat/RPMS/README
   /home/sysutil/redhat/RPMS/noarch/puppet-hosts-.001-1.noarch.rpm
   /home/sysutil/redhat/SOURCES/README
   /home/sysutil/redhat/SPECS/README
   /home/sysutil/redhat/SPECS/puppet-hosts.spec
   /home/sysutil/rpm_addsign.sh
   /home/sysutil/custom.rpm.build.sh

# %doc

%changelog
* Mon Mar 14 2011 Aaron Prayther <aprayther@lce.com - .001-1
-first stab