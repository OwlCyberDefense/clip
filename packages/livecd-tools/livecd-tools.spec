%{!?python_sitelib: %define python_sitelib %(%{__python} -c "import distutils.sysconfig as d; print d.get_python_lib()")}

%define debug_package %{nil}

Summary: Tools for building live CDs
Name: livecd-tools
Version: 13.4.4
Release: 99%{?dist}
Epoch: 1
License: GPLv2
Group: System Environment/Base
URL: http://git.fedorahosted.org/git/livecd
# To make source tar ball:
# git clone git://git.fedorahosted.org/livecd
# cd livecd
# make dist
# scp livecd*.tar.bz2 fedorahosted.org:livecd
Source0: http://fedorahosted.org/releases/l/i/livecd/%{name}-%{version}.tar.bz2
Patch0: lokkit-fw-no-reset.patch
Patch1: dracut-live-fix.patch
Patch2: kargs-and-boot-menu.patch
Patch3: setfiles-force-all-bits.patch
Patch4: add-live-sata-mods.patch
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root
Requires: python-imgcreate = %{epoch}:%{version}-%{release}
Requires: mkisofs
Requires: isomd5sum
Requires: parted
Requires: pyparted
Requires: util-linux
%ifarch %{ix86} x86_64
Requires: syslinux
Requires: /sbin/extlinux
%endif
%ifarch ppc
Requires: yaboot
%endif
BuildRequires: python
BuildRequires: /usr/bin/pod2man


%description 
Tools for generating live CDs on Fedora based systems including
derived distributions such as RHEL, CentOS and others. See
http://fedoraproject.org/wiki/FedoraLiveCD for more details.

%package -n python-imgcreate
Summary: Python modules for building system images
Group: System Environment/Base
Requires: util-linux
Requires: coreutils
Requires: e2fsprogs
Requires: yum >= 3.2.18
Requires: squashfs-tools
Requires: pykickstart >= 0.96
Requires: dosfstools >= 2.11-8
Requires: system-config-keyboard >= 1.3.0
Requires: python-urlgrabber
Requires: libselinux-python
Requires: dbus-python
Requires: dracut

%description -n python-imgcreate
Python modules that can be used for building images for things
like live image or appliances.


%prep
%setup -q
%patch0 -p1 -b .fwfix
%patch1 -p1
%patch2 -p1
%patch3 -p1
%patch4 -p1

%build
make

%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%doc AUTHORS COPYING README HACKING
%doc config/livecd-fedora-minimal.ks
%{_mandir}/man*/*
%{_bindir}/livecd-creator
%{_bindir}/livecd-iso-to-disk
%{_bindir}/livecd-iso-to-pxeboot
%{_bindir}/image-creator
%{_bindir}/liveimage-mount
%{_bindir}/mkbiarch
%{_bindir}/mkefiboot

%files -n python-imgcreate
%defattr(-,root,root,-)
%doc API COPYING
%dir %{python_sitelib}/imgcreate
%{python_sitelib}/imgcreate/*.py
%{python_sitelib}/imgcreate/*.pyo
%{python_sitelib}/imgcreate/*.pyc

%changelog
* Thu May 23 2013 Brian C. Lane <bcl@redhat.com> 13.4.4-2
- Version 13.4.4 (bcl)
- Avoid setting empty root password (#962493) (thoger)
- Update spec for mkefiboot

* Tue Aug 28 2012 Seth Vidal <skvidal at fedoraproject.org>
- fix firewalls being reset when setting selinux state from imgcreate

* Tue Aug 23 2011 Brian C. Lane <bcl@redhat.com> - 13.4-1
- Version 13.4 (bcl)
- Use copyFile on the iso (bcl)
- Add EFI support to netboot and DVD iso (bcl)
- Use rsync to copy if available (bcl)
- Support /EFI/BOOT or /EFI/boot (#688258) (bcl)
- gptmbr can be written directly to the mbr (bcl)
- Ensure previous filesystems are wiped when formatting (#712553) (bcl)
- Turn on the legacy_boot flag for EFI (#680563) (bcl)
- Copy updates and product image files (bcl)

* Wed Jun 01 2011 Brian C. Lane <bcl@redhat.com> - 13.3-1
- Version 13.3 (bcl)
- extlinux doesn't support ext4 or btrfs on F13 (#709778) (bcl)

* Wed Feb 23 2011 Brian C. Lane <bcl@redhat.com> - 13.2-1
- Version 13.2 (bcl)
- Print reason for sudden exit (bcl)
- Fix skipcopy usage with DVD iso (#644194) (bmj001)
- Move selinux relabel to after %post (#648591) (bcl)
- Add support for virtio disks to livecd (#672936) (bcl)
- Check return value on udevadm (#637258) (bcl)
- Source may be a file or a block device, mount accordingly (bcl)
- Align start of partition at 1MiB (#668967) (bcl)
- Check for one big initrd.img (#671900) (bcl)
- Update documentation for xz availability. (bruno)
- Change releasever to a command line option (#667474) (bcl)
- Assign a device-mapper UUID w/ subsystem prefix to the dm snapshot. (dlehman)
- Fix git URLs to match reality. (dlehman)

* Wed Dec 22 2010 Brian C. Lane <bcl@redhat.com> - 13.1-1
- Version 13.1 (bcl)
- Trap copyFile errors (#663849) (fgrose)
- Create tmpdir if it doesn't exist (#658632) (bcl)
- Fix partition number selection for MMC bus devices (#587411) (fgrose)
- Tolerate empty transactions (lkundrak)

* Mon Nov 15 2010 Brian C. Lane <bcl@redhat.com> - 13.0-1
- Change version for f13-branch (bcl)
- Misc. fixups (#652522) (fgrose)
- Set indentation to 4 spaces (#652522) (fgrose)
- Add a release target (bcl)
- Pass dracut args during check (#589778) (bcl)
- Cleanup EOL spaces (#652522) (fgrose)
- Typo. Need space before ]. (bruno)
- Add support for timeout and totaltimeout to livecd-iso-to-disk (#531566)
  (bcl)

* Mon Nov 01 2010 Brian C. Lane <bcl@redhat.com> - 0.3.5-1
- Converting version number to NVR
- Removed patches (now included in v0.3.5)

* Sun Sep 26 2010 Bruno Wolff III <bruno@wolff.to> - 034-11
- Fix live image relabel when compose host has selinux disabled.

* Tue Sep 21 2010 Bruno Wolff III <bruno@wolff.to> - 034-10
- Document the lzo compressor.

* Thu Sep 16 2010 Bruno Wolff III <bruno@wolff.to> - 034-9
- Change requires to /sbin/extlinux since that will work with old and new
  versions of syslinux.

* Thu Sep 16 2010 Bruno Wolff III <bruno@wolff.to> - 034-8
- extlinux is now in a subpackage that is required by livecd-iso-to-disk

* Tue Sep 14 2010 Tom "spot" Callaway <tcallawa@redhat.com> - 034-7
- fix background image copying to use new-new logo path

* Tue Sep 14 2010 Bruno Wolff III <bruno@wolff.to> - 034-6
- One /dev/loop* change had been missed. Backport patch.

* Mon Sep 13 2010 Bruno Wolff III <bruno@wolff.to> - 034-5
- Backport basic video menu label fix

* Mon Sep 13 2010 Bruno Wolff III <bruno@wolff.to> - 034-4
- Backport missing parts of the regex fix patch

* Mon Sep 13 2010 Bruno Wolff III <bruno@wolff.to> - 034-3
- Backported fix for vesa boot menu item

* Sun Sep 12 2010 Bruno Wolff III <bruno@wolff.to> - 034-2
- mkbiarch needs pyparted

* Sat Sep 11 2010 Bruno Wolff III <bruno@wolff.to> - 034-1
- A new experimental script for creating live images.
- Handle partition devices that have a separator character in them.
- Initial checkin of a new expermiental tool for live backup images.
- Allow use of stage2 for repos to help with netinst ISOs.
- Fix issue with using netinst ISOs.
- Add support for ext4 now that syslinux supports it.
- Fix for enumerating loop devices using bash 4.1.7.
- Change --skipcopy to not overwrite other large areas.
- Add basic video driver option to syslinux/isolinux.
- Don't create sparse files one byte too large.
- Display progress information when copying image to USB devices.
- Set default boot language for USB images to the current locale.
- Use grep instead of depreceated egrep.
- Set up locale or there can be problems handling nonascii strings.
- Try normal umount before falling back to lazy umount.
- Allow creation of SELinux enabled LiveCD from an SELinux disabled system.

* Tue Jul 30 2010 Bruno Wolff III <bruno@wolff.to> - 033-3
- The previous update got replaced by the python update; another bump is needed.

* Tue Jul 27 2010 Bruno Wolff III <bruno@wolff.to> - 033-2
- Replace 'zlib' with 'gzip' to fix thinko about the compressor name.

* Tue Jul 27 2010 Bruno Wolff III <bruno@wolff.to> - 033-1
- Fix for vesa splash file change for bz 617115.
- Use lazy umounts as a work around for bz 617844.
- Better handling of Environment exceptions for bz 551932.

* Wed Jul 21 2010 David Malcolm <dmalcolm@redhat.com> - 032-5
- Rebuilt for https://fedoraproject.org/wiki/Features/Python_2.7/MassRebuild

* Sat Jun 19 2010 Bruno Wolff III <bruno@wolff.to> - 032-4
- liveimage-mount is new to 023

* Sat Jun 19 2010 Bruno Wolff III <bruno@wolff.to> - 032-3
- Change the version in the Makefile

* Sat Jun 19 2010 Bruno Wolff III <bruno@wolff.to> - 032-2
- Fix tar prefix and document how to make it

* Sat Jun 19 2010 Bruno Wolff III <bruno@wolff.to> - 032-1
- Added support for specifying compressors
- Add Requires for parted - Bug 605639
- Add rd_NO_DM dracut cmdline options - Bug 589783
- See http://git.fedorahosted.org/git/?p=livecd;a=shortlog for a list of
  upstream commits since 031 was tagged.

* Tue Nov 03 2009 Warren Togami <wtogami@redhat.com> - 031-1
- livecd-iso-to-disk capable of installing installer DVD to USB

* Mon Oct 19 2009 Warren Togami <wtogami@redhat.com> - 030-1
- Tell dracut not to ask for LUKS passwords or activate mdraid sets
- Silence the /etc/modprobe.conf deprecation warning

* Wed Sep 16 2009 Warren Togami <wtogami@redhat.com> - 028-1
- Fix LiveUSB with live images
- Fix display of free space during livecd-iso-to-disk error (farrell)

* Tue Sep 15 2009 Warren Togami <wtogami@redhat.com> - 027-2
- test patch to make LiveUSB work again, need to be sure it doesn't
  break LiveCD before committing in the next version

* Thu Sep 10 2009 Warren Togami <wtogami@redhat.com> - 027-1
- Support new dracut output filename /boot/initramfs-*
- Fix cleanup of fake /selinux directory during teardown Bug #522224

* Mon Aug 24 2009 Jeremy Katz <katzj@redhat.com> - 026-1
- More resize2fs -M usage
- Work with dracut-based initramfs
- Some error handling updates

* Thu Jul 30 2009 Jeremy Katz <katzj@redhat.com> - 025-1
- Bind mount /dev/shm also (#502921)
- Update man pages (Michel Duquaine, #505742)
- Use blkid instead of vol_id (mclasen, #506360)
- A few livecd-iso-to-disk tweaks (Martin Dengler, Jason Farrell)
- Another fix for SELinux being disabled (#508402)
- Use resize2fs -M and handle resize errors better
- Use isohybrid on the live image 
- Use system-config-keyboard instead of rhpl

* Sat Jul 25 2009 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 024-2
- Rebuilt for https://fedoraproject.org/wiki/Fedora_12_Mass_Rebuild

* Wed May  6 2009 Jeremy Katz <katzj@redhat.com> - 024-1
- Fix ppc image creation (#497193, help from jwboyer)
- Fixes for using ext[23] usb stick (wtogami)
- Check filesystem after resizing and raise an error if there are 
  problems (#497377)

* Tue Apr 14 2009 Jeremy Katz <katzj@redhat.com> - 023-1
- Don't prompt about overwriting when making usb stick (#491234)
- Fix up livecd-iso-to-pxeboot for new syslinux paths
- Fix --xo variable expansion (Alexander Boström)
- Name of EFI partitions doesn't matter for mactel mode (Jim Radford)
- Fix unterminated sed command (#492376)
- Handle kernel/squashfs mismatch when making usb stick in
  --xo mode (Alexander Boström)
- Support all of the options for the 'firewall' kickstart directive
- Deal with syslinux com32 api incompat when making usb sticks (#492370)
- Add options to force fetching of repomd.xml every run (jkeating)
- Quiet restorecon (Marc Herbert)
- Fix traceback with syslinux disabled (#495269)
- Split python-imgcreate module into a subpackage

* Mon Mar  9 2009 Jeremy Katz <katzj@redhat.com> - 022-1
- Fixes for hybird GPT/MBR usb sticks (Stewart Adam)
- Support setting SELinux booleans (Dan Walsh)
- Fix unicode error messages (Felix Schwarz)
- Update man pages (Chris Curran, #484627)
- Support syslinux under /usr/share
- Remove some legacy support from livecd-iso-to-disk
- Basic support for multi-image usb sticks

* Wed Feb 25 2009 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 021-2
- Rebuilt for https://fedoraproject.org/wiki/Fedora_11_Mass_Rebuild

* Mon Jan 19 2009 Jeremy Katz <katzj@redhat.com> - 021-1
- Start of support for hybrid GPT/MBR usb sticks (Stewart Adam)
- Fix for udev deprecated syntax (#480109)
- Keep cache with --cache (Jan Kratochvil, #479716)
- Use absolute path to cachedir (#479716)
- Support UDF for large ISO spins (Bruno Wolf, #476696)
- Improvements for encrypted /home setup (mdomsch, #475399)
- Don't allow spaces in labels (#475834)
- Fix --tmpdir relative path (dhuff)
- Support ext4 rootfs
- Fix device command version check (apevec)
- Allow URLs for specifying the kickstart config (bkearney)
- Fix macro name for excludedocs (bkearney)
- Fix up --base-on (#471656)

* Wed Nov 12 2008 Jeremy Katz <katzj@redhat.com> - 020-1
- Support setting up a swap file
- Verify integer args in livecd-iso-to-disk (#467257)
- Set up persistent /home on internal mtd0 for XO
- Default to resetting the overlay on XO
- Support copying the raw ext3fs to the usb stick instead of the squash
- Mactel fixes
- Align initrd properly on XO (#467093)
- Make initrd load addr work on newer XO firmwares
- Fix up Xen paths for Xen live images (Michael Ansel)
- Support --defaultdesktop (Orion Poplawski)

* Fri Oct 10 2008 Jeremy Katz <katzj@redhat.com> - 019-1
- livecd-iso-to-disk: Various other XO fixes
- Cleanup rpmdb locks after package installation
- Fix traceback due to lazy rhpl.keyboard import
- Fix using groups with options (jkeating)
- Support persistent /home on XO's internal flash
- Fix ramdisk load addr in boot/olpc.fth for XO
- Fix up boot from SD
- Fix extracting boot parameters for pxe (apevec)
- Make rpm macro information persist into the image (bkearney)
- Support %%packages --instLangs (bkearney)

* Thu Aug 28 2008 Jeremy Katz <katzj@redhat.com> - 018-1
- Use logging API for debugging messages (dhuff)
- Some initial support for booting live images on an XO
- Refactoring of mount code for appliance-creator (danpb, dhuff)
- Make --base-on actually work again
- Drop the image configs; these are now in the spin-kickstarts repo
- plymouth support
- Listen to bootloader --append in config
- Add man pages (Pedro Silva)
- Support booting from Intel based Macs via EFI on USB (#450193)
- Fixes for SELinux enforcing (eparis)
- Eject the CD on shutdown (#239928)
- Allow adding extra kernel args with livecd-iso-to-disk
- Support for persistent /home (#445218)
- Copy timezone to /etc/localtime (#445624)
- Ensure that commands run by livecd-creator exist
- Mount a tmpfs for some dirs (#447127)

* Tue May  6 2008 Bill Nottingham <notting@redhat.com> - 017-1
- fix F9 final configs

* Thu May  1 2008 Jeremy Katz <katzj@redhat.com> - 016-1
- Config changes all around, including F9 final configs
- Fix up the minimal image creation
- Fix odd traceback error on __del__ (#442443)
- Add late initscript and split things in half
- livecd-iso-to-disk: Check the available space on the stick (#443046)
- Fix partition size overriding (kanarip)

* Thu Mar  6 2008 Jeremy Katz <katzj@redhat.com> - 015-1
- Support for using live isos with pxe booting (Richard W.M. Jones and 
  Chris Lalancette)
- Fixes for SELinux being disabled (Warren Togami)
- Stop using mayflower for building the initrd; mkinitrd can do it now
- Create a minimal /dev rather than using the host /dev (Warren Togami)
- Support for persistent overlays when using a USB stick (based on support 
  by Douglas McClendon)

* Tue Feb 12 2008 Jeremy Katz <katzj@redhat.com> - 014-1
- Rework to provide a python API for use by other tools (thanks to 
  markmc for a lot of the legwork here)
- Fix creation of images with ext2 filesystems and no SELinux
- Don't require a yum-cache directory inside of the cachedir (#430066)
- Many config updates for rawhide
- Allow running live images from MMC/SD (#430444)
- Don't let a non-standard TMPDIR break things (Jim Meyering)

* Mon Oct 29 2007 Jeremy Katz <katzj@redhat.com> - 013-1
- Lots of config updates
- Support 'device foo' to say what modules go in the initramfs
- Support multiple kernels being installed
- Allow blacklisting kernel modules on boot with blacklist=foo
- Improve bootloader configs
- Split configs off for f8

* Tue Sep 25 2007 Jeremy Katz <katzj@redhat.com> - 012-1
- Allow %%post --nochroot to work for putting files in the root of the iso
- Set environment variables for when %%post is run
- Add progress for downloads (Colin Walters)
- Add cachedir option (Colin Walters)
- Fixes for ppc/ppc64 to work again
- Clean up bootloader config a little
- Enable swaps in the default desktop config
- Ensure all configs are installed (#281911)
- Convert method line to a repo for easier config reuse (jkeating)
- Kill the modprobe FATAL warnings (#240585)
- Verify isos with iso-to-disk script
- Allow passing xdriver for setting the xdriver (#291281)
- Add turboliveinst patch (Douglas McClendon)
- Make iso-to-disk support --resetmbr (#294041)
- Clean up filesystem layout (Douglas McClendon)
- Manifest tweaks for most configs

* Tue Aug 28 2007 Jeremy Katz <katzj@redhat.com> - 011-1
- Many config updates for Fedora 8
- Support $basearch in repo line of configs; use it
- Support setting up Xen kernels and memtest86+ in the bootloader config
- Handle rhgb setup
- Improved default fs label (Colin Walters)
- Support localboot from the bootloader (#252192)
- Use hidden menu support in syslinux
- Have a base desktop config included by the other configs (Colin Walters)
- Use optparse for optino parsing
- Remove a lot of command line options; things should be specified via the
  kickstart config instead
- Beginnings of PPC support (David Woodhouse)
- Clean up kernel module inclusion to take advantage of files in Fedora
  kernels listing storage drivers

* Wed Jul 25 2007 Jeremy Katz <katzj@redhat.com> - 010-1
- Separate out configs used for Fedora 7
- Add patch from Douglas McClendon to make images smaller
- Add patch from Matt Domsch to work with older syslinux without vesamenu
- Add support for using mirrorlists; use them
- Let livecd-iso-to-disk work with uncompressed images (#248081)
- Raise error if SELinux requested without being enabled (#248080)
- Set service defaults on level 2 also (#246350)
- Catch some failure cases
- Allow specifying tmpdir
- Add patch from nameserver specification from Elias Hunt

* Wed May 30 2007 Jeremy Katz <katzj@redhat.com> - 009-1
- miscellaneous live config changes
- fix isomd5 checking syntax error

* Fri May  4 2007 Jeremy Katz <katzj@redhat.com> - 008-1
- disable screensaver with default config
- add aic7xxx and sym53c8xx drivers to default initramfs
- fixes from johnp for FC6 support in the creator
- fix iso-to-stick to work on FC6

* Tue Apr 24 2007 Jeremy Katz <katzj@redhat.com> - 007-1
- Disable prelinking by default
- Disable some things that slow down the live boot substantially
- Lots of tweaks to the default package manifests
- Allow setting the root password (Jeroen van Meeuwen)
- Allow more specific network line setting (Mark McLoughlin)
- Don't pollute the host yum cache (Mark McLoughlin)
- Add support for mediachecking

* Wed Apr  4 2007 Jeremy Katz <katzj@redhat.com> - 006-1
- Many fixes to error handling from Mark McLoughlin
- Add the KDE config
- Add support for prelinking
- Fixes for installing when running from RAM or usb stick
- Add sanity checking to better ensure that USB stick is bootable

* Thu Mar 29 2007 Jeremy Katz <katzj@redhat.com> - 005-3
- have to use excludearch, not exclusivearch

* Thu Mar 29 2007 Jeremy Katz <katzj@redhat.com> - 005-2
- exclusivearch since it only works on x86 and x86_64 for now

* Wed Mar 28 2007 Jeremy Katz <katzj@redhat.com> - 005-1
- some shell quoting fixes
- allow using UUID or LABEL for the fs label of a usb stick
- work with ext2 formated usb stick

* Mon Mar 26 2007 Jeremy Katz <katzj@redhat.com> - 004-1
- add livecd-iso-to-disk for setting up the live CD iso image onto a usb 
  stick or similar

* Fri Mar 23 2007 Jeremy Katz <katzj@redhat.com> - 003-1
- fix remaining reference to run-init

* Thu Mar 22 2007 Jeremy Katz <katzj@redhat.com> - 002-1
- update for new version

* Fri Dec 22 2006 David Zeuthen <davidz@redhat.com> - 001-1%{?dist}
- Initial build.

