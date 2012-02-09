Summary: Certifiable Linux Integration Platform Puppet Configuration
Name: %{pkgname}
Version: %{version}
Release: %{release}
License: GPL
Group: System Environment/Base
Source0: clip-puppet-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-root
BuildArch: noarch
Requires: puppet

%description

%prep
%setup -q -n %{pkgname}

%install
rm -rf "$RPM_BUILD_ROOT"
mkdir -p "$RPM_BUILD_ROOT/etc"
mkdir -p "$RPM_BUILD_ROOT/etc/puppet"
mkdir -p "$RPM_BUILD_ROOT/var/lib/puppet/lib/puppet/type/"
cp -ra * "$RPM_BUILD_ROOT/etc/puppet"
mv "$RPM_BUILD_ROOT/etc/puppet/plugins/append_if_no_such_line.rb" "$RPM_BUILD_ROOT/var/lib/puppet/lib/puppet/type/"
rmdir "$RPM_BUILD_ROOT/etc/puppet/plugins"

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%config /etc/puppet/manifests/site.pp
%config /etc/puppet/modules/
/etc/puppet/COPYING
/var/lib/puppet/lib/puppet/type/append_if_no_such_line.rb

%post

%changelog
* Thu Apr 28 2011 Spencer Shimko <sshimko@tresys.com> - 3.1-4
- Fixes for new build system.

* Thu May 28 2008 Christopher J. PeBenito <cpebenito@tresys.com> -
- Initial version

