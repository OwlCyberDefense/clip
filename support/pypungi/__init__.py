#!/usr/bin/python -tt


# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Library General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.


import yum
import os
import re
import shutil
import sys
import gzip
import pypungi.util
import pprint
import lockfile
import logging
import urlgrabber.progress
import subprocess
import createrepo
import ConfigParser
import pylorax
from fnmatch import fnmatch

import arch as arch_module
import multilib


class ReentrantYumLock(object):
    """ A lock that can be acquired multiple times by the same process. """

    def __init__(self, lock, log):
        self.lock = lock
        self.log = log
        self.count = 0

    def __enter__(self):
        if not self.count:
            self.log.info("Waiting on %r" % self.lock.lock_file)
            self.lock.acquire()
            self.log.info("Got %r" % self.lock.lock_file)
        self.count = self.count + 1
        self.log.info("Lock count upped to %i" % self.count)

    def __exit__(self, type, value, tb):
        self.count = self.count - 1
        self.log.info("Lock count downed to %i" % self.count)
        self.log.info("%r %r %r" % (type, value, tb))
        if not self.count:
            self.lock.release()
            self.log.info("Released %r" % self.lock.lock_file)


def yumlocked(method):
    """ A locking decorator. """
    def wrapper(self, *args, **kwargs):
        with self.yumlock:
            return method(self, *args, **kwargs)
    # TODO - replace argspec, signature, etc..
    return wrapper


def is_debug(po):
    if "debuginfo" in po.name:
        return True
    return False


def is_source(po):
    if po.arch in ("src", "nosrc"):
        return True
    return False


def is_noarch(po):
    if po.arch == "noarch":
        return True
    return False


def is_package(po):
    if is_debug(po):
        return False
    if is_source(po):
        return False
    return True


class MyConfigParser(ConfigParser.ConfigParser):
    """A subclass of ConfigParser which does not lowercase options"""

    def optionxform(self, optionstr):
        return optionstr


class PungiBase(object):
    """The base Pungi class.  Set up config items and logging here"""

    def __init__(self, config):
        self.config = config

        # ARCH setup
        self.tree_arch = self.config.get('pungi', 'arch')
        self.yum_arch = arch_module.tree_arch_to_yum_arch(self.tree_arch)
        full_archlist = self.config.getboolean('pungi', 'full_archlist')
        self.valid_arches = arch_module.get_valid_arches(self.tree_arch, multilib=full_archlist)
        self.valid_arches.append("src") # throw source in there, filter it later
        self.valid_native_arches = arch_module.get_valid_arches(self.tree_arch, multilib=False)
        self.valid_multilib_arches = arch_module.get_valid_multilib_arches(self.tree_arch)

        # arch: compatible arches
        self.compatible_arches = {}
        for i in self.valid_arches:
            self.compatible_arches[i] = arch_module.get_compatible_arches(i)

        self.doLoggerSetup()
        self.workdir = os.path.join(self.config.get('pungi', 'workdirbase'),
                                    self.config.get('pungi', 'flavor'),
                                    self.tree_arch)



    def doLoggerSetup(self):
        """Setup our logger"""

        logdir = os.path.join(self.config.get('pungi', 'destdir'), 'logs')

        pypungi.util._ensuredir(logdir, None, force=True) # Always allow logs to be written out

        if self.config.get('pungi', 'flavor'):
            logfile = os.path.join(logdir, '%s.%s.log' % (self.config.get('pungi', 'flavor'),
                                                          self.tree_arch))
        else:
            logfile = os.path.join(logdir, '%s.log' % (self.tree_arch))

        # Create the root logger, that will log to our file
        logging.basicConfig(level=logging.DEBUG,
                            format='%(name)s.%(levelname)s: %(message)s',
                            filename=logfile)


class CallBack(urlgrabber.progress.TextMeter):
    """A call back function used with yum."""

    def progressbar(self, current, total, name=None):
        return


class PungiYum(yum.YumBase):
    """Subclass of Yum"""

    def __init__(self, config):
        self.pungiconfig = config
        yum.YumBase.__init__(self)

    def doLoggingSetup(self, debuglevel, errorlevel, syslog_ident=None, syslog_facility=None):
        """Setup the logging facility."""

        logdir = os.path.join(self.pungiconfig.get('pungi', 'destdir'), 'logs')
        if not os.path.exists(logdir):
            os.makedirs(logdir)
        if self.pungiconfig.get('pungi', 'flavor'):
            logfile = os.path.join(logdir, '%s.%s.log' % (self.pungiconfig.get('pungi', 'flavor'),
                                                          self.pungiconfig.get('pungi', 'arch')))
        else:
            logfile = os.path.join(logdir, '%s.log' % (self.pungiconfig.get('pungi', 'arch')))

        yum.logging.basicConfig(level=yum.logging.DEBUG, filename=logfile)

    def doFileLogSetup(self, uid, logfile):
        # This function overrides a yum function, allowing pungi to control
        # the logging.
        pass

    def _compare_providers(self, *args, **kwargs):
        # HACK: always prefer 64bit over 32bit packages
        result = yum.YumBase._compare_providers(self, *args, **kwargs)
        if len(result) >= 2:
            pkg1 = result[0][0]
            pkg2 = result[1][0]
            if pkg1.name == pkg2.name:
                best_arch = self.arch.get_best_arch_from_list([pkg1.arch, pkg2.arch], self.arch.canonarch)
                if best_arch != "noarch" and best_arch != pkg1.arch:
                    result[0:1] = result[0:1:-1]
        return result

class Pungi(pypungi.PungiBase):
    def __init__(self, config, ksparser):
        pypungi.PungiBase.__init__(self, config)

        # Set our own logging name space
        self.logger = logging.getLogger('Pungi')

        # Create a lock object for later use.
        filename = self.config.get('pungi', 'cachedir') + "/yumlock"
        lock = lockfile.LockFile(filename)
        self.yumlock = ReentrantYumLock(lock, self.logger)

        # Create the stdout/err streams and only send INFO+ stuff there
        formatter = logging.Formatter('%(name)s:%(levelname)s: %(message)s')
        console = logging.StreamHandler()
        console.setFormatter(formatter)
        console.setLevel(logging.INFO)
        self.logger.addHandler(console)

        self.destdir = self.config.get('pungi', 'destdir')
        self.archdir = os.path.join(self.destdir,
                                   self.config.get('pungi', 'version'),
                                   self.config.get('pungi', 'flavor'),
                                   self.tree_arch)

        self.topdir = os.path.join(self.archdir, 'os')
        self.isodir = os.path.join(self.archdir, self.config.get('pungi','isodir'))

        pypungi.util._ensuredir(self.workdir, self.logger, force=True)

        self.common_files = []
        self.infofile = os.path.join(self.config.get('pungi', 'destdir'),
                                    self.config.get('pungi', 'version'),
                                    '.composeinfo')


        self.ksparser = ksparser

        self.resolved_deps = {} # list the deps we've already resolved, short circuit.
        self.excluded_pkgs = {} # list the packages we've already excluded.
        self.seen_pkgs = {}     # list the packages we've already seen so we can check all deps only once
        self.multilib_methods = self.config.get('pungi', 'multilib').split(" ")

        # greedy methods:
        #  * none: only best match package
        #  * all: all packages matching a provide
        #  * build: best match package + all other packages from the same SRPM having the same provide
        self.greedy_method = self.config.get('pungi', 'greedy')

        self.lookaside_repos = self.config.get('pungi', 'lookaside_repos').split(" ")
        self.sourcerpm_arch_map = {}    # {sourcerpm: set[arches]} - used for gathering debuginfo

        # package object lists
        self.po_list = set()
        self.srpm_po_list = set()
        self.debuginfo_po_list = set()

        # get_srpm_po() cache
        self.sourcerpm_srpmpo_map = {}

        # flags
        self.input_packages = set()         # packages specified in %packages kickstart section including those defined via comps groups
        self.comps_packages = set()         # packages specified in %packages kickstart section *indirectly* via comps groups
        self.prepopulate_packages = set()   # packages specified in %prepopulate kickstart section
        self.fulltree_packages = set()
        self.langpack_packages = set()
        self.multilib_packages = set()

        # already processed packages
        self.completed_add_srpms = set()        # srpms
        self.completed_debuginfo = set()        # rpms
        self.completed_depsolve = set()         # rpms
        self.completed_langpacks = set()        # rpms
        self.completed_multilib = set()         # rpms
        self.completed_fulltree = set()         # srpms
        self.completed_selfhosting = set()      # srpms
        self.completed_greedy_build = set()     # po.sourcerpm

        self.is_fulltree = self.config.getboolean("pungi", "fulltree")
        self.is_selfhosting = self.config.getboolean("pungi", "selfhosting")
        self.is_sources = not self.config.getboolean("pungi", "nosource")
        self.is_debuginfo = not self.config.getboolean("pungi", "nodebuginfo")
        self.is_resolve_deps = self.config.getboolean("pungi", "resolve_deps")

        self.fulltree_excludes = set(self.ksparser.handler.fulltree_excludes)

    def _add_yum_repo(self, name, url, mirrorlist=False, groups=True,
                      cost=1000, includepkgs=None, excludepkgs=None,
                      proxy=None):
        """This function adds a repo to the yum object.
        name: Name of the repo
        url: Full url to the repo
        mirrorlist: Bool for whether or not url is a mirrorlist
        groups: Bool for whether or not to use groupdata from this repo
        cost: an optional int representing the cost of a repo
        includepkgs: An optional list of includes to use
        excludepkgs: An optional list of excludes to use
        proxy: An optional proxy to use
        """
        includepkgs = includepkgs or []
        excludepkgs = excludepkgs or []

        self.logger.info('Adding repo %s' % name)
        thisrepo = yum.yumRepo.YumRepository(name)
        thisrepo.name = name
        # add excludes and such here when pykickstart gets them
        if mirrorlist:
            thisrepo.mirrorlist = yum.parser.varReplace(url,
                                                        self.ayum.conf.yumvar)
            self.mirrorlists.append(thisrepo.mirrorlist)
            self.logger.info('Mirrorlist for repo %s is %s' %
                             (thisrepo.name, thisrepo.mirrorlist))
        else:
            thisrepo.baseurl = yum.parser.varReplace(url,
                                                     self.ayum.conf.yumvar)
            self.repos.extend(thisrepo.baseurl)
            self.logger.info('URL for repo %s is %s' %
                             (thisrepo.name, thisrepo.baseurl))
        thisrepo.basecachedir = self.ayum.conf.cachedir
        thisrepo.enablegroups = groups
        # This is until yum uses this failover by default
        thisrepo.failovermethod = 'priority'
        thisrepo.exclude = excludepkgs
        thisrepo.includepkgs = includepkgs
        thisrepo.cost = cost
        # Yum doesn't like proxy being None
        if proxy:
            thisrepo.proxy = proxy
        self.ayum.repos.add(thisrepo)
        self.ayum.repos.enableRepo(thisrepo.id)
        self.ayum._getRepos(thisrepo=thisrepo.id, doSetup=True)
        # Set the repo callback.
        self.ayum.repos.setProgressBar(CallBack())
        self.ayum.repos.callback = CallBack()
        thisrepo.metadata_expire = 0
        thisrepo.mirrorlist_expire = 0
        if os.path.exists(os.path.join(thisrepo.cachedir, 'repomd.xml')):
            os.remove(os.path.join(thisrepo.cachedir, 'repomd.xml'))

    @yumlocked
    def _inityum(self):
        """Initialize the yum object.  Only needed for certain actions."""

        # Create a yum object to use
        self.repos = []
        self.mirrorlists = []
        self.ayum = PungiYum(self.config)
        self.ayum.doLoggingSetup(6, 6)
        yumconf = yum.config.YumConf()
        yumconf.debuglevel = 6
        yumconf.errorlevel = 6
        yumconf.cachedir = self.config.get('pungi', 'cachedir')
        yumconf.persistdir = "/var/lib/yum" # keep at default, gets appended to installroot
        yumconf.installroot = os.path.join(self.workdir, 'yumroot')
        yumconf.uid = os.geteuid()
        yumconf.cache = 0
        yumconf.failovermethod = 'priority'
        yumconf.deltarpm = 0
        yumvars = yum.config._getEnvVar()
        yumvars['releasever'] = self.config.get('pungi', 'version')
        yumvars['basearch'] = yum.rpmUtils.arch.getBaseArch(myarch=self.tree_arch)
        yumconf.yumvar = yumvars
        self.ayum._conf = yumconf
        # I have no idea why this fixes a traceback, but James says it does.
        del self.ayum.prerepoconf
        self.ayum.repos.setCacheDir(self.ayum.conf.cachedir)

        self.ayum.arch.setup_arch(self.yum_arch)

        # deal with our repos
        try:
            self.ksparser.handler.repo.methodToRepo()
        except:
            pass

        for repo in self.ksparser.handler.repo.repoList:
            if repo.mirrorlist:
                # The not bool() thing is because pykickstart is yes/no on
                # whether to ignore groups, but yum is a yes/no on whether to
                # include groups.  Awkward.
                self._add_yum_repo(repo.name, repo.mirrorlist,
                                   mirrorlist=True,
                                   groups=not bool(repo.ignoregroups),
                                   cost=repo.cost,
                                   includepkgs=repo.includepkgs,
                                   excludepkgs=repo.excludepkgs,
                                   proxy=repo.proxy)
            else:
                self._add_yum_repo(repo.name, repo.baseurl,
                                   mirrorlist=False,
                                   groups=not bool(repo.ignoregroups),
                                   cost=repo.cost,
                                   includepkgs=repo.includepkgs,
                                   excludepkgs=repo.excludepkgs,
                                   proxy=repo.proxy)

        self.logger.info('Getting sacks for arches %s' % self.valid_arches)
        self.ayum._getSacks(archlist=self.valid_arches)

    def _filtersrcdebug(self, po):
        """Filter out package objects that are of 'src' arch."""

        if po.arch == 'src' or 'debuginfo' in po.name:
            return False

        return True

    def add_package(self, po, msg=None):
        if not is_package(po):
            raise ValueError("Not a binary package: %s" % po)
        if msg:
            self.logger.info(msg)
        if po not in self.po_list:
            self.po_list.add(po)
        self.ayum.install(po)
        self.sourcerpm_arch_map.setdefault(po.sourcerpm, set()).add(po.arch)

    def add_debuginfo(self, po, msg=None):
        if not is_debug(po):
            raise ValueError("Not a debuginfog package: %s" % po)
        if msg:
            self.logger.info(msg)
        if po not in self.debuginfo_po_list:
            self.debuginfo_po_list.add(po)

    def add_source(self, po, msg=None):
        if not is_source(po):
            raise ValueError("Not a source package: %s" % po)
        if msg:
            self.logger.info(msg)
        if po not in self.srpm_po_list:
            self.srpm_po_list.add(po)

    def verifyCachePkg(self, po, path): # Stolen from yum
        """check the package checksum vs the cache
           return True if pkg is good, False if not"""

        (csum_type, csum) = po.returnIdSum()

        try:
            filesum = yum.misc.checksum(csum_type, path)
        except yum.Errors.MiscError:
            return False

        if filesum != csum:
            return False

        return True

    def excludePackages(self, pkg_sack):
        """exclude packages according to config file"""
        if not pkg_sack:
            return pkg_sack

        excludes = [] # list of (name, arch, pattern)
        for i in self.ksparser.handler.packages.excludedList:
            pattern = i
            multilib = False
            if i.endswith(".+"):
                multilib = True
                i = i[:-2]
            name, arch = arch_module.split_name_arch(i)
            excludes.append((name, arch, pattern, multilib))

        for name in self.ksparser.handler.multilib_blacklist:
            excludes.append((name, None, "multilib-blacklist: %s" % name, True))

        for pkg in pkg_sack[:]:
            for name, arch, exclude_pattern, multilib in excludes:
                if fnmatch(pkg.name, name):
                    if not arch or fnmatch(pkg.arch, arch):
                        if multilib and pkg.arch not in self.valid_multilib_arches:
                            continue
                        if pkg.nvra not in self.excluded_pkgs:
                            self.logger.info("Excluding %s.%s (pattern: %s)" % (pkg.name, pkg.arch, exclude_pattern))
                            self.excluded_pkgs[pkg.nvra] = pkg
                        pkg_sack.remove(pkg)
                        break

        return pkg_sack

    def get_package_deps(self, po):
        """Add the dependencies for a given package to the
           transaction info"""
        added = set()
        if po in self.completed_depsolve:
            return added
        self.completed_depsolve.add(po)

        self.logger.info('Checking deps of %s.%s' % (po.name, po.arch))

        reqs = po.requires
        provs = po.provides

        for req in reqs:
            if req in self.resolved_deps:
                continue
            r, f, v = req
            if r.startswith('rpmlib(') or r.startswith('config('):
                continue
            if req in provs:
                continue

            try:
                deps = self.ayum.whatProvides(r, f, v).returnPackages()
                deps = self.excludePackages(deps)
                if not deps:
                    self.logger.warn("Unresolvable dependency %s in %s.%s" % (r, po.name, po.arch))
                    continue

                if self.greedy_method == "all":
                    deps = yum.packageSack.ListPackageSack(deps).returnNewestByNameArch()
                else:
                    found = False
                    for dep in deps:
                        if dep in self.po_list:
                            # HACK: there can be builds in the input list on which we want to apply the "build" greedy rules
                            if self.greedy_method == "build" and dep.sourcerpm not in self.completed_greedy_build:
                                break
                            found = True
                            break
                    if found:
                        deps = []
                    else:
                        all_deps = deps
                        deps = [self.ayum._bestPackageFromList(all_deps)]
                        if self.greedy_method == "build":
                            # handle "build" greedy method
                            if deps:
                                build_po = deps[0]
                                if is_package(build_po):
                                    if build_po.arch != "noarch" and build_po.arch not in self.valid_multilib_arches:
                                        all_deps = [ i for i in all_deps if i.arch not in self.valid_multilib_arches ]
                                    for dep in all_deps:
                                        if dep != build_po and dep.sourcerpm == build_po.sourcerpm:
                                            deps.append(dep)
                                            self.completed_greedy_build.add(dep.sourcerpm)

                for dep in deps:
                    if dep not in added:
                        msg = 'Added %s.%s (repo: %s) for %s.%s' % (dep.name, dep.arch, dep.repoid, po.name, po.arch)
                        self.add_package(dep, msg)
                        added.add(dep)

            except (yum.Errors.InstallError, yum.Errors.YumBaseError), ex:
                self.logger.warn("Unresolvable dependency %s in %s.%s (repo: %s)" % (r, po.name, po.arch, po.repoid))
                continue
            self.resolved_deps[req] = None

        for add in added:
            self.get_package_deps(add)
        return added

    def add_langpacks(self, po_list=None):
        po_list = po_list or self.po_list
        added = set()

        for po in sorted(po_list):
            if po in self.completed_langpacks:
                continue

            # get all langpacks matching the package name
            langpacks = [ i for i in self.langpacks if i["name"] == po.name ]
            if not langpacks:
                continue

            self.completed_langpacks.add(po)

            for langpack in langpacks:
                pattern = langpack["install"] % "*" # replace '%s' with '*'
                exactmatched, matched, unmatched = yum.packages.parsePackages(self.all_pkgs, [pattern], casematch=1, pkgdict=self.pkg_refs.copy())
                matches = filter(self._filtersrcdebug, exactmatched + matched)
                matches = [ i for i in matches if not i.name.endswith("-devel") and not i.name.endswith("-static") and i.name != "man-pages-overrides" ]
                matches = [ i for i in matches if fnmatch(i.name, pattern) ]

                packages_by_name = {}
                for i in matches:
                    packages_by_name.setdefault(i.name, []).append(i)

                for i, pkg_sack in packages_by_name.iteritems():
                    pkg_sack = self.excludePackages(pkg_sack)
                    match = self.ayum._bestPackageFromList(pkg_sack)
                    msg = 'Added langpack %s.%s (repo: %s) for package %s (pattern: %s)' % (match.name, match.arch, match.repoid, po.name, pattern)
                    self.add_package(match, msg)
                    self.completed_langpacks.add(match) # assuming langpack doesn't have langpacks
                    added.add(match)

        return added

    def add_multilib(self, po_list=None):
        po_list = po_list or self.po_list
        added = set()

        if not self.multilib_methods:
            return added

        for po in sorted(po_list):
            if po in self.completed_multilib:
                continue

            if po.arch in ("noarch", "src", "nosrc"):
                continue

            if po.arch in self.valid_multilib_arches:
                continue

            self.completed_multilib.add(po)

            matches = self.ayum.pkgSack.searchNevra(name=po.name, ver=po.version, rel=po.release)
            matches = [i for i in matches if i.arch in self.valid_multilib_arches]
            if not matches:
                continue
            matches = self.excludePackages(matches)
            match = self.ayum._bestPackageFromList(matches)
            if not match:
                continue

            if po.name in self.ksparser.handler.multilib_whitelist:
                msg = "Added multilib package %s.%s (repo: %s) for package %s.%s (method: %s)" % (match.name, match.arch, match.repoid, po.name, po.arch, "multilib-whitelist")
                self.add_package(match, msg)
                self.completed_multilib.add(match)
                added.add(match)
                continue

            method = multilib.po_is_multilib(po, self.multilib_methods)
            if not method:
                continue
            msg = "Added multilib package %s.%s (repo: %s) for package %s.%s (method: %s)" % (match.name, match.arch, match.repoid, po.name, po.arch, method)
            self.add_package(match, msg)
            self.completed_multilib.add(match)
            added.add(match)
        return added

    def getPackagesFromGroup(self, group):
        """Get a list of package names from a ksparser group object

            Returns a list of package names"""

        packages = []

        # Check if we have the group
        if not self.ayum.comps.has_group(group.name):
            self.logger.error("Group %s not found in comps!" % group)
            return packages

        # Get the group object to work with
        groupobj = self.ayum.comps.return_group(group.name)

        # Add the mandatory packages
        packages.extend(groupobj.mandatory_packages.keys())

        # Add the default packages unless we don't want them
        if group.include == 1:
            packages.extend(groupobj.default_packages.keys())

        # Add the optional packages if we want them
        if group.include == 2:
            packages.extend(groupobj.default_packages.keys())
            packages.extend(groupobj.optional_packages.keys())

        # Deal with conditional packages
        # Populate a dict with the name of the required package and value
        # of the package objects it would bring in.  To be used later if
        # we match the conditional.
        for condreq, cond in groupobj.conditional_packages.iteritems():
            matches = self.ayum.pkgSack.searchNevra(name=condreq)
            if matches:
                if self.greedy_method != "all":
                    # works for both "none" and "build" greedy methods
                    matches = [self.ayum._bestPackageFromList(matches)]
                self.ayum.tsInfo.conditionals.setdefault(cond, []).extend(matches)

        return packages

    def _addDefaultGroups(self, excludeGroups=None):
        """Cycle through the groups and return at list of the ones that ara
           default."""
        excludeGroups = excludeGroups or []

        # This is mostly stolen from anaconda.
        groups = map(lambda x: x.groupid,
            filter(lambda x: x.default, self.ayum.comps.groups))

        groups = [x for x in groups if x not in excludeGroups]

        self.logger.debug('Add default groups %s' % groups)
        return groups

    def get_langpacks(self):
        try:
            self.langpacks = list(self.ayum.comps.langpacks)
        except AttributeError:
            # old yum
            self.logger.warning("Could not get langpacks via yum.comps. You may need to update yum.")
            self.langpacks = []
        except yum.Errors.GroupsError:
            # no groups or no comps at all
            self.logger.warning("Could not get langpacks due to missing comps in repodata or --ignoregroups=true option.")
            self.langpacks = []

    def getPackageObjects(self):
        """Cycle through the list of packages and get package object matches."""

        searchlist = [] # The list of package names/globs to search for
        matchdict = {} # A dict of objects to names
        excludeGroups = [] # A list of groups for removal defined in the ks file

        # precompute pkgs and pkg_refs to speed things up
        self.all_pkgs = list(set(self.ayum.pkgSack.returnPackages()))
        self.all_pkgs = self.excludePackages(self.all_pkgs)


        lookaside_nvrs = set()
        for po in self.all_pkgs:
            if po.repoid in self.lookaside_repos:
                lookaside_nvrs.add(po.nvra)
        for po in self.all_pkgs[:]:
            if po.repoid not in self.lookaside_repos and po.nvra in lookaside_nvrs:
                self.logger.debug("Removed %s (repo: %s), because it's also in a lookaside repo" % (po, po.repoid))
                self.all_pkgs.remove(po)

        self.pkg_refs = yum.packages.buildPkgRefDict(self.all_pkgs, casematch=True)

        self.get_langpacks()

        # First remove the excludes
        self.ayum.excludePackages()

        # Get the groups set for removal
        for group in self.ksparser.handler.packages.excludedGroupList:
            excludeGroups.append(str(group)[1:])

        if "core" in [ i.groupid for i in self.ayum.comps.groups ]:
            if "core" not in [ i.name for i in self.ksparser.handler.packages.groupList ]:
                self.logger.warning("The @core group is no longer added by default; Please add @core to the kickstart if you want it in.")

        if "base" in [ i.groupid for i in self.ayum.comps.groups ]:
            if "base" not in [ i.name for i in self.ksparser.handler.packages.groupList ]:
                if self.ksparser.handler.packages.addBase:
                    self.logger.warning("The --nobase kickstart option is no longer supported; Please add @base to the kickstart if you want it in.")

        # Check to see if we want all the defaults
        if self.ksparser.handler.packages.default:
            for group in self._addDefaultGroups(excludeGroups):
                self.ksparser.handler.packages.add(['@%s' % group])

        # Get a list of packages from groups
        comps_package_names = set()
        for group in self.ksparser.handler.packages.groupList:
            comps_package_names.update(self.getPackagesFromGroup(group))
        searchlist.extend(sorted(comps_package_names))

        # Add packages
        searchlist.extend(self.ksparser.handler.packages.packageList)
        input_packages = searchlist[:]

        # Add prepopulate packages
        prepopulate_packages = self.ksparser.handler.prepopulate
        searchlist.extend(prepopulate_packages)

        # Make the search list unique
        searchlist = yum.misc.unique(searchlist)

        for name in searchlist:
            pattern = name
            multilib = False
            if name.endswith(".+"):
                name = name[:-2]
                multilib = True

            if self.greedy_method == "all" and name == "system-release":
                # HACK: handles a special case, when system-release virtual provide is specified in the greedy mode
                matches = self.ayum.whatProvides(name, None, None).returnPackages()
            else:
                exactmatched, matched, unmatched = yum.packages.parsePackages(self.all_pkgs, [name], casematch=1, pkgdict=self.pkg_refs.copy())
                matches = exactmatched + matched

            matches = filter(self._filtersrcdebug, matches)

            if multilib and self.greedy_method != "all":
                matches = [ po for po in matches if po.arch in self.valid_multilib_arches ]

            if not matches:
                self.logger.warn('Could not find a match for %s in any configured repo' % pattern)
                continue

            packages_by_name = {}
            for po in matches:
                packages_by_name.setdefault(po.name, []).append(po)

            for name, packages in packages_by_name.iteritems():
                packages = self.excludePackages(packages or [])
                if not packages:
                    continue
                if self.greedy_method == "all":
                    packages = yum.packageSack.ListPackageSack(packages).returnNewestByNameArch()
                else:
                    # works for both "none" and "build" greedy methods
                    packages = [self.ayum._bestPackageFromList(packages)]

                if name in input_packages:
                    self.input_packages.update(packages)
                if name in comps_package_names:
                    self.comps_packages.update(packages)

                for po in packages:
                    msg = 'Found %s.%s' % (po.name, po.arch)
                    self.add_package(po, msg)
                    name_arch = "%s.%s" % (po.name, po.arch)
                    if name_arch in prepopulate_packages:
                        self.prepopulate_packages.add(po)

        if not self.po_list:
            raise RuntimeError("No packages found")

        self.logger.info('Finished gathering package objects.')

    def gather(self):

        # get package objects according to the input list
        self.getPackageObjects()
        if self.is_sources:
            self.createSourceHashes()

        pass_num = 0
        added = set()
        while 1:
            if pass_num > 0 and not added:
                break
            added = set()
            pass_num += 1
            self.logger.info("Pass #%s" % pass_num)

            if self.is_resolve_deps:
                # get conditional deps (defined in comps)
                for txmbr in self.ayum.tsInfo:
                    if not txmbr.po in self.po_list:
                        if not is_package(txmbr.po):
                            # we don't want sources which can be pulled in, because 'src' arch is part of self.valid_arches
                            continue
                        self.add_package(txmbr.po)

            # resolve deps
            if self.is_resolve_deps:
                for po in sorted(self.po_list):
                    added.update(self.get_package_deps(po))

            if self.is_sources:
                added_srpms = self.add_srpms()
                added.update(added_srpms)

            if self.is_selfhosting:
                for srpm_po in sorted(added_srpms):
                    added.update(self.get_package_deps(srpm_po))

            if self.is_fulltree:
                new = self.add_fulltree()
                self.fulltree_packages.update(new)
                self.fulltree_packages.update([ self.sourcerpm_srpmpo_map[i.sourcerpm] for i in new ])
                added.update(new)
            if added:
                continue

            # add langpacks
            new = self.add_langpacks(self.po_list)
            self.langpack_packages.update(new)
            if self.is_sources:
                self.langpack_packages.update([ self.sourcerpm_srpmpo_map[i.sourcerpm] for i in new ])
            added.update(new)
            if added:
                continue

            # add multilib packages
            new = self.add_multilib(self.po_list)
            self.multilib_packages.update(new)
            self.multilib_packages.update([ self.sourcerpm_srpmpo_map[i.sourcerpm] for i in new ])
            added.update(new)
            if added:
                continue

    def get_srpm_po(self, po):
        """Given a package object, get a package object for the corresponding source rpm."""

        # return srpm_po from cache if available
        srpm_po = self.sourcerpm_srpmpo_map.get(po.sourcerpm, None)
        if srpm_po is not None:
            return srpm_po

        # arch can be "src" or "nosrc"
        nvr, arch, _ = po.sourcerpm.rsplit(".", 2)
        name, ver, rel = nvr.rsplit('-', 2)

        # ... but even "nosrc" packages are stored as "src" in repodata
        srpm_po_list = self.ayum.pkgSack.searchNevra(name=name, ver=ver, rel=rel, arch="src")
        if not srpm_po_list:
            raise RuntimeError("Cannot find a source rpm for %s" % po.sourcerpm)
        srpm_po = srpm_po_list[0]
        self.sourcerpm_srpmpo_map[po.sourcerpm] = srpm_po
        return srpm_po

    def createSourceHashes(self):
        """Create two dicts - one that maps binary POs to source POs, and
           one that maps a single source PO to all binary POs it produces.
           Requires yum still configured."""
        self.src_by_bin = {}
        self.bin_by_src = {}
        self.logger.info("Generating source <-> binary package mappings")
        #(dummy1, everything, dummy2) = yum.packages.parsePackages(self.all_pkgs, ['*'], pkgdict=self.pkg_refs.copy())
        failed = []
        for po in self.all_pkgs:
            if is_source(po):
                continue
            try:
                srpmpo = self.get_srpm_po(po)
            except RuntimeError:
                failed.append(po.sourcerpm)
                continue

            self.src_by_bin[po] = srpmpo
            if self.bin_by_src.has_key(srpmpo):
                self.bin_by_src[srpmpo].append(po)
            else:
                self.bin_by_src[srpmpo] = [po]

        if failed:
            self.logger.info("The following srpms could not be found: %s" % (
                pprint.pformat(list(sorted(failed)))))
            self.logger.info("Couldn't find %i of %i srpms." % (
                len(failed), len(self.src_by_bin)))
            raise RuntimeError("Could not find all srpms.")

    def add_srpms(self, po_list=None):
        """Cycle through the list of package objects and
           find the sourcerpm for them.  Requires yum still
           configured and a list of package objects"""

        srpms = set()
        po_list = po_list or self.po_list
        for po in sorted(po_list):
            srpm_po = self.sourcerpm_srpmpo_map[po.sourcerpm]
            if srpm_po in self.completed_add_srpms:
                continue
            msg = "Added source package %s.%s (repo: %s)" % (srpm_po.name, srpm_po.arch, srpm_po.repoid)
            self.add_source(srpm_po, msg)

            # flags
            if po in self.input_packages:
                self.input_packages.add(srpm_po)
            if po in self.fulltree_packages:
                self.fulltree_packages.add(srpm_po)
            if po in self.langpack_packages:
                self.langpack_packages.add(srpm_po)
            if po in self.multilib_packages:
                self.multilib_packages.add(srpm_po)

            self.completed_add_srpms.add(srpm_po)
            srpms.add(srpm_po)
        return srpms

    def add_fulltree(self, srpm_po_list=None):
        """Cycle through all package objects, and add any
           that correspond to a source rpm that we are including.
           Requires yum still configured and a list of package
           objects."""

        self.logger.info("Completing package set")

        srpm_po_list = srpm_po_list or self.srpm_po_list
        srpms = []
        for srpm_po in srpm_po_list:
            if srpm_po in self.completed_fulltree:
                continue
            if srpm_po.name not in self.fulltree_excludes:
                srpms.append(srpm_po)
            self.completed_fulltree.add(srpm_po)

        added = set()
        for srpm_po in srpms:
            include_native = False
            include_multilib = False
            has_native = False
            has_multilib = False

            for po in self.excludePackages(self.bin_by_src[srpm_po]):
                if not is_package(po):
                    continue
                if po.arch == "noarch":
                    continue
                if po not in self.po_list:
                    # process only already included packages
                    if po.arch in self.valid_multilib_arches:
                        has_multilib = True
                    elif po.arch in self.valid_native_arches:
                        has_native = True
                    continue
                if po.arch in self.valid_multilib_arches and self.greedy_method == "all":
                    include_multilib = True
                elif po.arch in self.valid_native_arches:
                    include_native = True

            # XXX: this is very fragile!
            # Do not make any changes unless you really know what you're doing!
            if not include_native:
                # if there's no native package already pulled in...
                if has_native and not include_multilib:
                    # include all native packages, but only if we're not pulling multilib already
                    # SCENARIO: a noarch package was already pulled in and there are x86_64 and i686 packages -> we want x86_64 in to complete the package set
                    include_native = True
                elif has_multilib:
                    # SCENARIO: a noarch package was already pulled in and there are no x86_64 packages; we want i686 in to complete the package set
                    include_multilib = True

            for po in self.excludePackages(self.bin_by_src[srpm_po]):
                if not is_package(po):
                    continue
                if po in self.po_list:
                    continue
                if po.arch != "noarch":
                    if po.arch in self.valid_multilib_arches:
                        if not include_multilib:
                            continue
                    if po.arch in self.valid_native_arches:
                        if not include_native:
                            continue
                msg = "Added %s.%s (repo: %s) to complete package set" % (po.name, po.arch, po.repoid)
                self.add_package(po, msg)
        return added

    def getDebuginfoList(self):
        """Cycle through the list of package objects and find
           debuginfo rpms for them.  Requires yum still
           configured and a list of package objects"""

        added = set()
        for po in self.all_pkgs:
            if not is_debug(po):
                continue

            if po.sourcerpm not in self.sourcerpm_arch_map:
                # TODO: print a warning / throw an error
                continue
            if not (set(self.compatible_arches[po.arch]) & set(self.sourcerpm_arch_map[po.sourcerpm]) - set(["noarch"])):
                # skip all incompatible arches
                # this pulls i386 debuginfo for a i686 package for example
                continue
            msg = 'Added debuginfo %s.%s (repo: %s)' % (po.name, po.arch, po.repoid)
            self.add_debuginfo(po, msg)

            # flags
            srpm_po = self.sourcerpm_srpmpo_map[po.sourcerpm]
            if srpm_po in self.input_packages:
                self.input_packages.add(po)
            if srpm_po in self.fulltree_packages:
                self.fulltree_packages.add(po)
            if srpm_po in self.langpack_packages:
                self.langpack_packages.add(po)
            if srpm_po in self.multilib_packages:
                self.multilib_packages.add(po)

            added.add(po)
        return added

    def _downloadPackageList(self, polist, relpkgdir):
        """Cycle through the list of package objects and
           download them from their respective repos."""

        downloads = []
        for pkg in polist:
            downloads.append('%s.%s' % (pkg.name, pkg.arch))
            downloads.sort()
        self.logger.info("Download list: %s" % downloads)

        pkgdir = os.path.join(self.config.get('pungi', 'destdir'),
                              self.config.get('pungi', 'version'),
                              self.config.get('pungi', 'flavor'),
                              relpkgdir)

        # Ensure the pkgdir exists, force if requested, and make sure we clean it out
        if relpkgdir.endswith('SRPMS'):
            # Since we share source dirs with other arches don't clean, but do allow us to use it
            pypungi.util._ensuredir(pkgdir, self.logger, force=True, clean=False)
        else:
            pypungi.util._ensuredir(pkgdir, self.logger, force=self.config.getboolean('pungi', 'force'), clean=True)

        probs = self.ayum.downloadPkgs(polist)

        if len(probs.keys()) > 0:
            self.logger.error("Errors were encountered while downloading packages.")
            for key in probs.keys():
                errors = yum.misc.unique(probs[key])
                for error in errors:
                    self.logger.error("%s: %s" % (key, error))
            sys.exit(1)

        for po in polist:
            basename = os.path.basename(po.relativepath)

            local = po.localPkg()
            if self.config.getboolean('pungi', 'nohash'):
                target = os.path.join(pkgdir, basename)
            else:
                target = os.path.join(pkgdir, po.name[0].lower(), basename)
                # Make sure we have the hashed dir available to link into we only want dirs there to corrospond to packages
                # that we are including so we can not just do A-Z 0-9
                pypungi.util._ensuredir(os.path.join(pkgdir, po.name[0].lower()), self.logger, force=True, clean=False)

            # Link downloaded package in (or link package from file repo)
            try:
                pypungi.util._link(local, target, self.logger, force=True)
                continue
            except:
                self.logger.error("Unable to link %s from the yum cache." % po.name)
                sys.exit(1)

        self.logger.info('Finished downloading packages.')

    @yumlocked
    def downloadPackages(self):
        """Download the package objects obtained in getPackageObjects()."""

        self._downloadPackageList(self.po_list,
                                  os.path.join(self.tree_arch,
                                               self.config.get('pungi', 'osdir'),
                                               self.config.get('pungi', 'product_path')))

    def makeCompsFile(self):
        """Gather any comps files we can from repos and merge them into one."""

        ourcompspath = os.path.join(self.workdir, '%s-%s-comps.xml' % (self.config.get('pungi', 'name'), self.config.get('pungi', 'version')))

        # Filter out things we don't include
        ourgroups = []
        for item in self.ksparser.handler.packages.groupList:
            g = self.ayum.comps.return_group(item.name)
            if g:
                ourgroups.append(g.groupid)
        allgroups = [g.groupid for g in self.ayum.comps.get_groups()]
        for group in allgroups:
            if group not in ourgroups and not self.ayum.comps.return_group(group).langonly:
                self.logger.info('Removing extra group %s from comps file' % (group,))
                del self.ayum.comps._groups[group]

        groups = [g.groupid for g in self.ayum.comps.get_groups()]
        envs = self.ayum.comps.get_environments()
        for env in envs:
            for group in env.groups:
                if group not in groups:
                    self.logger.info('Removing incomplete environment %s from comps file' % (env,))
                    del self.ayum.comps._environments[env.environmentid]
                    break

        ourcomps = open(ourcompspath, 'w')
        ourcomps.write(self.ayum.comps.xml())
        ourcomps.close()

        # Disable this until https://bugzilla.redhat.com/show_bug.cgi?id=442097 is fixed.
        # Run the xslt filter over our comps file
        #compsfilter = ['/usr/bin/xsltproc', '--novalid']
        #compsfilter.append('-o')
        #compsfilter.append(ourcompspath)
        #compsfilter.append('/usr/share/pungi/comps-cleanup.xsl')
        #compsfilter.append(ourcompspath)

        #pypungi.util._doRunCommand(compsfilter, self.logger)

    @yumlocked
    def downloadSRPMs(self):
        """Cycle through the list of srpms and
           find the package objects for them, Then download them."""

        # do the downloads
        self._downloadPackageList(self.srpm_po_list, os.path.join('source', 'SRPMS'))

    @yumlocked
    def downloadDebuginfo(self):
        """Cycle through the list of debuginfo rpms and
           download them."""

        # do the downloads
        self._downloadPackageList(self.debuginfo_po_list, os.path.join(self.tree_arch, 'debug'))

    def _list_packages(self, po_list):
        """Cycle through the list of packages and return their paths."""
        result = []
        for po in po_list:
            if po.repoid in self.lookaside_repos:
                continue

            flags = []

            # input
            if po in self.input_packages:
                flags.append("input")

            # comps
            if po in self.comps_packages:
                flags.append("comps")

            # prepopulate
            if po in self.prepopulate_packages:
                flags.append("prepopulate")

            # langpack
            if po in self.langpack_packages:
                flags.append("langpack")

            # multilib
            if po in self.multilib_packages:
                flags.append("multilib")

            # fulltree
            if po in self.fulltree_packages:
                flags.append("fulltree")

            # fulltree-exclude
            if is_source(po):
                srpm_name = po.name
            else:
                srpm_name = po.sourcerpm.rsplit("-", 2)[0]
            if srpm_name in self.fulltree_excludes:
                flags.append("fulltree-exclude")

            result.append({
                "path": os.path.join(po.basepath or "", po.relativepath),
                "flags": sorted(flags),
            })
        result.sort(lambda x, y: cmp(x["path"], y["path"]))
        return result

    def list_packages(self):
        """Cycle through the list of RPMs and return their paths."""
        return self._list_packages(self.po_list)

    def list_srpms(self):
        """Cycle through the list of SRPMs and return their paths."""
        return self._list_packages(self.srpm_po_list)

    def list_debuginfo(self):
        """Cycle through the list of DEBUGINFO RPMs and return their paths."""
        return self._list_packages(self.debuginfo_po_list)

    def _size_packages(self, po_list):
        return sum([ po.size for po in po_list if po.repoid not in self.lookaside_repos ])

    def size_packages(self):
        return self._size_packages(self.po_list)

    def size_srpms(self):
        return self._size_packages(self.srpm_po_list)

    def size_debuginfo(self):
        return self._size_packages(self.debuginfo_po_list)

    def writeinfo(self, line):
        """Append a line to the infofile in self.infofile"""


        f=open(self.infofile, "a+")
        f.write(line.strip() + "\n")
        f.close()

    def mkrelative(self, subfile):
        """Return the relative path for 'subfile' underneath the version dir."""

        basedir = os.path.join(self.destdir, self.config.get('pungi', 'version'))
        if subfile.startswith(basedir):
            return subfile.replace(basedir + os.path.sep, '')
        
    def _makeMetadata(self, path, cachedir, comps=False, repoview=False, repoviewtitle=False,
                      baseurl=False, output=False, basedir=False, update=True,
                      compress_type=None):
        """Create repodata and repoview."""
        
        conf = createrepo.MetaDataConfig()
        conf.cachedir = os.path.join(cachedir, 'createrepocache')
        conf.update = update
        conf.unique_md_filenames = True
        if output:
            conf.outputdir = output
        else:
            conf.outputdir = path
        conf.directory = path
        conf.database = True
        if comps:
            conf.groupfile = comps
        if basedir:
            conf.basedir = basedir
        if baseurl:
            conf.baseurl = baseurl
        if compress_type:
            conf.compress_type = compress_type
        repomatic = createrepo.MetaDataGenerator(conf)
        self.logger.info('Making repodata')
        repomatic.doPkgMetadata()
        repomatic.doRepoMetadata()
        repomatic.doFinalMove()
        
        if repoview:
            # setup the repoview call
            repoview = ['/usr/bin/repoview']
            repoview.append('--quiet')
            
            repoview.append('--state-dir')
            repoview.append(os.path.join(cachedir, 'repoviewcache'))
            
            if repoviewtitle:
                repoview.append('--title')
                repoview.append(repoviewtitle)
    
            repoview.append(path)
    
            # run the command
            pypungi.util._doRunCommand(repoview, self.logger)
        
    def doCreaterepo(self, comps=True):
        """Run createrepo to generate repodata in the tree."""


        compsfile = None
        if comps:
            compsfile = os.path.join(self.workdir, '%s-%s-comps.xml' % (self.config.get('pungi', 'name'), self.config.get('pungi', 'version')))
        
        # setup the cache dirs
        for target in ['createrepocache', 'repoviewcache']:
            pypungi.util._ensuredir(os.path.join(self.config.get('pungi', 'cachedir'),
                                            target), 
                               self.logger, 
                               force=True)
            
        repoviewtitle = '%s %s - %s' % (self.config.get('pungi', 'name'), 
                                        self.config.get('pungi', 'version'),
                                        self.tree_arch)

        cachedir = self.config.get('pungi', 'cachedir')
        compress_type = self.config.get('pungi', 'compress_type')

        # setup the createrepo call
        self._makeMetadata(self.topdir, cachedir, compsfile,
                           repoview=True, repoviewtitle=repoviewtitle,
                           compress_type=compress_type)

        # create repodata for debuginfo
        if self.config.getboolean('pungi', 'debuginfo'):
            path = os.path.join(self.archdir, 'debug')
            if not os.path.isdir(path):
                self.logger.debug("No debuginfo for %s" % self.tree_arch)
                return
            self._makeMetadata(path, cachedir, repoview=False,
                               compress_type=compress_type)

    def _shortenVolID(self):
        """shorten the volume id to make sure its under 32 characters"""

        subsitutions = {'Workstation': 'WS',
                        'Server': 'S',
                        'Cloud': 'C',
                        'Alpha': 'A',
                        'Beta': 'B',
                        'TC': 'T'}
        name = self.config.get('pungi', 'name')
        version = self.config.get('pungi', 'version')
        arch = self.tree_arch

        for k, v in subsitutions.iteritems():
            if k in name:
                name = name.replace(k, v)
            if k in version:
                version = version.replace(k, v)
        volid = "%s-%s-%s" % (name, version, arch)
        if len(volid) > 32:
            raise RuntimeError("Volume ID %s is longer than 32 characters" % volid)
        else:
            return volid

    def doBuildinstall(self):
        """Run lorax on the tree."""

        # the old ayum object has transaction data that confuse lorax, reinit.
        self._inityum()

        # Add the repo in the destdir to our yum object
        self._add_yum_repo('ourtree',
                           'file://%s' % self.topdir,
                           cost=10)

        product = self.config.get('pungi', 'name')
        version = self.config.get('pungi', 'version')
        release = '%s %s' % (self.config.get('pungi', 'name'), self.config.get('pungi', 'version'))

        variant = self.config.get('pungi', 'flavor')
        bugurl = self.config.get('pungi', 'bugurl')
        isfinal = self.config.get('pungi', 'isfinal')

        volid = self._shortenVolID()
        workdir = self.workdir
        outputdir = self.topdir

        # on ppc64 we need to tell lorax to only use ppc64 packages so that the media will run on all 64 bit ppc boxes
        if self.tree_arch == 'ppc64':
            self.ayum.arch.setup_arch('ppc64')
            self.ayum.compatarch = 'ppc64'
        elif self.tree_arch == 'ppc64le':
            self.ayum.arch.setup_arch('ppc64le')
            self.ayum.compatarch = 'ppc64le'

        # Only supported mac hardware is x86 make sure we only enable mac support on arches that need it
        if self.tree_arch in ['x86_64']:
            domacboot = True
        else:
            domacboot = False
        domacboot = False

        # run the command
        lorax = pylorax.Lorax()
        lorax.configure()

        lorax.run(self.ayum, product=product, version=version, release=release,
                  variant=variant, bugurl=bugurl, isfinal=isfinal, domacboot=domacboot,
                  workdir=workdir, outputdir=outputdir, volid=volid)

        # write out the tree data for snake
        self.writeinfo('tree: %s' % self.mkrelative(self.topdir))

        # Write out checksums for verifytree
        # First open the treeinfo file so that we can config parse it
        treeinfofile = os.path.join(self.topdir, '.treeinfo')

        try:
            treefile = open(treeinfofile, 'r')
        except IOError:
            self.logger.error("Could not read .treeinfo file: %s" % treefile)
            sys.exit(1)

        # Create a ConfigParser object out of the contents so that we can
        # write it back out later and not worry about formatting
        treeinfo = MyConfigParser()
        treeinfo.readfp(treefile)
        treefile.close()
        treeinfo.add_section('checksums')

        # Create a function to use with os.path.walk to sum the files
        # basepath is used to make the sum output relative
        sums = []
        def getsum(basepath, dir, files):
            for file in files:
                path = os.path.join(dir, file)
                # don't bother summing directories.  Won't work.
                if os.path.isdir(path):
                    continue
                sum = pypungi.util._doCheckSum(path, 'sha256', self.logger)
                outpath = path.replace(basepath, '')
                sums.append((outpath, sum))

        # Walk the os/images path to get sums of all the files
        os.path.walk(os.path.join(self.topdir, 'images'), getsum, self.topdir + '/')
        
        # Capture PPC images
        if self.tree_arch in ['ppc', 'ppc64', 'ppc64le']:
            os.path.walk(os.path.join(self.topdir, 'ppc'), getsum, self.topdir + '/')

        # Get a checksum of repomd.xml since it has within it sums for other files
        repomd = os.path.join(self.topdir, 'repodata', 'repomd.xml')
        sum = pypungi.util._doCheckSum(repomd, 'sha256', self.logger)
        sums.append((os.path.join('repodata', 'repomd.xml'), sum))

        # Now add the sums, and write the config out
        try:
            treefile = open(treeinfofile, 'w')
        except IOError:
            self.logger.error("Could not open .treeinfo for writing: %s" % treefile)
            sys.exit(1)

        for path, sum in sums:
            treeinfo.set('checksums', path, sum)

        treeinfo.write(treefile)
        treefile.close()

    def doGetRelnotes(self):
        """Get extra files from packages in the tree to put in the topdir of
           the tree."""


        docsdir = os.path.join(self.workdir, 'docs')
        relnoterpms = self.config.get('pungi', 'relnotepkgs').split()

        fileres = []
        for pattern in self.config.get('pungi', 'relnotefilere').split():
            fileres.append(re.compile(pattern))

        dirres = []
        for pattern in self.config.get('pungi', 'relnotedirre').split():
            dirres.append(re.compile(pattern))

        pypungi.util._ensuredir(docsdir, self.logger, force=self.config.getboolean('pungi', 'force'), clean=True)

        # Expload the packages we list as relnote packages
        pkgs = os.listdir(os.path.join(self.topdir, self.config.get('pungi', 'product_path')))

        rpm2cpio = ['/usr/bin/rpm2cpio']
        cpio = ['cpio', '-imud']

        for pkg in pkgs:
            pkgname = pkg.rsplit('-', 2)[0]
            for relnoterpm in relnoterpms:
                if pkgname == relnoterpm:
                    extraargs = [os.path.join(self.topdir, self.config.get('pungi', 'product_path'), pkg)]
                    try:
                        p1 = subprocess.Popen(rpm2cpio + extraargs, cwd=docsdir, stdout=subprocess.PIPE)
                        (out, err) = subprocess.Popen(cpio, cwd=docsdir, stdin=p1.stdout, stdout=subprocess.PIPE, 
                            stderr=subprocess.PIPE, universal_newlines=True).communicate()
                    except:
                        self.logger.error("Got an error from rpm2cpio")
                        self.logger.error(err)
                        raise

                    if out:
                        self.logger.debug(out)

        # Walk the tree for our files
        for dirpath, dirname, filelist in os.walk(docsdir):
            for filename in filelist:
                for regex in fileres:
                    if regex.match(filename) and not os.path.exists(os.path.join(self.topdir, filename)):
                        self.logger.info("Linking release note file %s" % filename)
                        pypungi.util._link(os.path.join(dirpath, filename),
                                           os.path.join(self.topdir, filename),
                                           self.logger,
                                           force=self.config.getboolean('pungi',
                                                                        'force'))
                        self.common_files.append(filename)

        # Walk the tree for our dirs
        for dirpath, dirname, filelist in os.walk(docsdir):
            for directory in dirname:
                for regex in dirres:
                    if regex.match(directory) and not os.path.exists(os.path.join(self.topdir, directory)):
                        self.logger.info("Copying release note dir %s" % directory)
                        shutil.copytree(os.path.join(dirpath, directory), os.path.join(self.topdir, directory))
        
    def _doIsoChecksum(self, path, csumfile):
        """Simple function to wrap creating checksums of iso files."""

        try:
            checkfile = open(csumfile, 'a')
        except IOError:
            self.logger.error("Could not open checksum file: %s" % csumfile)

        self.logger.info("Generating checksum of %s" % path)
        checksum = pypungi.util._doCheckSum(path, 'sha256', self.logger)
        if checksum:
            checkfile.write("%s *%s\n" % (checksum.replace('sha256:', ''), os.path.basename(path)))
        else:
            self.logger.error('Failed to generate checksum for %s' % checkfile)
            sys.exit(1)
        checkfile.close()

    def doCreateIsos(self):
        """Create iso of the tree."""

        if self.tree_arch.startswith('arm'):
            self.logger.info("ARCH: arm, not doing doCreateIsos().")
            return

        isolist = []
        ppcbootinfo = '/usr/share/lorax/config_files/ppc'

        pypungi.util._ensuredir(self.isodir, self.logger,
                           force=self.config.getboolean('pungi', 'force'),
                           clean=True) # This is risky...

        # setup the base command
        mkisofs = ['/usr/bin/mkisofs']
        mkisofs.extend(['-v', '-U', '-J', '-R', '-T', '-m', 'repoview', '-m', 'boot.iso']) # common mkisofs flags

        x86bootargs = ['-b', 'isolinux/isolinux.bin', '-c', 'isolinux/boot.cat', 
            '-no-emul-boot', '-boot-load-size', '4', '-boot-info-table']

        efibootargs = ['-eltorito-alt-boot', '-e', 'images/efiboot.img',
                       '-no-emul-boot']

        macbootargs = ['-eltorito-alt-boot', '-e', 'images/macboot.img',
                       '-no-emul-boot']

        ia64bootargs = ['-b', 'images/boot.img', '-no-emul-boot']

        ppcbootargs = ['-part', '-hfs', '-r', '-l', '-sysid', 'PPC', '-no-desktop', '-allow-multidot', '-chrp-boot']

        ppcbootargs.append('-map')
        ppcbootargs.append(os.path.join(ppcbootinfo, 'mapping'))

        ppcbootargs.append('-hfs-bless') # must be last

        isohybrid = ['/usr/bin/isohybrid']

        # Check the size of the tree
        # This size checking method may be bunk, accepting patches...
        if not self.tree_arch == 'source':
            treesize = int(subprocess.Popen(mkisofs + ['-print-size', '-quiet', self.topdir], stdout=subprocess.PIPE).communicate()[0])
        else:
            srcdir = os.path.join(self.config.get('pungi', 'destdir'), self.config.get('pungi', 'version'), 
                                  self.config.get('pungi', 'flavor'), 'source', 'SRPMS')

            treesize = int(subprocess.Popen(mkisofs + ['-print-size', '-quiet', srcdir], stdout=subprocess.PIPE).communicate()[0])
        # Size returned is 2KiB clusters or some such.  This translates that to MiB.
        treesize = treesize * 2048 / 1024 / 1024

        if treesize > 700: # we're larger than a 700meg CD
            isoname = '%s-DVD-%s-%s.iso' % (self.config.get('pungi', 'iso_basename'), self.tree_arch,
                self.config.get('pungi', 'version'))
        else:
            isoname = '%s-%s-%s.iso' % (self.config.get('pungi', 'iso_basename'), self.tree_arch,
                self.config.get('pungi', 'version'))

        isofile = os.path.join(self.isodir, isoname)

        # setup the extra mkisofs args
        extraargs = []

        if self.tree_arch == 'i386' or self.tree_arch == 'x86_64':
            extraargs.extend(x86bootargs)
            if self.tree_arch == 'x86_64':
                extraargs.extend(efibootargs)
                isohybrid.append('-u')
                if os.path.exists(os.path.join(self.topdir, 'images', 'macboot.img')):
                    extraargs.extend(macbootargs)
                    isohybrid.append('-m')
        elif self.tree_arch == 'ia64':
            extraargs.extend(ia64bootargs)
        elif self.tree_arch.startswith('ppc'):
            extraargs.extend(ppcbootargs)
            extraargs.append(os.path.join(self.topdir, "ppc/mac"))
        elif self.tree_arch.startswith('aarch64'):
            extraargs.extend(efibootargs)

        # NOTE: if this doesn't match what's in the bootloader config, the
        # image won't be bootable!
        extraargs.append('-V')
        extraargs.append(self._shortenVolID())

        extraargs.extend(['-o', isofile])

        isohybrid.append(isofile)

        if not self.tree_arch == 'source':
            extraargs.append(self.topdir)
        else:
            extraargs.append(os.path.join(self.archdir, 'SRPMS'))

        if self.config.get('pungi', 'no_dvd') == "False":
            # run the command
            pypungi.util._doRunCommand(mkisofs + extraargs, self.logger)

            # Run isohybrid on the iso as long as its not the source iso
            if os.path.exists("/usr/bin/isohybrid") and not self.tree_arch == 'source':
                pypungi.util._doRunCommand(isohybrid, self.logger)

            # implant md5 for mediacheck on all but source arches
            if not self.tree_arch == 'source':
                pypungi.util._doRunCommand(['/usr/bin/implantisomd5', isofile], self.logger)

        # shove the checksum into a file
        csumfile = os.path.join(self.isodir, '%s-%s-%s-CHECKSUM' % (
                                self.config.get('pungi', 'iso_basename'),
                                self.config.get('pungi', 'version'),
                                self.tree_arch))
        # Write a line about what checksums are used.
        # sha256sum is magic...
        file = open(csumfile, 'w')
        file.write('# The image checksum(s) are generated with sha256sum.\n')
        file.close()
        if self.config.get('pungi', 'no_dvd') == "False":
            self._doIsoChecksum(isofile, csumfile)

            # Write out a line describing the media
            self.writeinfo('media: %s' % self.mkrelative(isofile))

        # Now link the boot iso
        if not self.tree_arch == 'source' and \
        os.path.exists(os.path.join(self.topdir, 'images', 'boot.iso')) and \
        self.config.get('pungi', 'bootiso') == True:
            isoname = '%s-netinst-%s-%s.iso' % (self.config.get('pungi', 'iso_basename'),
                self.tree_arch, self.config.get('pungi', 'version'))
            isofile = os.path.join(self.isodir, isoname)

            # link the boot iso to the iso dir
            pypungi.util._link(os.path.join(self.topdir, 'images', 'boot.iso'), isofile, self.logger)

            # shove the checksum into a file
            self._doIsoChecksum(isofile, csumfile)

        self.logger.info("CreateIsos is done.")
