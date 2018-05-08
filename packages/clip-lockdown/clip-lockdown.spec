Name:	clip-lockdown
Version: %{version}
Release: %{release}
Summary: CLIP Module for system lockdown confinguration
Requires: audit

License: GPL or BSD
Group: System Environment/Base

BuildRoot: %{_tmppath}/%{name}-root

%define audit_dir		%{_sysconfdir}/audit/rules.d/
%define sysctl_dir		%{_sysconfdir}/sysctl.d/
%define modprobe_dir	%{_sysconfdir}/modprobe.d/


Source0: %{pkgname}-%{version}.tgz

%description
This package contains various configuration files and lockdown for a CLIP based system

%prep
%setup -q -n %{pkgname}

%build

%install
rm -rf $RPM_BUILD_ROOT

install -d $RPM_BUILD_ROOT/%{audit_dir}
install audit/*.rules $RPM_BUILD_ROOT/%{audit_dir}

install -d $RPM_BUILD_ROOT/%{sysctl_dir}
install sysctl/*.conf $RPM_BUILD_ROOT/%{sysctl_dir}

install -d $RPM_BUILD_ROOT/%{modprobe_dir}
install modprobe/*.conf $RPM_BUILD_ROOT/%{modprobe_dir}

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(755,root,root,-)
%attr(440,root,root) %{audit_dir}/*rules
%attr(440,root,root) %{sysctl_dir}/*conf
%attr(440,root,root) %{modprobe_dir}/*conf

%post

%changelog
* Wed May 09 2018 Dave Sugar <dsugar@tresys.com> 1.0-1
- Initial CLIP lockdown RPM

