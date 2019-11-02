Name:	clip-dracut-module
Version: %{version}
Release: %{release}
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
rm -rf %{buildroot}
make install DESTDIR=%{buildroot}

%clean
rm -rf %{buildroot}

%files
%defattr(755,root,root,-)
/usr/lib/dracut/modules.d/96clip/module-setup.sh
/usr/lib/dracut/modules.d/96clip/clip.sh

%post

%changelog
* Mon Jul 15 2013 Spencer Shimko <spencer@quarksecurity.com> 1-1
- Initial dracut module for CLIP and spec.

