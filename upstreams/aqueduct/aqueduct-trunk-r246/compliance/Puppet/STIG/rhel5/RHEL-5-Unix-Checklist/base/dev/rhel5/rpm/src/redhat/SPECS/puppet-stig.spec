Name:           puppet-stig
Version:        1
Release:        29%{?dist}
Summary:        STIG puppet content
Packager:	Aaron Prayther aprayther@lce.com Life Cycle Engineering
Group:          Development/Tools
License:        GPL
URL:            https://software.forge.mil/DoDBastile
Source0:        $RPM_SOURCE_DIR/puppet-stig
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:	noarch
#BuildRequires:  
Requires:       puppet >= 0.25

%description
The puppet content, based on Tresys CLIP content will address STIG configuration items on RHEL 5.x servers.


%prep
rm -rf $RPM_BUILD_ROOT
mkdir $RPM_BUILD_ROOT

%install
rm -rf $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)/
mkdir $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
#cp $RPM_SOURCE_DIR/puppet-stig.tar.gz $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)/
rsync -av $RPM_SOURCE_DIR/puppet-stig/* $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)/
rsync -av $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)/* %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)/
rm -rf $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)/

%clean
rm -rf $RPM_BUILD_ROOT

%post

%preun
if [ $1 = 0 ]; then
	if [ -d /etc/puppet/manifests ]; then
	  rm -rf /etc/puppet/manifests /etc/puppet/modules/stig/*
	fi
fi


%files
%defattr(-,root,root,-)

   /etc/puppet/modules/stig/AC-11/manifests/init.pp
   /etc/puppet/modules/stig/AC-15/files/cupsd.conf
   /etc/puppet/modules/stig/AC-15/manifests/init.pp
   /etc/puppet/modules/stig/AC-17/manifests/init.pp
   /etc/puppet/modules/stig/AC-3/manifests/init.pp
   /etc/puppet/modules/stig/AC-3/templates/sa1
   /etc/puppet/modules/stig/AC-3/templates/sa2
   /etc/puppet/modules/stig/AC-3/templates/sysstat
   /etc/puppet/modules/stig/AC-7/manifests/init.pp
   /etc/puppet/modules/stig/AC-7/templates/system-auth.tpl
   /etc/puppet/modules/stig/AC-8/files/Default.sed
   /etc/puppet/modules/stig/AC-8/files/issue
   /etc/puppet/modules/stig/AC-8/files/issue.net
   /etc/puppet/modules/stig/AC-8/manifests/init.pp
   /etc/puppet/modules/stig/AU-2/files/auditd.conf
   /etc/puppet/modules/stig/AU-2/manifests/init.pp
   /etc/puppet/modules/stig/AU-2/templates/audit.rules
   /etc/puppet/modules/stig/GEN000020/manifests/init.pp
   /etc/puppet/modules/stig/GEN000440/manifests/init.pp
   /etc/puppet/modules/stig/GEN000920/manifests/init.pp
   /etc/puppet/modules/stig/GEN000980/manifests/init.pp
   /etc/puppet/modules/stig/GEN001080/manifests/init.pp
   /etc/puppet/modules/stig/GEN001280/manifests/init.pp
   /etc/puppet/modules/stig/GEN001460/manifests/init.pp
   /etc/puppet/modules/stig/GEN001560/manifests/init.pp
   /etc/puppet/modules/stig/GEN001580/manifests/init.pp
   /etc/puppet/modules/stig/GEN0017x0/manifests/init.pp
   /etc/puppet/modules/stig/GEN001800/manifests/init.pp
   /etc/puppet/modules/stig/GEN001820/manifests/init.pp
   /etc/puppet/modules/stig/GEN002040/manifests/init.pp
   /etc/puppet/modules/stig/GEN002120/files/shells
   /etc/puppet/modules/stig/GEN002120/manifests/init.pp
   /etc/puppet/modules/stig/GEN002320/manifests/init.pp
   /etc/puppet/modules/stig/GEN002560/manifests/init.pp
   /etc/puppet/modules/stig/GEN002640/manifests/init.pp
   /etc/puppet/modules/stig/GEN002860/files/audit.logrotate
   /etc/puppet/modules/stig/GEN002860/manifests/init.pp
   /etc/puppet/modules/stig/GEN003040/manifests/init.pp
   /etc/puppet/modules/stig/GEN003180/manifests/init.pp
   /etc/puppet/modules/stig/GEN003340/manifests/init.pp
   /etc/puppet/modules/stig/GEN003400/manifests/init.pp
   /etc/puppet/modules/stig/GEN003500/manifests/init.pp
   /etc/puppet/modules/stig/GEN003520/manifests/init.pp
   /etc/puppet/modules/stig/GEN003700/manifests/init.pp
   /etc/puppet/modules/stig/GEN003740/manifests/init.pp
   /etc/puppet/modules/stig/GEN003760/manifests/init.pp
   /etc/puppet/modules/stig/GEN003860/manifests/init.pp
   /etc/puppet/modules/stig/GEN004360/manifests/init.pp
   /etc/puppet/modules/stig/GEN004440/manifests/init.pp
   /etc/puppet/modules/stig/GEN004480/manifests/init.pp
   /etc/puppet/modules/stig/GEN004540/manifests/init.pp
   /etc/puppet/modules/stig/GEN004560/manifests/init.pp
   /etc/puppet/modules/stig/GEN004580/manifests/init.pp
   /etc/puppet/modules/stig/GEN004640/manifests/init.pp
   /etc/puppet/modules/stig/GEN004880/manifests/init.pp
   /etc/puppet/modules/stig/GEN005000/manifests/init.pp
   /etc/puppet/modules/stig/GEN005360/manifests/init.pp
   /etc/puppet/modules/stig/GEN0054x0/manifests/init.pp
   /etc/puppet/modules/stig/GEN0057x0/manifests/init.pp
   /etc/puppet/modules/stig/GEN006100/manifests/init.pp
   /etc/puppet/modules/stig/GEN006160/manifests/init.pp
   /etc/puppet/modules/stig/GEN006260/manifests/init.pp
   /etc/puppet/modules/stig/GEN006280/manifests/init.pp
   /etc/puppet/modules/stig/GEN006300/manifests/init.pp
   /etc/puppet/modules/stig/GEN006320/manifests/init.pp
   /etc/puppet/modules/stig/GEN006340/manifests/init.pp
   /etc/puppet/modules/stig/IA-2/manifests/init.pp
   /etc/puppet/modules/stig/LNX00160/manifests/init.pp
   /etc/puppet/modules/stig/LNX00220/manifests/init.pp
   /etc/puppet/modules/stig/LNX00320/manifests/init.pp
   /etc/puppet/modules/stig/LNX00340/manifests/init.pp
   /etc/puppet/modules/stig/LNX00360/files/custom.conf
   /etc/puppet/modules/stig/LNX00360/manifests/init.pp
   /etc/puppet/modules/stig/LNX00400/manifests/init.pp
   /etc/puppet/modules/stig/LNX00480/manifests/init.pp
   /etc/puppet/modules/stig/LNX00580/manifests/init.pp
   /etc/puppet/modules/stig/SC-5/manifests/init.pp
   /etc/puppet/COPYING
   /etc/puppet/manifests/stig.pp
   /var/lib/puppet/lib/puppet/type/append_if_no_such_line.rb

# %doc

%changelog
* Mon Mar 14 2011 Aaron Prayther <aprayther@lce.com - 1-29
-separated out the site and host puppet content

* Thu Mar 03 2011 Aaron Prayther <aprayther@lce.com - 1-12
-Modifying the suders file being delivered

* Thu Feb 24 2011 Aaron Prayther <aprayther@lce.com - 1-1
-first stab
