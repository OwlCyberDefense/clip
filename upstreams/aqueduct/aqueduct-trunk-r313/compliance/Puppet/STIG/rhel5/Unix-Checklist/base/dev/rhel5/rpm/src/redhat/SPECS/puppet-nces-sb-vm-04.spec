Name:           puppet-stig
Version:        1
Release:        28%{?dist}
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
The puppet, based on Tresys CLIP content will address STIG configuration items on RHEL 5.x servers.


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
#tar zxf puppet-stig.tar.gz
#rm -f puppet-stig.tar.gz
#mv puppet/* ./

%preun
if [ $1 = 0 ]; then
	if [ -d /etc/puppet/manifests ]; then
	  rm -rf /etc/puppet/manifests /etc/puppet/modules*
	fi
fi


%files
%defattr(-,root,root,-)
   /etc/puppet/modules/site/GROUP/manifests/init.pp
   /etc/puppet/modules/hosts/NCES-SAT-01/manifests/init.pp
   /etc/puppet/modules/hosts/NCES-SAT-01/templates/RPM-GPG-KEY-EPEL
   /etc/puppet/modules/hosts/NCES-SAT-01/templates/SPAWAR1.cert
   /etc/puppet/modules/hosts/NCES-SAT-01/templates/answer.txt
   /etc/puppet/modules/hosts/NCES-SAT-01/templates/forge-cert.p12
   /etc/puppet/modules/hosts/NCES-SAT-01/templates/sat-inventory.sh
   /etc/puppet/modules/hosts/NCES-SAT-01/templates/satellite-sync-cron.sh
   /etc/puppet/modules/hosts/NCES-SAT-01/templates/servers
   /etc/puppet/modules/hosts/NCES-SAT-01/templates/spacecmd-1.3.7-1.el5.noarch.rpm
   /etc/puppet/modules/hosts/NCES-SAT-01/templates/uvscan.sh
   /etc/puppet/modules/hosts/NCES-SB-VM-01/manifests/init.pp
   /etc/puppet/modules/hosts/NCES-SB-VM-01/templates/RPM-GPG-KEY-EPEL
   /etc/puppet/modules/hosts/NCES-SB-VM-01/templates/SPAWAR2.cert
   /etc/puppet/modules/hosts/NCES-SB-VM-01/templates/answer.txt
   /etc/puppet/modules/hosts/NCES-SB-VM-01/templates/forge-cert.p12
   /etc/puppet/modules/hosts/NCES-SB-VM-01/templates/sat-inventory.sh
   /etc/puppet/modules/hosts/NCES-SB-VM-01/templates/uvscan.sh
   /etc/puppet/modules/hosts/NCES-SB-VM-02/manifests/init.pp
   /etc/puppet/modules/hosts/NCES-SB-VM-02/templates/RPM-GPG-KEY-EPEL
   /etc/puppet/modules/hosts/NCES-SB-VM-02/templates/SPAWAR3.cert
   /etc/puppet/modules/hosts/NCES-SB-VM-02/templates/answer.txt
   /etc/puppet/modules/hosts/NCES-SB-VM-02/templates/forge-cert.p12
   /etc/puppet/modules/hosts/NCES-SB-VM-02/templates/sat-inventory.sh
   /etc/puppet/modules/hosts/NCES-SB-VM-02/templates/uvscan.sh
   /etc/puppet/modules/hosts/NCES-UTIL-01/manifests/init.pp
   /etc/puppet/modules/hosts/NCES-UTIL-01/templates/SPAWAR1.cert
   /etc/puppet/modules/hosts/NCES-UTIL-01/templates/answer.txt
   /etc/puppet/modules/hosts/NCES-UTIL-01/templates/forge-cert.p12
   /etc/puppet/modules/hosts/NCES-UTIL-01/templates/nces-sb-vm-01.cert
   /etc/puppet/modules/hosts/NCES-UTIL-01/templates/nces-sb-vm-02.cert
   /etc/puppet/modules/hosts/NCES-UTIL-01/templates/nrpe.cfg
   /etc/puppet/modules/hosts/NCES-UTIL-01/templates/sat-inventory.sh
   /etc/puppet/modules/hosts/NCES-UTIL-01/templates/servers
   /etc/puppet/modules/hosts/NCES-UTIL-01/templates/snmpd.conf
   /etc/puppet/modules/hosts/NCES-UTIL-01/templates/spacecmd-1.3.7-1.el5.noarch.rpm
   /etc/puppet/modules/hosts/NCES-UTIL-01/templates/up2date.nces-sb-vm-01
   /etc/puppet/modules/hosts/NCES-UTIL-01/templates/up2date.nces-sb-vm-02
   /etc/puppet/modules/hosts/NCES-UTIL-01/templates/uvscan.sh
   /etc/puppet/modules/site/FILES/manifests/init.pp
   /etc/puppet/modules/site/FILES/templates/nrpe.cfg
   /etc/puppet/modules/site/FILES/templates/snmpd.conf
   /etc/puppet/modules/site/FILES/templates/GPG-SPAWAR-KEY
   /etc/puppet/modules/site/FILES/templates/RPM-GPG-KEY-EPEL
   /etc/puppet/modules/site/FILES/templates/VMWARE-PACKAGING-GPG-KEY.pub
   /etc/puppet/modules/site/FILES/templates/bacula-fd.conf
   /etc/puppet/modules/site/FILES/templates/hosts
   /etc/puppet/modules/site/FILES/templates/id_rsa
   /etc/puppet/modules/site/FILES/templates/id_rsa.pub
   /etc/puppet/modules/site/FILES/templates/install-linux-45-1470
   /etc/puppet/modules/site/FILES/templates/issue
   /etc/puppet/modules/site/FILES/templates/issue.net
   /etc/puppet/modules/site/FILES/templates/ntp.conf
   /etc/puppet/modules/site/FILES/templates/puppet.sh
   /etc/puppet/modules/site/FILES/templates/resolv.conf
   /etc/puppet/modules/site/FILES/templates/sendmail.cf
   /etc/puppet/modules/site/FILES/templates/sosreport.sh
   /etc/puppet/modules/site/FILES/templates/step-tickers
   /etc/puppet/modules/site/FILES/templates/sudoers
   /etc/puppet/modules/site/FILES/templates/uvscan.sh
   /etc/puppet/modules/site/FILES/templates/yum.rb
   /etc/puppet/modules/site/LNX00140/manifests/init.pp
   /etc/puppet/modules/site/MOD/manifests/init.pp
   /etc/puppet/modules/site/PROJECT/manifests/init.pp
   /etc/puppet/modules/site/RUN/manifests/init.pp
   /etc/puppet/modules/site/SERVICE/manifests/init.pp
   /etc/puppet/modules/site/SW/manifests/init.pp
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
   /etc/puppet/manifests/nces-sat-01.pp
   /etc/puppet/manifests/site.pp
   /etc/puppet/manifests/stig.pp
   /var/lib/puppet/lib/puppet/type/append_if_no_such_line.rb

# %doc

%changelog
* Thu Mar 03 2011 Aaron Prayther <aprayther@lce.com - 1-12
-Modifying the suders file being delivered

* Thu Feb 24 2011 Aaron Prayther <aprayther@lce.com - 1-1
-first stab
