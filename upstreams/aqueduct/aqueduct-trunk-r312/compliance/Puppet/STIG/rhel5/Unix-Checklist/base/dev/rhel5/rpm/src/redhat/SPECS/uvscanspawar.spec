Name:           uvscanspawar
Version:        6.0.3.356
Release:        16%{?dist}
Summary:        McAfee anti virus scanner 64bit
Packager:       Aaron Prayther aprayther@lce.com Life Cycle Engineering
Group:          Development/Tools
License:        Commercial
URL:            https://infosec.navy.mil/av/index.jsp?t=bc_mcafeesw.html
Source0:        $RPM_SOURCE_DIR/vscl-l64-6.0.3-l.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}
BuildArch:      x86_64
# BuildRequires:
Requires:       avvdatspawar >= 6076

%description
Installs uvscan in /usr/local/uvscan. A cron job, uvscan.sh, to run this is dealt with separately in puppet.
downloaded from https://infosec.navy.mil/av/index.jsp?t=bc_mcafeesw.html, there are 32 & 64 bit here.

%prep
rm -rf $RPM_BUILD_ROOT
mkdir $RPM_BUILD_ROOT

# this is just taking a src file and moving it around /src/redhat/* and /var/tmp/ to keep things straight.. then cleanup.
%install
rm -rf $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-%(%{__id_u} -n)/
mkdir $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-%(%{__id_u} -n)
cp $RPM_SOURCE_DIR/vscl-*.tar.gz $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-%(%{__id_u} -n)/
cp $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-%(%{__id_u} -n)/* %{_tmppath}/%{name}-%{version}-%{release}/
rm -rf $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-%(%{__id_u} -n)/

%clean
rm -rf $RPM_BUILD_ROOT

# this is on the client, right after the rpm package makes it to the client and runs.
%post
mkdir /tmp/uvscan
mv /vscl-*.tar.gz /tmp/uvscan
cd /tmp/uvscan && tar zxf /tmp/uvscan/vscl-*.tar.gz
rm -f /tmp/uvscan/vscl-*.tar.gz
mkdir -p /usr/local/uvscan/
mv /tmp/uvscan/* /usr/local/uvscan/
rm -rf /tmp/uvscan

# this is the uninstall or upgrade from the perspective of: yum remove or yum upgrade on the client
%preun
if [ $1 = 0 ]; then
        if [ -d /usr/local/uvscan/ ]; then
	  for i in `ls /usr/local/uvscan/ | grep -v avv*.dat | grep -v legal.txt`;do rm -f /usr/local/uvscan/$i;done
        fi
fi

%files
%defattr(-,root,root,-)
/vscl-l64-6.0.3-l.tar.gz

# %doc

%changelog
* Thu Feb 24 2011 Aaron Prayther <aprayther@lce.com - 6.0.3.356-9
-first stab

