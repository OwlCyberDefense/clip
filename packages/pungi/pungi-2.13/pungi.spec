%{!?python_sitelib: %define python_sitelib %(%{__python} -c "from distutils.sysconfig import get_python_lib; print get_python_lib()")}

Name:           pungi
Version:        2.13
Release:        1%{?dist}
Summary:        Distribution compose tool

Group:          Development/Tools
License:        GPLv2
URL:            https://fedorahosted.org/pungi
Source0:        https://fedorahosted.org/pungi/attachment/wiki/%{version}/%{name}-%{version}.tar.bz2
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
Requires:       anaconda >= 14.3, yum => 3.2.19, repoview, createrepo >= 0.4.11
Requires:       lorax
BuildRequires:  python-devel

BuildArch:      noarch

%description
A tool to create anaconda based installation trees/isos of a set of rpms.


%prep
%setup -q


%build
%{__python} setup.py build


%install
rm -rf $RPM_BUILD_ROOT
%{__python} setup.py install -O1 --skip-build --root $RPM_BUILD_ROOT
%{__install} -d $RPM_BUILD_ROOT/var/cache/pungi
%{__install} -d $RPM_BUILD_ROOT/%{_mandir}/man8
%{__install} doc/pungi.8 $RPM_BUILD_ROOT/%{_mandir}/man8/
%{__mv} $RPM_BUILD_ROOT/%{_bindir}/pungi.py $RPM_BUILD_ROOT/%{_bindir}/pungi

 
%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc Authors Changelog COPYING GPL ToDo doc/README
# For noarch packages: sitelib
%{python_sitelib}/pypungi
%if 0%{?fedora} >= 9 || 0%{?rhel} >= 6
  %{python_sitelib}/%{name}-%{version}-py?.?.egg-info
%endif
%{_bindir}/pungi
%{_datadir}/pungi
%{_mandir}/man8/pungi.8.gz
/var/cache/pungi

%changelog
* Fri Dec 21 2012 Dennis Gilmore <dennis@ausil.us> - 2.13-1
- strip groups from comps not listed in the kickstart 
- fix ppc64 runtime installation (#888887)
- dont make isos on arm
- include ppc64 checksums (#888517)

* Fri Aug 31 2012 Dennis Gilmore <dennis@ausil.us> - 2.12-1
- ppc64p7 support
- update locations for ppc files for image composition bz#849731
- add 32 bit arm arches

* Mon Apr 16 2012 Dennis Gilmore <dennis@ausil.us> - 2.11-1
- upstream 2.11 release

* Thu Feb 09 2012 Dennis Gilmore <dennis@ausil.us> - 2.10-1
- upstream 2.10 release

* Wed Jul 27 2011 Dennis Gilmore <dennis@ausil.us> - 2.9-1
- pass isfinal rather than is_beta to lorax 

* Mon Jul 18 2011 Jesse Keating <jkeating@redhat.com> - 2.8-1
- Always re-init the yum object (#717089)

* Mon May 16 2011 Dennis Gilmore <dennis@ausil.us> - 2.7-1
- add --isfinal for turning off the betanag

* Fri Apr 29 2011 Jesse Keating <jkeating@redhat.com> - 2.6-1
- Make sure lorax makes use of our gathered repo

* Wed Jan 12 2011 Jesse Keating <jkeating@redhat.com> - 2.5-1
- Use Lorax instead of buildinstall (mgracik)

* Tue Dec 21 2010 Jesse Keating <jkeating@redhat.com> - 2.4-1
- Enable EFI booting on x86_64 media

* Mon Nov 15 2010 Jesse Keating <jkeating@redhat.com> - 2.3-1
- Drop split-media support

* Thu Oct 14 2010 Jesse Keating <jkeating@redhat.com> - 2.1.4-1
- Further fix the pkgorder issue

* Wed Oct 13 2010 Jesse Keating <jkeating@redhat.com> - 2.1.3-1
- Fix a pkgorder issue

* Tue Jun 29 2010 Jesse Keating <jkeating@redhat.com> - 2.1.2-1
- Fix a yumconf traceback (thanks James!)

* Fri Jun 04 2010 Jesse Keating <jkeating@redhat.com> - 2.1.1-1
- Don't do multilib gathering.
- fixes --force when compose fails during split-tree process. (npetrov)
- fix pkgorder (npetrov)

* Wed Apr 14 2010 Jesse Keating <jkeating@redhat.com> - 2.1.0-1
- Update paths for new anaconda layout
- Drop hints about checksum type
- Add proxy support from the repo line in the kickstart file
- Catch all kernel packages

* Tue Sep 15 2009 Jesse Keating <jkeating@redhat.com> - 2.0.20-1
- One more upstream pkgorder fix

* Tue Sep 15 2009 Jesse Keating <jkeating@redhat.com> - 2.0.19-1
- More upstream fixes for pkgorder and selfhosting composes

* Mon Sep 14 2009 Jesse Keating <jkeating@redhat.com> - 2.0.18-1
- Search for dracut for pkgorder

* Mon Aug 10 2009 Jesse Keating <jkeating@redhat.com> - 2.0.17-1
- Fix pkgorder to not conflict with yum internals.
- Remove dead code from splittree

* Thu May 21 2009 Jesse Keating <jkeating@redhat.com> - 2.0.16-1
- Fix boot.iso being on DVD images

* Tue May 19 2009 Jesse Keating <jkeating@redhat.com> - 2.0.15-1
- Split media on demand rather than via guess work.

* Mon Apr 13 2009 Jesse Keating <jkeating@redhat.com> - 2.0.14-1
- Fix package excludes in kickstart files
- Correctly account for ppc bootable isofs overhead
- Wire in support for composing 'full' trees with all subpackages

* Tue Mar 24 2009 Jesse Keating <jkeating@redhat.com> - 2.0.13-1
- Add online-docs to pkgorder

* Wed Mar 11 2009 Jesse Keating <jkeating@redhat.com> - 2.0.12-1
- Update for yum API change

* Mon Mar 09 2009 Jesse Keating <jkeating@redhat.com> - 2.0.11-1
- Fix size estimation in splittree
- Disable arch test in splittree for now

* Wed Feb 11 2009 Jesse Keating <jkeating@redhat.com> - 2.0.10-1
- Fix CD1 overflow issue
- Name the checksum file after the isos being generated.
- Use sha256 for checksums
- Use unique md file names for repodata.
- Do not include boot.iso on any disc
- Add the packages that anaconda forces to be installed into the pkgorder

* Thu Dec 04 2008 Jesse Keating <jkeating@redhat.com> - 2.0.9-1
- Fix for python-2.6 ('default' is no longer a valid config section)
- Fix splitting srpms

* Tue Nov 4 2008 Jesse Keating <jkeating@redhat.com> - 2.0.8-1
- Set default disc size to 695

* Tue Nov 4 2008 Jesse Keating <jkeating@redhat.com> - 2.0.7-1
- Fix splittree to actually use the iso size defined in kickstarts
- Use https url for bugzilla by default.

* Thu Oct 09 2008 Jesse Keating <jkeating@redhat.com> - 2.0.6-1
- Handle %packages --default to pick up the default groups.
- Set iso name to be the same as --name
- Make sure we don't include the 'sha1:' in the iso SHA1SUM file.
- Fix .treeinfo to have proper case in file names

* Thu Sep 11 2008 Jesse Keating <jkeating@redhat.com> - 2.0.5-1
- Add input-methods to pkgorder.  It's a new group, need to get ordering right.
- Make sure we output sha1sums in binary mode.  This helps windows.
- Yum api changed, follow so that we don't break.

* Mon Aug 11 2008 Jesse Keating <jkeating@redhat.com> 2.0.4-1
- Remove unused discs option
- Don't try to make debuginfo repo for source arch
- Change the checksum output for images checksumming
- Get ppc boot images in checksum list
- Only get repodata and init yum object when needed
- Fix path issues in info files

* Tue Jul 15 2008 Jesse Keating <jkeating@redhat.com> 2.0.3-1
- Checksum various files from buildinstall output and put them in .treeinfo
- Use new hashsum utility to generate sha1sums

* Fri Jul 11 2008 Jesse Keating <jkeating@redhat.com> 2.0.2-1
- add ability to gather debuginfo.  It is default.

* Tue Jun 24 2008 Jesse Keating <jkeating@redhat.com> - 2.0.1-1
- Take on splittree and pkgorder from anaconda.

* Fri Jun 13 2008 Jesse Keating <jkeating@redhat.com> - 2.0.0-1
- New major release
- Collapse the two classes into one Pungi class
- Create a pypungi.util module for utility functions
- Pass along repos/mirrorlists configured in ks file to buildinstall
- Repo cost is now "cost" in pykickstart

* Tue May 06 2008 Jesse Keating <jkeating@redhat.com> - 1.2.18-1
- Manifest change for F9, drop syslog-ng

* Thu May 01 2008 Jesse Keating <jkeating@redhat.com> - 1.2.17-1
- Add a config file for Fedora 9.

* Wed Apr 16 2008 jkeating <jkeating@redhat.com> 1.2.16-1
- Fix another issue with source repo stuff.

* Wed Apr 16 2008 jkeating <jkeating@redhat.com> 1.2.15-1
- Disable comps cleanup until xslt is fixed
- Add support for yum repo costs
- Adjust manifest for Fedora 9 (kernels, languages, flash)

* Mon Apr 08 2008 Jesse Keating <jkeating@redhat.com> - 1.2.14-1
- Create repodata for source.
- Fix SRPM splittree making
- Bump anaconda require up for fixed splittree

* Tue Apr 01 2008 Jesse Keating <jkeating@redhat.com> - 1.2.13-1
- Use the yum api for merging comps.

* Fri Mar 14 2008 Jesse Keating <jkeating@redhat.com> - 1.2.12-1
- Fix source isos
- Send the right options to buildinstall

* Wed Mar 12 2008 Jesse Keating <jkeating@redhat.com> - 1.2.11-1
- Make CDs fit again.

* Tue Mar 11 2008 Jesse Keating <jkeating@redhat.com> - 1.2.10-1
- Handle netinst.iso being renamed to boot.iso

* Wed Mar 05 2008 Jesse Keating <jkeating@redhat.com> - 1.2.9-1
- Fix ppc split iso generation
- Exclude repoview from isos

* Fri Jan 25 2008 jkeating <jkeating@redhat.com> 1.2.8-1
- Put createrepo arguments in correct order
- Fix comps mashup to be more lenient with the open/close of <comps
- Handle gzipped comps files.
- Make sure we get fresh repomd.xml each time we run
- Don't autoclean the repodata, some of it can be reused
- Clear out the repodata we copy out temporarily, so that we don't
  traceback on --force runs.

* Tue Jan 22 2008 jkeating <jkeating@redhat.com> 1.2.7-1
- Rework how repodata gets generated for media.
- use createrepo api

* Wed Jan 2 2008 jkeating <jkeating@redhat.com> 1.2.6-1
- Update the url field for new hosted urls.
- Add k3b to the Fedora manifest.

* Mon Dec 10 2007 Jesse Keating <jkeating@redhat.com> 1.2.4-1
- Remove extra files from tarball

* Mon Dec 10 2007 Jesse Keating <jkeating@redhat.com> 1.2.3-1
- Use a repoview cache.
- Use a createrepo cache.
- Change path to isomd5sum
- Add egg file to spec

* Tue Dec 4 2007 Jesse Keating <jkeating@redhat.com> 1.2.0-1
- Make logged output reusable in shell
- Default to making split media of CD size
- Enable repo includes/excludes.
- Put a constraint on flavor values
- Check for selinux enforcing and warn.
- Add a --force option to reuse an existing destdir
- Only check for root if you're doing root level tasks (buildinstall)
- Figure out number of isos on the fly, based on tree size
- Remove -S -P options, as splittree and packageorder are now
called from createIsos, if needed.
- Use downloadPkgs() from yum instead of a homebrew download function.
- Add a callback to show download progress

* Thu Nov 22 2007 Jesse Keating <jkeating@redhat.com> - 1.1.10-1
- Print a usage if no options are passed
- Correct a man page typo
- Update the F8 config to use released repos

* Mon Oct 29 2007 Jesse Keating <jkeating@redhat.com> - 1.1.9-1
- Remove oversized cached packages (fixes reget problem)

* Sat Oct 27 2007 Jesse Keating <jkeating@redhat.com> - 1.1.8-1
- Add eclipse group.

* Tue Oct 23 2007 Jesse Keating <jkeating@redhat.com> - 1.1.7-1
- Add java-development to the group set.

* Fri Oct 19 2007 Jesse Keating <jkeating@redhat.com> - 1.1.6-1
- Update the manifest

* Thu Oct 11 2007 Jesse Keating <jkeating@redhat.com> - 1.1.5-1
- Add a cost to the media repo

* Tue Oct 02 2007 Jesse Keating <jkeating@redhat.com> - 1.1.4-1
- Make sure we use strings in the config object

* Wed Sep 26 2007 Jesse Keating <jkeating@redhat.com> - 1.1.3-1
- Pull in all the optional Virt stuff
- Don't expire the metadata from Media repo.

* Tue Sep 25 2007 Jesse Keating <jkeating@redhat.com> - 1.1.2-1
- Fix location of media.repo file.

* Tue Sep 18 2007 Jesse Keating <jkeating@redhat.com> - 1.1.1-1
- Create a media.repo file on the first iso

* Fri Sep 14 2007 Jesse Keating <jkeating@redhat.com> - 1.1.0-1
- Create repoview content in the tree
- Move the .composeinfo file into the directory we actually publish
- Remove python2.5 needs (Mark McLoughlin)
- Consolidate the download code for easier maint. (Mark McLoughlin)
- Create a config class that can make using pungi modules easier. (Mark 
McLoughlin)
- Use url line in kickstart files as a repo
- Fix a bug with default dest dir (notting)
- Include a man page (dcantrell)
- Fix a bug with file:// based repos

* Thu Aug 30 2007 Jesse Keating <jkeating@redhat.com> - 1.0.2-1
- Fix some bugs with source iso creation
- Add source repo to kickstart file
- Add %end to %packages in kickstart file

* Tue Aug 28 2007 Jesse Keating <jkeating@redhat.com> - 1.0.1-1
- Default flavor to blank.

* Mon Aug 27 2007 Jesse Keating <jkeating@redhat.com> - 1.0.0-2
- Fix the licensing tag.

* Mon Aug 27 2007 Jesse Keating <jkeating@redhat.com> - 1.0.0-1
- Add support for $releasever in repo uris.
- Add a kickstart file usable for composing Fedora 8 "Fedora"
- Fix bugs with $basearch and mirrorlist usage.
- Add a cache dir for pungi (/var/cache/pungi) and a cli option to override
- Add root check.
- Use a kickstart file as input now (for cdsize and package manifest)
- Remove a lot of configurable items and hard set them
- Move some items to cli flags only (part of moving to pykickstart)
- hard set product_path to 'Packages'
- Use group metadata from repos instead of our own comps file
- Get group files out of configured repos and create a mashup
  of the comps.  Filter it and make use of it when creating repos.
- Quiet down creatrepo calls
- Adjust logging to make use of new facility, use right levels
- Drop a note when all done with composing

* Tue Aug 21 2007 Jesse Keating <jkeating@redhat.com> - 0.5.0-1
- Rework how source rpms are pulled in
  Always pull in 'src' arch packages, just filter them
  when not needed.  Saves having to reset or create new
  yum objects.
- Create a base pungi class that sets logging
- Inherit this class in Gather and Pungi
- Adjust logging to make use of new facility, use right levels
- Drop a note when all done with composing
- Make Gather() no longer a subclass of yum
- Be verbose about what we clean (makefile)
- Create a subclass of yum to work around logging fun

* Wed Aug 01 2007 Jesse Keating <jkeating@redhat.com> - 0.4.1-1
- Create a new yum object for source downloads as yum

* Sat Jul 28 2007 Jesse Keating <jkeating@redhat.com> - 0.4.0-1
- split createrepo call to it's own function.  This enables rawhide
  composes to happen once again. Also breaks API.
- When raising an error, print the error too

* Tue Jul 24 2007 Jesse Keating <jkeating@redhat.com> - 0.3.9-1
- Add a few more desktopy things to manifest
- Rename f7 files to f8; set up config files for f8test1
- Don't quote things passed to mkisofs, not a shell
- Always log stdout before checking for stderr output
- Include memtest86+ in the "Fedora" manifest

* Wed Jun 20 2007 Jesse Keating <jkeating@redhat.com> - 0.3.8-1
- Only grab the newest of deps.
- Don't use flavor for a log file if no flavor set (Trac #48)
- Point to the right manifest file in pungi.conf
- Add a install target to make (Trac #37)
- Enable the source repo in yum configs (Trac #47)
- Use universal newlines in getting process output (Trac #44)
- Fix logging of broken deps (Trac #39)

* Wed May 30 2007 Jesse Keating <jkeating@redhat.com> - 0.3.7-1
- Handle the cdsize variable correctly
- More fixes for cached download stuff
- Fix default CD size storing
- Update comps file with what shipped for F7

* Fri May 25 2007 Jesse Keating <jkeating@redhat.coM> - 0.3.6-1
- Handle the cdsize variable correctly

* Thu May 24 2007 Jesse Keating <jkeating@redhat.coM> - 0.3.5-1
- Use the right flavor in the Everything configs

* Thu May 24 2007 Jesse Keating <jkeating@redhat.coM> - 0.3.4-1
- Use a package checksum to verify cached download

* Wed May 23 2007 Jesse Keating <jkeating@redhat.coM> - 0.3.3-1
- Commit config files used for producing Fedora 7
- Default pungi.conf file to using Fedora 7 stuff

* Mon May 21 2007 Jesse Keating <jkeating@redhat.coM> - 0.3.2-1
- Don't quote ISO label, not running mkisofs in shell
- Apply sparc patches (spot)
- Fix cached downloads comparing correctly
- Shorten 'development' to 'devel' in default config, more space for mkisofs
- Handle config file missing better (jgranado)

* Fri Apr 06 2007 Jesse Keating <jkeating@redhat.com> - 0.3.1-1
- Fix comments in default config file

* Mon Apr 02 2007 Jesse Keating <jkeating@redhat.com> - 0.3.0-1
- Remove incompatible fc6 config files
- Update default config file with comments / new options
- Update comps file
- Enable source iso building again.
- Don't try a rescue if the script doesn't exist (prarit)
- Pass flavor off to buildinstall if it is set (wwoods)
- Fix a logic flaw in the depsolving loop
- Use yum's built in exclude handling
- Use yum's built in conditional handling for things from comps
- Do excludes before group handling.
- Get all potential matches for deps, let install time figure
  the best one to use.
- Work around false positive 'unmatched' packages (globs are fun)
- Change how depsolving is done
  - Get all potential matches for a dep, instead of our 'best'
    our 'best' may not be the same as install time best.
  - Remove anaconda code, use direct yum functions to get deps
  - Use a True/False flag to depsolve instead of iterating over
    a dict.
  - Log what packages are being added for which reasons.
- Do things faster/smarter if we've only asked for one disc
- log the rpm2cpio stuff for release notes
- correctly capture errors from subprocess

* Fri Mar 09 2007 Jesse Keating <jkeating@redhat.com> - 0.2.8-1
- Call createrepo ourselves for the tree, not buildinstall's job
- Convert from commands to subprocess for things we call out
- Add kickstart %packages syntax support to package manifest
- Make the list we hand off to yum to search for as unique as we can

* Wed Feb 28 2007 Jesse Keating <jkeating@redhat.com> - 0.2.7-1
- Fix gathering of srpms (thanks skvidal)
- Update comps from F7 Test2

* Thu Feb 22 2007 Jesse Keating <jkeating@redhat.com> - 0.2.6-1
- Don't use TMPDIR with buildinstall, it is broken

* Wed Feb 21 2007 Jesse Keating <jkeating@redhat.com> - 0.2.5-1
- Make use of anaconda's TMPDIR support
- Put yum tempdirs in the workdir
- Add a version option to cli arguments
- Make cdsize a config option

* Thu Feb 15 2007 Jesse Keating <jkeating@redhat.com> - 0.2.4-1
- Add support for globbing in manifest
- Add new Make targets (Essien Ita Essien)
- Add runtime flags for doing specific stages of the compose (Essien Ita Essien)
- Add ability to define destdir on the cli to override conf file
- Clean up optionparse stuff, print usage if arg list is too small
- Fix part of the patch from Essien
- Add Contributors to the Authors file
- Adjust the Makefile so that srpm doesn't cause a tag
- Merged changes from Will Woods
  - Write out some tree description files
  - Don't traceback on existing files in download area (not sure this will stay)
- Style fixed some stuff from Will
- Add logging patch from jbowes
- Various logging tweaks
- Use -d flag in createrepo for sqlite blobs
- Add pydoc stuff to various functions
- Support comments in the package manifest

* Tue Feb 06 2007 Jesse Keating <jkeating@redhat.com> - 0.2.3-1
- Be able to opt-out of a bugurl since buildinstall supports this
- Make isodir an object of pungi (wwoods)
- yum bestPackagesFromList takes an arch argument. Fixes ppc64 bug
- Don't use 'returnSimple' anymore, deprecated in yum api

* Mon Jan 29 2007 Jesse Keating <jkeating@redhat.com> - 0.2.2-1
- Update the comps file again from F7
- Fix the ppc boot flags
- Clean up SRPM-disc junk
- add bugurl config option for anaconda betanag

* Thu Jan 25 2007 Jesse Keating <jkeating@redhat.com> - 0.2.1-1
- Add a "flavor" option (such as Desktop)
- Move packageorder file into workdir
- Update the comps file from F7

* Wed Jan 24 2007 Jesse Keating <jkeating@redhat.com> - 0.2.0-1
- Now use a manifest to determine what to pull in, not comps itself
- Add a minimal-manifest for test composes
- Add current F7 comps file for test composes
- Use some anaconda code to depsolve, gets better (and more common) results
- Bump the iso size to what was used in FC6
- Move splittree workdirs into work/ at the end of the run
- Remove our splittree for rawhide
- Remove old main() sections from pungi.py and gather.py
- Require yum 3.0.3 or newer
- Add rescueCD support

* Wed Dec 13 2006 Jesse Keating <jkeating@redhat.com> - 0.1.2-1
- Fix a bug in DVD repodata
- Add correct ppc boot args
- Set ppc arch correctly

* Mon Dec 11 2006 Jesse Keating <jkeating@redhat.com> - 0.1.1-2
- Need BR python-devel in rawhide

* Mon Dec 11 2006 Jesse Keating <jkeating@redhat.com> - 0.1.1-1
- Update to 0.1.1
- Add ability to get srpms
- Add ability to get relnote files
- Use a config file system
- Clean up some docs
- Add config files for composing FC6 respins

* Wed Nov  8 2006 Jesse Keating <jkeating@redhat.com> - 0.1.0-1
- Initial spec
