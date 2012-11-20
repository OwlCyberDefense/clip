Name:	%{pkgname}
Version: %{version}
Release: %{release}
Summary: Example software package.
Requires: kernel

License: GPL or BSD
Group: System Environment/Base

BuildRequires: make, bash
BuildRoot: %{_tmppath}/%{name}-root

Source0: %{pkgname}-%{version}.tgz
#Patch0: %(pkgname}.patch


%description
This package contains the example daemon.

%prep
%setup -q -n %{pkgname}-%{version}
#%patch0 -p1

%build
%configure
make

%install
rm -rf $RPM_BUILD_ROOT
make install

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(755,root,root,-)
/usr/bin/example
/etc/init.d/example

%post
/sbin/chkconfig --add example
/sbin/depmod

%changelog
* Mon Apr 18 2011 Spencer Shimko <sshimko@tresys.com> 1-1
- Example spec file.

