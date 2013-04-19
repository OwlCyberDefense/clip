%if ! (0%{?fedora} > 12 || 0%{?rhel} > 5)
%{!?python_sitelib: %global python_sitelib %(%{__python} -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")}
%{!?python_sitearch: %global python_sitearch %(%{__python} -c "from distutils.sysconfig import get_python_lib; print(get_python_lib(1))")}
%endif

%define version 0.6.0

Summary: Security State Configuration Tool
Name: secstate
URL: https://fedorahosted.org/secstate/
Version: %{version}
Release: %{release}
License: GPLv2+ and LGPLv2+ and BSD
Vendor: Tresys Technology, LLC
Packager: %{_packager}
Group: System Environment/Base
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}
BuildArch: noarch
BuildRequires: redhat-rpm-config python2-devel
Requires: openscap-python >= 0.9.1
Requires: python
Requires: libxml2-python
Requires: libxslt-python
Requires: python-simplejson

Source0:        %{name}-%{version}.tar.gz
Patch:          ttime-to-string.patch

%description
SecState is a Security Configuration tool that utilizes openscap and bash
to configure and validate security configuration information on a target
system.  SecState targets U.S. federal regulations and guidance, but can be
used with any SCAP compliant content.

%prep
%setup -q -c
%patch -p1

%build

%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT

%clean
#rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%dir %{_sysconfdir}/secstate/
%config(noreplace) %{_sysconfdir}/secstate/secstate.conf
%dir /var/lib/secstate/
%dir /var/lib/secstate/benchmarks/
%dir /var/lib/secstate/configs/
%dir /var/lib/secstate/oval/
%dir /usr/share/secstate/
%dir %{_libexecdir}/%{name}
%doc LICENSE LICENSE.BSD LICENSE.LGPLv21 LICENSE.GPLv2
%{_mandir}/man8/secstate.8.gz
%{_mandir}/man5/secstate.conf.5.gz

# GPLv2+
%{_sbindir}/secstate
%dir /usr/share/secstate/transforms
/usr/share/secstate/transforms/*

# LGPLv2+
%dir %{python_sitelib}/secstate
%{python_sitelib}/secstate/__init__.py*
%{python_sitelib}/secstate/main.py*
%{python_sitelib}/secstate/util.py*

%changelog
* Fri Apr 19 2013 Brandon Whalen <brandon@quarksecurity.com> 0.6.0-2
- Use time.asctime() as openscap expects time to be a string

* Tue Oct 16 2012 Tyler Sellmayer <tsellmayer@tresys.com> 0.5.2-1
- Removed all mention of puppet.

* Mon Sep 13 2010 Marshall Miller <mmiller@tresys.com> 0.4.1-1
- Updates to man page
- Updated the human-readable output transform
- Changed the pam provider by removing the "type" attribute

* Thu Sep 2 2010 Marshall Miller <mmiller@tresys.com> 0.4.0-1
- Changed versioning scheme

* Wed Aug 27 2010 Joshua Adams <jadams@tresys.com> 0.3-12
- Added site.pp for puppet
- Added custom XSL tranform

* Wed Aug 25 2010 Marshall Miller <mmiller@tresys.com> 0.3-11
- Improved profile selection
- Improved remediation support

* Tue Aug 3 2010 Marshall Miller <mmiller@tresys.com> 0.3-10
- Updated to support openscap-python 0.6
- Added puppet module for ifdefined function

* Sat Jul 31 2010 Toshio Kuratomi <toshio@fedoraproject.org> 0.3-9
- rebuild against pythn-2.7

* Fri Jul 16 2010 Marshall Miller <mmiller@tresys.com> 0.3-8
- Added a requires for puppet

* Tue Jul 13 2010 Marshall Miller <mmiller@tresys.com> 0.3-7
- Added puppet modules to package
- Fixed license discrepancies

* Tue Jul 13 2010 Marshall Miller <mmiller@tresys.com> 0.3-6
- Removed revision from source tarball name
- Removed unnecessary rm

* Wed Jul 7 2010 Marshall Miller <mmiller@tresys.com> 0.3-5
- Added a very basic man page

* Thu Jul 2 2010 Marshall Miller <mmiller@tresys.com> 0.3-4
- Hard coded version and release into spec
- Added license file

* Thu Jul 1 2010 Marshall Miller <mmiller@tresys.com> 0.3-3
- Fixed mode permissions on files and directories

* Wed Jun 30 2010 Marshall Miller <mmiller@tresys.com> 0.3-2
- All major features added

* Thu Apr 1 2010 Ed Sealing <esealing@tresys.com> 0.3-1
- Initial secstate spec
