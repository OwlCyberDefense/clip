Name:           avvdatspawar
Version:        6271
Release:        5%{?dist}
Summary:        McAfee anti virus scanner dat file
Packager:       Aaron Prayther aprayther@lce.com Life Cycle Engineering
Group:          Development/Tools
License:        GPL
URL:            https://software.forge.mil/DoDBastile
Source0:        $RPM_SOURCE_DIR/avvdat-6271.tar
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}
BuildArch:      noarch
# BuildRequires:
Requires:       uvscanspawar >= 6.0.3.356

%description
Installs avvdat-* from McAffee

%prep
rm -rf $RPM_BUILD_ROOT
mkdir $RPM_BUILD_ROOT

# this is just taking a src file and moving it around /src/redhat/* and /var/tmp/ to keep things straight.. then cleanup.
%install
rm -rf $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-%(%{__id_u} -n)/
mkdir $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-%(%{__id_u} -n)
cp $RPM_SOURCE_DIR/avvdat-*.tar $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-%(%{__id_u} -n)/
cp $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-%(%{__id_u} -n)/* %{_tmppath}/%{name}-%{version}-%{release}/
rm -rf $RPM_SOURCE_DIR/%{name}-%{version}-%{release}-%(%{__id_u} -n)/

%clean
rm -rf $RPM_BUILD_ROOT

# this is on the client, right after the rpm package makes it to the client and runs.
%post
mkdir /tmp/uvscan
mv /avvdat-*.tar /tmp/uvscan
cd /tmp/uvscan && tar xf avvdat-*.tar
rm -f /tmp/uvscan/avvdat-*.tar
mkdir -p /usr/local/uvscan/
mv /tmp/uvscan/* /usr/local/uvscan/
rm -rf /tmp/uvscan

# this is the uninstall or upgrade from the perspective of: yum remove or yum upgrade on the client
%preun
if [ $1 = 0 ]; then
        if [ -d /usr/local/uvscan/ ]; then
          rm -rf /usr/local/uvscan/avv*.dat /usr/local/uvscan/legal.txt
        fi
fi

%files
%defattr(-,root,root,-)
/avvdat-6271.tar
# %doc

%changelog
* Thu Feb 24 2011 Aaron Prayther <aprayther@lce.com - 6271-1
-first stab
