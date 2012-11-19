Name:           %{pkgname}
Version:        %{version}
Release:        %{release}
Summary:        The scap-security-guide project, or SSG for short, aims to deliver security guidance, baselines, and associated validation mechanisms for Red Hat Enterprise Linux.

Group:          Testing
License:        GPL
URL:            https://fedorahosted.org/scap-security-guide/

Source0:        %{name}-%{version}.tar.gz
Patch:          ssg-fix-fixes-tags.patch
Patch0:		replace-pam-cracklib-with-pam-passwdqc.patch
Patch1:		ldap-dependency-checking.patch
Patch2:		postfix-package-dependency-checking.patch
Patch3:		httpd-dependency-checking.patch
Patch4:		sysctl-module-dependency-checking.patch
Patch5:		add-dcid-profile.patch
Patch6:		add-manual-profile.patch

BuildRoot: %{_tmppath}/%{name}-root

BuildArch: noarch

BuildRequires:  /bin/rm, /bin/mkdir, /bin/cp
Requires:       /bin/bash, /bin/date, /usr/bin/oscap, aqueduct-SSG

%description
Today the SSG project provides guidance against U.S. Government requirements, 
including those of the U.S. Department of Defense and U.S. Intelligence Community.
Many U.S. Government policies, such as NIST 800-53 provide prose stating that
System Administrators must audit "privileged user actions," but do not define
what such actions are. The SSG bridges the gap between generalized U.S.
Government Policy and specific implementation guidance.

To lean more about the SCAP Security Guide project, please
visit https://fedorahosted.org/mailman/listinfo/scap-security-guide. Here
you will be able to find documentation, support, and information on getting
involved in the SCAP Security Guide community.

%prep
%setup -q -n %{pkgname}
%patch -p1
%patch0 -p1
%patch1 -p1
%patch2 -p1
%patch3 -p1
%patch4 -p1
%patch5 -p1
%patch6 -p1

%build
#configure
#`make %{?_smp_mflags}


%install
rm -rf $RPM_BUILD_ROOT
#make install DESTDIR=$RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr/local/%{name}/content
mkdir -p $RPM_BUILD_ROOT/usr/local/%{name}/guide
mkdir -p $RPM_BUILD_ROOT/usr/local/%{name}/policytables
mkdir -p $RPM_BUILD_ROOT/usr/local/%{name}/STIG-draft
mkdir -p $RPM_BUILD_ROOT/usr/local/%{name}/USGCB-submission

cp -r * $RPM_BUILD_ROOT/usr/local/%{name}/

%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc

%attr(0750,root,root)/usr/local/scap-security-guide/

%post
$RPM_BUILD_ROOT/usr/libexec/aqueduct/SSG/tools/fix_mapper.py
cd $RPM_BUILD_ROOT/usr/local/scap-security-guide/RHEL6
# Prevent clock drift from breaking the make.
find ./ -exec touch '{}' \;
make clean && make all

%changelog
* Thu Nov 08 2012 Mike Palmiotto <mpalmiotto@tresys.com> 1.0-5
- Add some patches for dependency checking in OVAL checks

* Tue Jul 17 2012 Mike Palmiotto <mpalmiotto@tresys.com> 1.0-4
- Add aqueduct-SSG to Requires and get fixes into SSG in %post

* Mon Jun 11 2012 Spencer Shimko <sshimko@tresys.com> 1.0-3
- Pull into the CLIP build system w/ modifications to make it compliant with expectations.

* Thu Apr 19 2012 Spencer Shimko <sshimko@tresys.com> 1.0-2
- Minor updates to pass some variables in from build system.

* Mon Apr 02 2012 Shawn Wells <shawn@redhat.com> 1.0-1
- First attempt at SSG RPM. May ${diety} help us...
