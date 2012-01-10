Name:	%{pkgname}
Version: %{version}
Release: %{release}
Summary: Example daemon.


Group: System Environment/Kernel
License: GPL
Source0: %{pkgname}-%{version}.zip

BuildRequires: make, gcc
BuildRoot: %{_tmppath}/%{name}-root

%description
This installs the example daemon.

%prep
%setup -q  

%build
make

%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT 


%clean
rm -rf $RPM_BUILD_ROOT

%files
/sbin/example

%post
/sbin/chkconfig --add example

%changelog
* Thu May 5 2011 Spencer Shimko <sshimko@tresys.com> 1-1
- An example spec file.

