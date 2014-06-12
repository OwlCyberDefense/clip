Name:	webpageexample	
Version: 1
Release: 1
Summary: CLIP Module for a webserver.
Requires: dracut, httpd, php 

License: GPL or BSD
Group: System Environment/Base

BuildRequires: make, coreutils
BuildRoot: %{_tmppath}/%{name}-root

Source0: %{pkgname}-%{version}.tgz

%description
This is the package for webserver content files.


%prep
%setup -q -n %{pkgname}

%build

%install
mkdir -p $RPM_BUILD_ROOT/usr/share/webpageex/rootfiles
cp -r * $RPM_BUILD_ROOT/usr/share/webpageex/rootfiles

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(755,root,root,-)
#mkdir -p /usr/share/webpageex/rootfiles/%{_sysconfdir}/httpd/
#/usr/share/webpageex/rootfiles/%{_sysconfdir}/httpd/*
#/usr/share/webpageex/rootfiles/%{_sysconfdir}/php.ini
#/usr/share/webpageex/rootfiles/%{_sysconfdir}/extras/*
#mkdir -p /usr/share/webpageex/rootfiles/var/www/
/usr/share/webpageex/rootfiles/var/www/html/*


%post
cp -ra /usr/share/webpageex/rootfiles/* /

#php.ini copy
#cp -r /usr/share/webpageex/rootfiles/etc/php.ini /etc/php.ini 

#extras copy
#cp -r /usr/share/webpageex/rootfiles/extras/ /home/toor/extras/

#cp -ru /usr/share/webpageex/rootfiles/etc/httpd/* /etc/httpd/
#cd /etc/httpd/
#rm modules
#ln -s /usr/lib64/httpd/modules

mkdir /var/www/webpage/
cp -ru /usr/share/webpageex/rootfiles/var/www/webpage/* /var/www/webpage/


%changelog
* Wed Jun 11 2014 John Feehley <jfeehley@quarksecurity.com>
- Changed to workingexample files for CLIP and  spec. 

* Mon Jul 15 2013 Spencer Shimko <spencer@quarksecurity.com> 1-1
- Initial dracut module for CLIP and spec.
