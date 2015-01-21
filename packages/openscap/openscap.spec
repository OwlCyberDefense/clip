%{!?python_sitelib: %global python_sitelib %(%{__python} -c "from distutils.sysconfig import get_python_lib; print get_python_lib()")}
%{!?python_sitearch: %global python_sitearch %(%{__python} -c "from distutils.sysconfig import get_python_lib; print get_python_lib(1)")}

%define relabel_files() \
restorecon -R /usr/bin/oscap /usr/libexec/openscap; \

Name:           openscap
Version:        1.2.1
Release:        1%{?dist}
Summary:        Set of open source libraries enabling integration of the SCAP line of standards
Group:          System Environment/Libraries
License:        LGPLv2+
URL:            http://www.open-scap.org/
Source0:        http://fedorahosted.org/releases/o/p/openscap/%{name}-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildRequires:  swig libxml2-devel libxslt-devel perl-XML-Parser
BuildRequires:  rpm-devel
BuildRequires:  libgcrypt-devel
BuildRequires:  pcre-devel
BuildRequires:  libacl-devel
BuildRequires:  libselinux-devel libcap-devel
BuildRequires:  libblkid-devel
BuildRequires:  bzip2-devel
%if %{?_with_check:1}%{!?_with_check:0}
BuildRequires:  perl-XML-XPath
BuildRequires:  bzip2
%endif
Requires(post):   /sbin/ldconfig
Requires(postun): /sbin/ldconfig

%description
OpenSCAP is a set of open source libraries providing an easier path
for integration of the SCAP line of standards. SCAP is a line of standards
managed by NIST with the goal of providing a standard language
for the expression of Computer Network Defense related information.

%package        devel
Summary:        Development files for %{name}
Group:          Development/Libraries
Requires:       %{name}%{?_isa} = %{version}-%{release}
Requires:       libxml2-devel
Requires:       pkgconfig

%description    devel
The %{name}-devel package contains libraries and header files for
developing applications that use %{name}.

%package        python
Summary:        Python 2 bindings for %{name}
Group:          Development/Libraries
Requires:       %{name}%{?_isa} = %{version}-%{release}
BuildRequires:  python-devel

%description    python
The %{name}-python package contains the bindings so that %{name}
libraries can be used by python.

%package        python3
Summary:        Python 3 bindings for %{name}
Group:          Development/Libraries
Requires:       %{name}%{?_isa} = %{version}-%{release}
BuildRequires:  python3-devel

%description    python3
The %{name}-python3 package contains the bindings so that %{name}
libraries can be used by python3.

%package        perl
Summary:        Perl bindings for %{name}
Group:          Development/Libraries
Requires:       %{name}%{?_isa} = %{version}-%{release}
Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; echo $version))
BuildRequires:  perl-devel

%description    perl
The %{name}-perl package contains the bindings so that %{name}
libraries can be used by perl.


%package        scanner
Summary:        OpenSCAP Scanner Tool (oscap)
Group:          Applications/System
Requires:       %{name}%{?_isa} = %{version}-%{release}
Requires:       libcurl >= 7.12.0
BuildRequires:  libcurl-devel >= 7.12.0

%description    scanner
The %{name}-scanner package contains oscap command-line tool. The oscap
is configuration and vulnerability scanner, capable of performing
compliance checking using SCAP content.

%package        utils
Summary:        OpenSCAP Utilities
Group:          Applications/System
Requires:       %{name}%{?_isa} = %{version}-%{release}
Requires:       rpmdevtools rpm-build
Requires:       %{name}-scanner%{?_isa} = %{version}-%{release}

%description    utils
The %{name}-utils package contains command-line tools build on top
of OpenSCAP library. Historically, openscap-utils included oscap
tool which is now separated to %{name}-scanner sub-package.

%package        content-sectool
Summary:        Sectool content
Group:          Applications/System
Requires:       %{name} = %{version}-%{release}
Requires:       %{name}-engine-sce
BuildArch:      noarch

%description    content-sectool
SCAP/SCE content that conforms to sectool checks.

%package        extra-probes
Summary:        SCAP probes
Group:          Applications/System
Requires:       %{name}%{?_isa} = %{version}-%{release}
BuildRequires:  openldap-devel
BuildRequires:  GConf2-devel

%description    extra-probes
The %{name}-extra-probes package contains additional probes that are not
commonly used and require additional dependencies.

%package        extra-probes-sql
Summary:        SCAP probes for Database
Group:          Applications/System
Requires:       %{name}%{?_isa} = %{version}-%{release}
BuildRequires:  opendbx-devel

%description    extra-probes-sql
The %{name}-extra-probes-sql package contains additional OpenSCAP probes
for querying database objects. Users are advised to install appropriate
opendbx backend package along this one.

%package        engine-sce
Summary:        Script Check Engine plug-in for OpenSCAP
Group:          Applications/System
Requires:       %{name}%{?_isa} = %{version}-%{release}

%description    engine-sce
The Script Check Engine is non-standard extension to SCAP protocol. This
engine allows content authors to avoid OVAL language and write their assessment
commands using a scripting language (Bash, Perl, Python, Ruby, ...).

%package        engine-sce-devel
Summary:        Development files for %{name}-engine-sce
Group:          Development/Libraries
Requires:       %{name}-devel%{?_isa} = %{version}-%{release}
Requires:       %{name}-engine-sce%{?_isa} = %{version}-%{release}
Requires:       pkgconfig

%description    engine-sce-devel
The %{name}-engine-sce-devel package contains libraries and header files
for developing applications that use %{name}-engine-sce.

%package        selinux
Summary:        SELinux policy module for openscap
Group:          System Environment/Base
Requires:       %{name}-utils = %{version}-%{release}
Requires:       policycoreutils, libselinux-utils
Requires(post): selinux-policy-base, policycoreutils
Requires(postun): policycoreutils
BuildRequires:  selinux-policy-devel
BuildArch:      noarch

%description    selinux
This package installs and sets up the  SELinux policy security module for openscap.

%prep
%setup -q

%build
%ifarch sparc64
#sparc64 need big PIE
export CFLAGS="$RPM_OPT_FLAGS -fPIE"
export LDFLAGS="-pie -Wl,-z,relro -Wl,-z,now"
%else
export CFLAGS="$RPM_OPT_FLAGS -fpie"
export LDFLAGS="-pie -Wl,-z,relro -Wl,-z,now"
%endif

%configure --enable-sce --enable-perl --enable-selinux_policy --enable-python3

make %{?_smp_mflags}
# Remove shebang from bash-completion script
sed -i '/^#!.*bin/,+1 d' dist/bash_completion.d/oscap

%check
#to run make check use "--with check"
%if %{?_with_check:1}%{!?_with_check:0}
make check
%endif

%install
rm -rf $RPM_BUILD_ROOT

make install INSTALL='install -p' DESTDIR=$RPM_BUILD_ROOT

# remove content for another OS
rm $RPM_BUILD_ROOT/%{_datadir}/openscap/scap-rhel6-oval.xml
rm $RPM_BUILD_ROOT/%{_datadir}/openscap/scap-rhel6-xccdf.xml
rm $RPM_BUILD_ROOT/%{_datadir}/openscap/scap-fedora14-oval.xml
rm $RPM_BUILD_ROOT/%{_datadir}/openscap/scap-fedora14-xccdf.xml

# bash-completion script
mkdir -p $RPM_BUILD_ROOT/%{_sysconfdir}/bash_completion.d
install -pm 644 dist/bash_completion.d/oscap $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d/oscap

find $RPM_BUILD_ROOT -name '*.la' -exec rm -f {} ';'

%clean
rm -rf $RPM_BUILD_ROOT

%post -p /sbin/ldconfig

%post selinux
semodule -n -i %{_datadir}/selinux/packages/oscap.pp
if /usr/sbin/selinuxenabled ; then
    /usr/sbin/load_policy
    %relabel_files
fi;
exit 0

%postun -p /sbin/ldconfig

%postun selinux
if [ $1 -eq 0 ]; then
    semodule -n -r oscap
    if /usr/sbin/selinuxenabled ; then
       /usr/sbin/load_policy
       %relabel_files
    fi;
fi;
exit 0

%files
%defattr(-,root,root,-)
%doc AUTHORS COPYING ChangeLog NEWS README.md
%{_libdir}/libopenscap.so.*
%{_libexecdir}/openscap/probe_dnscache
%{_libexecdir}/openscap/probe_environmentvariable
%{_libexecdir}/openscap/probe_environmentvariable58
%{_libexecdir}/openscap/probe_family
%{_libexecdir}/openscap/probe_file
%{_libexecdir}/openscap/probe_fileextendedattribute
%{_libexecdir}/openscap/probe_filehash
%{_libexecdir}/openscap/probe_filehash58
%{_libexecdir}/openscap/probe_iflisteners
%{_libexecdir}/openscap/probe_inetlisteningservers
%{_libexecdir}/openscap/probe_interface
%{_libexecdir}/openscap/probe_partition
%{_libexecdir}/openscap/probe_password
%{_libexecdir}/openscap/probe_process
%{_libexecdir}/openscap/probe_process58
%{_libexecdir}/openscap/probe_routingtable
%{_libexecdir}/openscap/probe_rpminfo
%{_libexecdir}/openscap/probe_rpmverify
%{_libexecdir}/openscap/probe_rpmverifyfile
%{_libexecdir}/openscap/probe_rpmverifypackage
%{_libexecdir}/openscap/probe_runlevel
%{_libexecdir}/openscap/probe_selinuxboolean
%{_libexecdir}/openscap/probe_selinuxsecuritycontext
%{_libexecdir}/openscap/probe_shadow
%{_libexecdir}/openscap/probe_sysctl
%{_libexecdir}/openscap/probe_system_info
%{_libexecdir}/openscap/probe_systemdunitdependency
%{_libexecdir}/openscap/probe_systemdunitproperty
%{_libexecdir}/openscap/probe_textfilecontent
%{_libexecdir}/openscap/probe_textfilecontent54
%{_libexecdir}/openscap/probe_uname
%{_libexecdir}/openscap/probe_variable
%{_libexecdir}/openscap/probe_xinetd
%{_libexecdir}/openscap/probe_xmlfilecontent
%dir %{_datadir}/openscap
%dir %{_datadir}/openscap/schemas
%dir %{_datadir}/openscap/xsl
%dir %{_datadir}/openscap/cpe
%{_datadir}/openscap/schemas/*
%{_datadir}/openscap/xsl/*
%{_datadir}/openscap/cpe/*

%files python
%defattr(-,root,root,-)
%{python_sitearch}/*

%files python3
%{python3_sitearch}/*

%files perl
%defattr(-,root,root,-)
%{perl_vendorarch}/*
%{perl_vendorlib}/*

%files devel
%defattr(-,root,root,-)
%doc docs/{html,examples}/
%{_libdir}/libopenscap.so
%{_libdir}/pkgconfig/*.pc
%{_includedir}/openscap
%exclude %{_includedir}/openscap/sce_engine_api.h

%files engine-sce-devel
%defattr(-,root,root,-)
%{_libdir}/libopenscap_sce.so
%{_includedir}/openscap/sce_engine_api.h

%files scanner
%{_mandir}/man8/oscap.8.gz
%{_bindir}/oscap
%{_sysconfdir}/bash_completion.d

%files utils
%defattr(-,root,root,-)
%doc docs/oscap-scan.cron
%{_mandir}/man8/*
%exclude %{_mandir}/man8/oscap.8.gz
%{_bindir}/*
%exclude %{_bindir}/oscap

%files content-sectool
%defattr(-,root,root,-)
%{_datadir}/openscap/sectool-sce

%files extra-probes
%{_libexecdir}/openscap/probe_ldap57
%{_libexecdir}/openscap/probe_gconf

%files extra-probes-sql
%{_libexecdir}/openscap/probe_sql
%{_libexecdir}/openscap/probe_sql57

%files engine-sce
%{_libdir}/libopenscap_sce.so.*

%files selinux
%attr(0600,root,root) %{_datadir}/selinux/packages/oscap.pp
%{_datadir}/selinux/devel/include/contrib/oscap.if
# %{_mandir}/man8/openscap_selinux.8.*

%changelog
* Sat Jan 10 2015 Šimon Lukašík <slukasik@redhat.com> - 1.2.1-1
- upgrade to the latest upstream release

* Tue Dec 02 2014 Šimon Lukašík <slukasik@redhat.com> - 1.2.0-1
- upgrade to the latest upstream release

* Fri Sep 26 2014 Šimon Lukašík <slukasik@redhat.com> - 1.1.1-1
- upgrade to the latest upstream release

* Wed Sep 03 2014 Šimon Lukašík <slukasik@redhat.com> - 1.1.0-1
- upgrade

* Tue Jul 01 2014 Šimon Lukašík <slukasik@redhat.com> - 1.0.9-2
- Extract oscap tool to a separate package (rhbz#1115116)

* Wed Jun 25 2014 Martin Preisler <mpreisle@redhat.com> - 1.0.9-1
- upgrade

* Wed Mar 26 2014 Šimon Lukašík <slukasik@redhat.com> - 1.0.8-1
- upgrade

* Thu Mar 20 2014 Šimon Lukašík <slukasik@redhat.com> - 1.0.7-1
- upgrade

* Wed Mar 19 2014 Šimon Lukašík <slukasik@redhat.com> - 1.0.6-1
- upgrade

* Fri Mar 14 2014 Šimon Lukašík <slukasik@redhat.com> - 1.0.5-1
- upgrade

* Thu Feb 13 2014 Šimon Lukašík <slukasik@redhat.com> - 1.0.4-1
- upgrade

* Tue Jan 14 2014 Šimon Lukašík <slukasik@redhat.com> - 1.0.3-1
- upgrade
- This upstream release addresses: #1052142

* Fri Jan 10 2014 Šimon Lukašík <slukasik@redhat.com> - 1.0.2-1
- upgrade
- This upstream release addresses: #1018291, #1029879, #1026833

* Thu Nov 28 2013 Šimon Lukašík <slukasik@redhat.com> - 1.0.1-1
- upgrade

* Tue Nov 26 2013 Šimon Lukašík <slukasik@redhat.com> - 1.0.0-3
- expand LT_CURRENT_MINUS_AGE correctly

* Thu Nov 21 2013 Šimon Lukašík <slukasik@redhat.com> - 1.0.0-2
- dlopen libopenscap_sce.so.{current-age} explicitly
  That allows for SCE to work without openscap-engine-sce-devel

* Tue Nov 19 2013 Šimon Lukašík <slukasik@redhat.com> - 1.0.0-1
- upgrade
- package openscap-engine-sce-devel separately

* Fri Nov 15 2013 Šimon Lukašík <slukasik@redhat.com> - 0.9.13-7
- do not obsolete openscap-conten just drop it (#1028706)
  scap-security-guide will bring the Obsoletes tag

* Thu Nov 14 2013 Šimon Lukašík <slukasik@redhat.com> - 0.9.13-6
- only non-noarch packages should be requiring specific architecture

* Sat Nov 09 2013 Šimon Lukašík <slukasik@redhat.com> 0.9.13-5
- specify architecture when requiring base package

* Fri Nov 08 2013 Šimon Lukašík <slukasik@redhat.com> 0.9.13-4
- specify dependency between engine and devel sub-package

* Fri Nov 08 2013 Šimon Lukašík <slukasik@redhat.com> 0.9.13-3
- correct openscap-utils dependencies

* Fri Nov 08 2013 Šimon Lukašík <slukasik@redhat.com> 0.9.13-2
- drop openscap-content package (use scap-security-guide instead)

* Fri Nov 08 2013 Šimon Lukašík <slukasik@redhat.com> 0.9.13-1
- upgrade

* Thu Sep 26 2013 Šimon Lukašík <slukasik@redhat.com> 0.9.12-2
- Start building SQL probes for Fedora

* Wed Sep 11 2013 Šimon Lukašík <slukasik@redhat.com> 0.9.12-1
- upgrade

* Sat Aug 03 2013 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 0.9.11-2
- Rebuilt for https://fedoraproject.org/wiki/Fedora_20_Mass_Rebuild

* Thu Jul 18 2013 Petr Lautrbach <plautrba@redhat.com> 0.9.11-1
- upgrade

* Wed Jul 17 2013 Petr Pisar <ppisar@redhat.com> - 0.9.10-2
- Perl 5.18 rebuild

* Mon Jul 15 2013 Petr Lautrbach <plautrba@redhat.com> 0.9.10-1
- upgrade

* Mon Jun 17 2013 Petr Lautrbach <plautrba@redhat.com> 0.9.8-1
- upgrade

* Fri Apr 26 2013 Petr Lautrbach <plautrba@redhat.com> 0.9.7-1
- upgrade
- add openscap-selinux sub-package

* Wed Apr 24 2013 Petr Lautrbach <plautrba@redhat.com> 0.9.6-1
- upgrade

* Wed Mar 20 2013 Petr Lautrbach <plautrba@redhat.com> 0.9.5-1
- upgrade

* Mon Mar 04 2013 Petr Lautrbach <plautrba@redhat.com> 0.9.4.1-1
- upgrade

* Tue Feb 26 2013 Petr Lautrbach <plautrba@redhat.com> 0.9.4-1
- upgrade

* Thu Feb 14 2013 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 0.9.3-2
- Rebuilt for https://fedoraproject.org/wiki/Fedora_19_Mass_Rebuild

* Mon Dec 17 2012 Petr Lautrbach <plautrba@redhat.com> 0.9.3-1
- upgrade

* Wed Nov 21 2012 Petr Lautrbach <plautrba@redhat.com> 0.9.2-1
- upgrade

* Mon Oct 22 2012 Petr Lautrbach <plautrba@redhat.com> 0.9.1-1
- upgrade

* Tue Sep 25 2012 Peter Vrabec <pvrabec@redhat.com> 0.9.0-1
- upgrade

* Mon Aug 27 2012 Petr Lautrbach <plautrba@redhat.com> 0.8.5-1
- upgrade

* Tue Aug 07 2012 Petr Lautrbach <plautrba@redhat.com> 0.8.4-1
- upgrade

* Tue Jul 31 2012 Petr Lautrbach <plautrba@redhat.com> 0.8.3-2
- fix Profile and  @hidden issue

* Mon Jul 30 2012 Petr Lautrbach <plautrba@redhat.com> 0.8.3-1
- upgrade

* Fri Jul 20 2012 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 0.8.2-3
- Rebuilt for https://fedoraproject.org/wiki/Fedora_18_Mass_Rebuild

* Fri Jun 08 2012 Petr Pisar <ppisar@redhat.com> - 0.8.2-2
- Perl 5.16 rebuild

* Fri Mar 30 2012 Petr Lautrbach <plautrba@redhat.com> 0.8.2-1
- upgrade

* Tue Feb 21 2012 Peter Vrabec <pvrabec@redhat.com> 0.8.1-1
- upgrade

* Fri Feb 10 2012 Petr Pisar <ppisar@redhat.com> - 0.8.0-3
- Rebuild against PCRE 8.30

* Fri Jan 13 2012 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 0.8.0-2
- Rebuilt for https://fedoraproject.org/wiki/Fedora_17_Mass_Rebuild

* Tue Oct 11 2011 Peter Vrabec <pvrabec@redhat.com> 0.8.0-1
- upgrade

* Mon Jul 25 2011 Peter Vrabec <pvrabec@redhat.com> 0.7.4-1
- upgrade

* Thu Jul 21 2011 Petr Sabata <contyk@redhat.com> - 0.7.3-3
- Perl mass rebuild

* Wed Jul 20 2011 Petr Sabata <contyk@redhat.com> - 0.7.3-2
- Perl mass rebuild

* Fri Jun 24 2011 Peter Vrabec <pvrabec@redhat.com> 0.7.3-1
- upgrade

* Fri Jun 17 2011 Marcela Mašláňová <mmaslano@redhat.com> - 0.7.2-3
- Perl mass rebuild

* Fri Jun 10 2011 Marcela Mašláňová <mmaslano@redhat.com> - 0.7.2-2
- Perl 5.14 mass rebuild

* Wed Apr 20 2011 Peter Vrabec <pvrabec@redhat.com> 0.7.2-1
- upgrade

* Fri Mar 11 2011 Peter Vrabec <pvrabec@redhat.com> 0.7.1-1
- upgrade

* Thu Feb 10 2011 Peter Vrabec <pvrabec@redhat.com> 0.7.0-1
- upgrade

* Tue Feb 08 2011 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 0.6.8-2
- Rebuilt for https://fedoraproject.org/wiki/Fedora_15_Mass_Rebuild

* Mon Jan 31 2011 Peter Vrabec <pvrabec@redhat.com> 0.6.8-1
- upgrade

* Fri Jan 14 2011 Peter Vrabec <pvrabec@redhat.com> 0.6.7-1
- upgrade

* Wed Oct 20 2010 Peter Vrabec <pvrabec@redhat.com> 0.6.4-1
- upgrade

* Tue Sep 14 2010 Peter Vrabec <pvrabec@redhat.com> 0.6.3-1
- upgrade

* Fri Aug 27 2010 Peter Vrabec <pvrabec@redhat.com> 0.6.2-1
- upgrade

* Wed Jul 14 2010 Peter Vrabec <pvrabec@redhat.com> 0.6.0-1
- upgrade

* Wed May 26 2010 Peter Vrabec <pvrabec@redhat.com> 0.5.11-1
- upgrade

* Fri May 07 2010 Peter Vrabec <pvrabec@redhat.com> 0.5.10-1
- upgrade

* Fri Apr 16 2010 Peter Vrabec <pvrabec@redhat.com> 0.5.9-1
- upgrade

* Fri Feb 26 2010 Peter Vrabec <pvrabec@redhat.com> 0.5.7-1
- upgrade
- new utils package

* Mon Jan 04 2010 Peter Vrabec <pvrabec@redhat.com> 0.5.6-1
- upgrade

* Tue Sep 29 2009 Peter Vrabec <pvrabec@redhat.com> 0.5.3-1
- upgrade

* Wed Aug 19 2009 Peter Vrabec <pvrabec@redhat.com> 0.5.2-1
- upgrade

* Mon Aug 03 2009 Peter Vrabec <pvrabec@redhat.com> 0.5.1-2
- add rpm-devel requirement

* Mon Aug 03 2009 Peter Vrabec <pvrabec@redhat.com> 0.5.1-1
- upgrade

* Thu Apr 30 2009 Peter Vrabec <pvrabec@redhat.com> 0.3.3-1
- upgrade

* Thu Apr 23 2009 Peter Vrabec <pvrabec@redhat.com> 0.3.2-1
- upgrade

* Sun Mar 29 2009 Peter Vrabec <pvrabec@redhat.com> 0.1.4-1
- upgrade

* Fri Mar 27 2009 Peter Vrabec <pvrabec@redhat.com> 0.1.3-2
- spec file fixes (#491892)

* Tue Mar 24 2009 Peter Vrabec <pvrabec@redhat.com> 0.1.3-1
- upgrade

* Thu Jan 15 2009 Tomas Heinrich <theinric@redhat.com> 0.1.1-1
- Initial rpm

