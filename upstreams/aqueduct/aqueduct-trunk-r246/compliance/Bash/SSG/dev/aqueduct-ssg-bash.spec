Summary: Aqueduct SCAP Security Guide bash remediation scripts
Name: aqueduct-ssg-bash
Version: 0.5.1
Release: 0
License: LGPL
Group: Development/Tools
Source: aqueduct-ssg-bash.tgz
BuildArch: noarch
URL: https://fedorahosted.org/aqueduct/

%description
Aqueduct SCAP Security Guide bash remediation scripts

%install
mkdir -p $RPM_BUILD_ROOT/usr/local/bin/aqueduct-ssg-bash
(cd $RPM_BUILD_ROOT/usr/local/bin && tar xf $RPM_SOURCE_DIR/aqueduct-ssg-bash.tgz) 
          
%files
%defattr(0755,root,root,0755)
%dir /usr/local/bin/aqueduct-ssg-bash
/usr/local/bin/aqueduct-ssg-bash/*
          
%changelog
* Mon May 14 2012 Joe Nall <joe@nall.com>
-New

