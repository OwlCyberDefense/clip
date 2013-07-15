Name:	clip-dracut-module
Version: 1
Release: 1
Summary: CLIP Module for Dracut
Requires: dracut

License: GPL or BSD
Group: System Environment/Base

BuildRequires: make, coreutils
BuildRoot: %{_tmppath}/%{name}-root

Source0: %{pkgname}-%{version}.tgz

%description
This package contains a module for dracut that provides
support for things like booting stateless media when
relabeling is required.

%prep
%setup -q -n %{pkgname}

%build

%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(755,root,root,-)
/usr/share/dracut/modules.d/96clip/check
/usr/share/dracut/modules.d/96clip/install
/usr/share/dracut/modules.d/96clip/clip.sh

%post

%changelog
* Mon Jul 15 2013 Spencer Shimko <spencer@quarksecurity.com> 1-1
- Initial dracut module for CLIP and spec.

