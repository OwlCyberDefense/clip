#Certifiable Linux Integration Platform (CLIP)

## Table of Contents
  * [Getting Started] (#getting-started-)
  * [Build System] (#build-system-)
    * [What is this thing?] (#what-is-this-thing-)
    * [How do I use the build system?] (#how-do-i-use-the-build-system-)
    * [Managing yum repos] (#managing-yum-repos-)
    * [Custom Packages] (#custom-packages-)
    * [ISO configuration (kickstarts)] (#iso-configuration-kickstart-files-)
    * [Add existing binary packages to the image] (#add-existing-binary-packages-to-the-image-)
    * [Update existing external packages] (#update-existing-external-packages-)
    * [Configuring AIDE] (#configuring-aide-)
    * [Configuring Scap Security Guide] (#configuring-scap-security-guide-)
  * [Use Cases] (#use-cases-)
    * [Developer starting from scratch](#developer-starting-from-scratch-)
    * [Developer with existing custom yum repositories](#developer-with-existing-custom-yum-repositories-but-needs-help-rolling-isos-)
    * [Developer who only wants the remediation and audit content](#developer-who-only-wants-the-remediation-and-audit-content-)
  * [Frequently Asked Questions] (#frequently-asked-questions-)
  * [Known Issues] (#known-issues-)

##Getting Started <a id="getting-started"></a>

Here is a quick list of the things you need to do to get started.

1. **CHANGE THE DEFAULT PASSWORD IN YOUR KICKSTART!**
CLIP intentionally ships with an [unencrypted default password](./kickstart/clip-rhel7/clip-rhel7.ks#L233)!
It is "neutronbass". **DO NOT LEAVE THIS PASSWORD LINE INTACT!**
2. Run `./bootstrap.sh`.
3. After you have run bootstrap once you do not have to run it again unless there there has been a new release of CLIP.
4. Roll an ISO by running `make clip-rhel7-iso`

**Note**: for a complete list of targets available please run `make help`

##Build System <a id="build-system"></a>

###What is this thing? <a id="what-is-this-thing"></a>

CLIP’s build system allows developers and administrators to create RPMs and installation ISOs
in a controlled environment.

Specific features include:

* Generation of RPMs using mock. 
* Generation of installation media (ISOs).

Unique feature:

* Versioned build-time and run-time package dependencies. Normally
a packager will point mock at a	package repository full of RPMs at
different version levels.  This makes it difficult to ensure
reproducibility across builds.  This build system allows one to version
build-time and run-time dependencies, eg create an RPM for application "foo"
with a build dependency bar-4.3-1, thus facilitating reproducibility of
generated packages.


###How do I use the build system? <a id="how-do-i-use-the-build-system"></a>

This build system has a few constructs that must be addressed by the
user.

- Available build targets.
- Managing yum repos.
- Adding custom packages.
- ISO configuration files, ie kickstart files.
- Adding existing binary packages to the image

To view the list of available build targets run `make help`.

####Managing yum repos <a id="managing-yum-repos"></a>


Several repositories must be present for the build system to work:
- RHEL/CentOS
- RHEL Optional
- Fedora Build Groups (for RHEL 5)

The locations of these repos is defined in the [`CONFIG_REPOS`](./CONFIG_REPOS) file:
-  [`rhel`](./CONFIG_REPOS#L30)` = /mnt/repos/rhel`
-  [`opt`](./CONFIG_REPOS#L35)` = /mnt/repos/opt`
-  [`buildgroups`](./CONFIG_REPOS#L41)` = /mnt/repos/buildgroups`

Remember that repositories are often architecture specific so you might have
to update these variables to build for a different architecture.

####Custom Packages <a id=”custom-packages”></a>

The most common task is adding your own packages to be included in a rolled
ISO.

1. First, a directory is created in `packages/<PACKAGE NAME>`.  The contents of
this directory will vary depending on the type of package.  Now choose one of
the two options below, 2)1 or 2)2

2. 
   1. If you want to include a package and you have a src.rpm that needs *no*
  modifications refer to [`packages/examples/srcrpm`](./packages/examples/srcrpm) as a reference.  You will copy
  the src rpm, `Makefile.tmpl` and the `gen-makefile-from-src-rpm.sh` to the newly
  created (#1) package directory.  Now enter that directory and run
  `./gen-makefile-from-src-rpm.sh <package>.src.rpm`.  This will generate a
  Makefile based on the src RPM.  Skip to step #3.

   2. If the intent is to contain custom source code, e.g. an internally developed
  application or library, then `packages/<PACKAGE NAME>` will still contain a
  Makefile and spec file, and `packages/<PACKAGE NAME>/<PACKAGE NAME>` will
  contain the sources and application-specific build system (e.g. the one that
  typically has a `make all` and `make install` target).  For more information
  on this type of package refer to `packages/examples/source`.

3. Once the package has been added to the [`packages/`](./packages/) directory, it will be dynamically
added to the build via the [`PACKAGES`](./Makefile#L52) variable in the top level Makefile.
There is nothing needed to be done on the part of the user to add the package to the build. After a package
is built by mock, it will appear in `repos/clip-repo`. To add the package to an ISO image,
update the appropriate kickstart file and add the package name to the kickstart's package list.
To exclude the package from future builds, add the package name as it appears in the `packages/`
directory to the [`EXCLUDE_PKGS`](./Makefile#L50) variable in the top level Makefile.

####ISO configuration (kickstart files) <a id=”iso-configuration-kickstart-files-”></a>


The [`kickstart/`](./kickstart) directory contains the files needed to configure an ISO.  The
Makefiles in this directory call out to tools in the [`support/`](./support) directory and
pass in a kickstart.  This kickstart is used to generate an ISO.

To add a new ISO, first add an appropriate kickstart to the
`kickstart/<productname>` directory.  Since this build system generates and
manages yum repos we must make changes to the kickstart, so ensure it has
the `#REPO-REPLACEMENT-PLACEHOLDER` line somewhere near the top.

**Note**: the string `#REPO-REPLACEMENT-PLACEHOLDER` *must* appear in the
kickstart for this to work appropriately.

If you choose to use a hostable kickstart script rather than rebuilding an
iso, you can run the following from `./kickstart/clip-rhel7`:
`make setup-ks `

A hostable kickstart is then located in
`./tmp/clip-iso-build/1/x86_64/os/clip-rhel7.ks`

####Add existing binary packages to the image <a id=”add-existing-binary-packages-to-the-image”></a>


There are two ways to add an existing binary package to this build system.
Once one of these methods has been followed you can reference the package in
the kickstart and it will be installed during the installation process.

**Method 1:**

1. Add the fully qualified path to the package to the [`PRE_ROLLED_PACKAGES`](./CONFIG_BUILD#L12)
variable in the `CONFIG_BUILD` file.
2. Reference the package from your kickstart.

**Method 2:**

**Note**: This method is easier if you have existing yum repositories to use. Skip to step 3 if
you have a yum repo created.

1. Copy the package to the appropriate repo directory (eg, /mnt/repos/custom-yum-repo).
2. Run `createrepo -d <repodir>`
3. Add the repo to `CONFIG_REPOS`
    1. Add the package filename to the `pkglist.<reponame>` file in `conf/`.
    2. Run `make conf/pkglist.<reponame>`
5. Run `make bare-repos`
6. Run `make create-repos`
7. Add the packages you want to include in the ISO to the appropriate
kickstart.
8. Build your image.

#### Update existing external packages <a id=”update-existing-external-packages”></a>

1. Remove `conf/pkglist.<reponame>`
2. Run `make conf/pkglist.<reponame>`

#### Configuring AIDE <a id=”configuring-aide”></a>


CLIP creates a systemd service unit which runs an AIDE check on first boot. The newly created database, AIDE binary, and aide.conf are moved to a file system which is mounted read-only after a reboot triggered by the AIDE service.
A cron job is executed every 24 hours and logs detected changes to `/var/log/aide.log`. Where the AIDE files are written, the cron job, as well as `aide.conf`, are all configurable in the [kickstart script](./kickstart/clip-rhel7/clip-rhel7.ks#L344). A typical use case is to disable networking on the system if the cron job fails. Another useful configuration is to write the AIDE files to read-only media that is kept off the box for added security.

**NOTE:** `aide.conf` has not been modified by CLIP and will need to be configured to ignore files on a case by case basis.

#### Configuring Scap Security Guide <a id=”configuring-scap-security-guide”></a>


CLIP uses Scap Security Guide (SSG) [1] to perform remediation and audit of our system. The profile used is
based on the SSG stig-rhel7-server-upstream profile [2]. All SSG configuration is done in the CLIP kickstart script.
The logs from auditing and remediation are placed in `/root/ssg/` by default.

[1] https://github.com/OpenSCAP/scap-security-guide

[2] https://github.com/OpenSCAP/scap-security-guide/blob/master/RHEL/7/input/profiles/stig-rhel7-server-upstream.xml

## Use Cases <a id="use-cases-"></a>

CLIP targets several usage scenarios - each interacting and leveraging CLIP in
different ways.  Please review the use cases described below to better
understand how you can use CLIP.

##### Developer starting from scratch <a id=”developer-starting-from-scratch”></a>


A developer starting from scratch will leverage all of the features available
in CLIP:
- Remediation content
- Audit content (validated XCCDF & OVAL snapshots from SCAP Security Guide)
- Build system:
  - Mock for rolling RPMs from source
  - Pungi and Lorax for rolling installation ISOs
  - Configuration management friendly yum repos and package lists

Developers starting from scratch should insert any new sources into the
[`packages/`](./packages) directory.  This source will be rolled up into RPMs, placed into yum
repositories, and can then be included and used in a kickstart ending up in the
installed system.

#####Developer with existing custom yum repositories but needs help rolling ISOs <a id=”developer-with-existing-custom-yum-repositories-but-needs-help-rolling-isos”></a>


This developer already has packages and yum repositories, but will use the
following CLIP features:
- Remediation content
- Audit content (validated XCCDF & OVAL snapshots from SCAP Security Guide)
- Build system:
  - Pungi and Lorax for rolling installation ISOs
  - Configuration management friendly yum repos and package lists

This developer uses the CLIP build system to roll ISOs with the remediation
content, audit content, and existing custom packages present. This developer
must add an entry to [`CONFIG_REPOS`](./CONFIG_REPOS) that points to the developer’s custom yum
repo.  Once the repo is added to the configuration file the developer will
modify the kickstart adding to add the custom packages.  The custom packages
will be installed and rolling ISOs.

#####Developer who only wants the remediation and audit content <a id=”developer-who-only-wants-the-remediation-and-audit-content”></a>


These developers already have packages and yum repositories and can already
roll ISOs.  They only want to leverage the following features:
- Remediation content
- Audit content (validated XCCDF & OVAL snapshots from SCAP Security Guide)

**NOTE**: Tresys recommends moving to the CLIP build system, which was developed
based on our experiences developing cross domain solutions.  One of the issues
we frequently encounter is the lack of reproducibility of builds.  This build
system allows you to roll RPMs in mock eliminating build host dependencies.  By
default, a clean chroot will be used for each RPM. This is configurable in
[`CONFIG_BUILD`](./CONFIG_BUILD#L65) with the `CLEAN_MOCK` option.  Mock allows you to version the packages
used to roll an RPM.  It manages yum repositories and carries patched versions of
ISO generation tools to address a number of problems in those tools.

## Frequently Asked Questions <a id="frequently-asked-questions"></a>

##### I deployed my system and everything is broken.  HELP!

First, CLIP is very, very locked down.  This does not indicate breakage, 
rather a conscious decision to address security requirements first and 
foremost.  CLIP is not a general-purpose OS.  It is a base platform and 
build environment that provides a starting point for developing 
solutions that meet strict security requirements.  Red Hat Enterprise 
Linux is a general-purpose OS (and rightly so).  The security requirements 
of a general-purpose OS, such as using a "targeted" SELinux policy, do not 
mesh with the requirements that must be met by security solutions.

Second, we applied a least privilege model during development.  This means
that we exercised the core system functions and permitted access only when
absolutely necessary.  If you're doing something that isn't part of what
the CLIP team considers "core system" then that access isn't accounted for
in policy or remediation content.

For example, we do not consider Apache to be part of the "core system."
Getting Apache up and running in CLIP will take a little bit of work.
Another example is USB support.  The remediation content disables 
USB support.  This is aligned with the requirements and CLIP itself.
If you need USB support you're going to have to update the remediation
content.

A benefit to this model is that the developer is made aware of any
deviations from the requirements when it occurs, not during a certification
and accreditation process.

##### How do I roll an installation ISO?
`make clip-rhel7-iso`

##### What other things can I make?
`make help`

##### What is the default username and password for CLIP?
The username is `toor` and the password is `neutronbass`.  You can
change this in the `%post` of the [`kickstart`](./kickstart/clip-rhel7/clip-rhel7.ks#L232).

##### What is the default bootloader password for GRUB?
The default password for GRUB is `neutronbass` and the default user is `root`.  You can change this in the [`kickstart`](./kickstart/clip-rhel7/clip-rhel7.ks#L29). It is highly recommended you change your password either in the kickstart or at runtime. Refer to [this guide](https://help.ubuntu.com/community/Grub2/Passwords) for runtime updating of the grub password.

##### How do I set up local yum repos?
Run `./bootstrap.sh` with an RHEL 7 DVD in the DVD-Drive.

##### How do I mirror EPEL?
The bootstrap script will subscribe to EPEL and install the necessary packages needed for the build system. Simply run `./bootstrap.sh`.

##### I want to use CentOS instead of RHEL. What do I need to do?
In the CONFIG_BUILD file point to a CentOS mirror rather than a RHEL mirror or provide a CentOS DVD for bootstrap.

##### Do I have to subscribe to the RHEL optional channel?
If you don't have credentials or you're out of entitlements there is a work-around.
We *NEED* packages from Opt to be installed on the build host *and* need to pull
packages from there to put on the generated installable media.  If you're using
RHEL want to work-around this issue (hack):
1. Grab a CentOS ISO.
2. Mount it.
3. Add it as a yum repo:
http://docs.oracle.com/cd/E37670_01/E37355/html/ol_create_repo.html
4. Re-run `./bootstrap.sh` and point "opt" to your newly created yum repo.

##### An EXCEPTION was thrown during the build.  What do I do?
The likely culprit is an RPM that failed to roll properly. Open
`./repos/clip-repo/build.log` and `./tmp/clip-iso-build/logs/x86_64.log`.

A good option for debugging the issue is to roll the RPM outside of mock.
Go into `packages/<PACKAGENAME>` and run `make rpm`.  It should fail to build again.
This time go into `./tmp/src/redhat/BUILD/<PACKAGENAME>-<PACKAGEVERSION>`.  This is where the
build occurred.  You can now poke around in this directory to see what went wrong.

##### Why do I get prompted for so many passwords the first time I login?
The default user's password is immediately expired when the account is
created.  This means you have to login and choose a new password.

##### How do I add a user?
Use these commands (change `<USERNAME>` to the appropriate username):
```
semanage user -a -R staff_r -R sysadm_r <USERNAME>_u
useradd -Z <USERNAME>_u -m <USERNAME>
restorecon -RF /home/<USERNAME>
passwd foo
chage -d 0 <USERNAME>
```

**Note**: The first command will have to be adjusted as appropriate to match the
defined SELinux roles. The restorecon is required due to a bug in
useradd where it doesn't honor login mappings when creating and
populating user home directories.

CLIP for RHEL 7 uses user-based access controls in SELinux.  The first
command, semanage, adds an SELinux user facilitating this separation and
provides a set of roles that user is authorized to assume.  The second
command, useradd, actually creates the account and binds the Linux user
ID to the SELinux user ID.  The third command is used to set the user's
password.  The fourth command causes the password to immediately expire
thus forcing the user to set a new password on their first login.

##### How do I add categories to a user?

After the clip installation completes, you will want to set the SELinux
categories for privileged users.  This can be accomplished by running the
following commands in order:

``` 
export username=`whoami`
sudo -Es
setenforce 0
semanage user -m -L s0 -r s0-s0:c0.c1023 ${username}_u
semanage login -m -s ${username}_u -r s0-s0:c0.c1023 ${username}
exit
```

After logging back in, running `id -Z` should produce following the output:

`<username>_u:staff_r:staff_t:s0-s0:c0.c1023`

##### How do I become a privileged user?
Use `sudo -s`.  Make sure the user has a line in sudoers like this:
`echo "<USERNAME>        ALL=(ALL) ROLE=sysadm_r TYPE=sysadm_t      ALL" >> /etc/sudoers`

**Note**: You will have to adjust the ROLE and TYPE fields as appropriate. For
example, `ROLE=auditadm_r TYPE=auditadm_t`

##### Why am I getting "permission denied" when adding a user?
You probably removed user_u from your SELinux policy.  Due to a bug in
useradd this SELinux user *must* be present.  CLIP uses SELinux constraints
to strip all access from that user ID so leaving it present isn't a real
issue.

##### Why do I have to have local yum repos?
One of the reasons we wrote this new build and integration system is to
ensure consistency across builds.  That is, we wanted to ensure that an ISO
generated in 2012 could be re-generated in 2014 without any functional
differences.  Pointing to a remote repo makes this difficult to ensure
mock would roll RPMs using the packages available when mock was run.
However, the ISOs would be built using packages available when the ISO was
rolled.  This is exacerbated if you refer to HTTP/FTP yum repos from the
kickstart may lead to inconsistencies between the RPMs and the ISO.  Could
we solve this by "wget'ing" RPMs from an HTTP/FTP repo?  Sure.  But why not
just use SMB/NFS mounts to get access to your central yum repo server.  At
Tresys we have dedicated repo servers for each distro variant.  They share
those repos via NFS.  Each build system NFS mounts those servers.  It is a
relatively painless process that has proven to lead to consistency across
builds.  All of this said, we're open to accepting patches from the
community that implement support for remote repos but do so in a way to still
meets the goal of reproducible builds.

##### Why do I see a series of question marks in the output of `ls -l` ?
This is SELinux enforcing a mandatory access control security policy that
prevents a given subject (eg sysadm) from querying the security attributes of
a file or directory.  Assuming you have search and read permissions on the
directory you will be able to view the filename, but that is it.

##### I get setfiles errors running semodule and/or semanage.  What is going on here?
The likely culprit is libsemanage being configured to validate fc entries
prior to rolling a transaction forward.  The following is the error
message emitted when this occurs:

``` 
/etc/selinux/clip/contexts/files/file_contexts: Multiple same specifications ...
libsemanage.semanage_install_active: setfiles returned error code 1.
semodule:  Failed! 
```

The fix for this is to disable the setfiles check in samange.conf:
```
echo -e "module-store = direct\n[setfiles]\npath=/bin/true\n[end]\n" > /etc/selinux/semanage.conf
```

If you're using a [CLIP kickstart](./kickstart/clip-rhel7/clip-rhel7.ks#L283) the ks handles this in response to the
[`CONFIG_BUILD_ENFORCING_MODE`](./CONFIG_BUILD#L35) flag.  In permissive mode this check is disabled.

**Note**: This is only recommended when doing development.  Errors
like this are a sign of a policy problem that needs to be fixed.

##### What are some workflows I can use to source control my changes to CLIP and keep in sync with updates?
You have several options here.  One option is to do your work in a branch in
a checkout of the CLIP git repo.  Then when a new CLIP release is made, or you
want to pull in a change we made in HEAD, just rebase on master.
Alternatively checkout our git repo to use as your own, make any changes you
want using any workflow you have WRT to git, then fetch from our upstream repo
when necessary.

If you're not using git for your own projects it becomes slightly more
cumbersome.  You could import a specific revision of CLIP into your SCM,
notate the last revision of CLIP you have in some way, and when a new CLIP
release comes out just apply the diff between that last revision and the new
revision to your tree.  I think this is the manual process you were referring
to above.

One other workflow I want to mention is to simply point CLIP at a pre-rolled
RPM or yum repo.  In that way you can use your existing build system/SCM to
generate the package(s).

Additionally you can include CLIP as a git submodule in your project. Setup your
source tree in the CLIP structure.  Then symlink the required packages from the 
CLIP submodule into your packages directory.  This allows for easy updating of
CLIP as updates are available AND easy ability to customize everything as needed.

##### How do I get the dependencies for the host?
Run `./bootstrap.sh` from within the clip directory.

##### I am getting warnings at install time stating "some of the packages you have selected for install are missing dependencies."
The tools don't do a full dependency check at build time.  That is because you could
be pointing to additional yum repos at install time via the command-line
(etc).  If anyone knows of a method to verify dependencies at build time please shoot
us an email.

The way you fix it is by making sure the referenced package is present in
the repos in [`CONFIG_REPOS`](./CONFIG_REPOS).  A common cause is lacking the Optional channel
repo when building on RHEL.  This typically results in libxslt-python dep
errors.

##### How do I release CLIP?
There is a make target for doing a release. First, set the `CLIP_RELEASE` variable to the title
of your tag. Then run `make release`. The repo will be tagged and pushed to origin.

##### How do I add an external package to the build system?
The CLIP build system is designed to utilize mock to build your external package in a chroot. Please see [Custom Packages](#custom-packages-) for more information.

##### How do I create a LiveCD?
As of RHEL 7.0, LiveCDs are no longer functional. Please see issue #178 for more information.

## Known Issues <a id="known-issues"></a>

##### VirtualBox
There is a known issue when creating a Virtual Machine of CLIP using VirtualBox and a hard disk size less than 20 gigabytes. Please use a HDD
size that is at least 20 GB when using CLIP on VirtualBox.

##### 32-bit architecture
Building CLIP on a 32-bit RHEL build system is currently not supported.

##### Periodic "Pane is dead" error on installation
Periodically, the CLIP build system will create an ISO that produces a "Pane is dead" error on install.
If this occurs, running 'make bare', rerunning './bootsrap.sh', and rebuilding clip should produce an ISO without this issue.

##### readahead.service policy not currently implemented
Because developement has been done in a VM and readahead requires the system to be run on hardware, policy is not currently implemented for this service.

##### Stopping/Restarting auditd does not currently work in enforcing
SELinux currently prevents auditd from being stopped or restarted in enforcing

##### systemd-update-done fails on boot
SELinux currently prevents systemd-update-done from working in enforcing
