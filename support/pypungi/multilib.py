#!/usr/bin/python
# -*- coding: utf-8 -*-


# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Library General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


import re
import fnmatch
import pathmatch

import pypungi



LINE_PATTERN_RE = re.compile(r"^\s*(?P<line>[^#]+)(:?\s+(?P<comment>#.*))?$")
RUNTIME_PATTERN_SPLIT_RE = re.compile(r"^\s*(?P<path>[^\s]+)\s+(?P<pattern>[^\s]+)(:?\s+(?P<comment>#.*))?$")
SONAME_PATTERN_RE = re.compile(r"^(.+\.so\.[a-zA-Z0-9_\.]+).*$")


def read_lines(lines):
    result = []
    for i in lines:
        i = i.strip()

        if not i:
            continue

        # skip comments
        if i.startswith("#"):
            continue

        match = LINE_PATTERN_RE.match(i)
        if match is None:
            raise ValueError("Couldn't parse line: %s" % i)
        gd = match.groupdict()
        result.append(gd["line"])
    return result


def read_lines_from_file(path):
    lines = open(path, "r").readlines()
    lines = read_lines(lines)
    return lines


def read_runtime_patterns(lines):
    result = []
    for i in read_lines(lines):
        match = RUNTIME_PATTERN_SPLIT_RE.match(i)
        if match is None:
            raise ValueError("Couldn't parse pattern: %s" % i)
        gd = match.groupdict()
        result.append((gd["path"], gd["pattern"]))
    return result


def read_runtime_patterns_from_file(path):
    lines = open(path, "r").readlines()
    return read_runtime_patterns(lines)


def expand_runtime_patterns(patterns):
    pm = pathmatch.PathMatch()
    result = []
    for path, pattern in patterns:
        for root in ("", "/opt/*/*/root"):
            # include Software Collections: /opt/<vendor>/<scl_name>/root/...
            if "$LIBDIR" in path:
                for lib_dir in ("/lib", "/lib64", "/usr/lib", "/usr/lib64"):
                    path_pattern = path.replace("$LIBDIR", lib_dir)
                    path_pattern = "%s/%s" % (root, path_pattern.lstrip("/"))
                    pm[path_pattern] = (path_pattern, pattern)
            else:
                path_pattern = "%s/%s" % (root, path.lstrip("/"))
                pm[path_pattern] = (path_pattern, pattern)
    return pm


class MultilibMethodBase(object):
    """a base class for multilib methods"""
    name = "base"

    def select(self, po):
        raise NotImplementedError

    def skip(self, po):
        if pypungi.is_noarch(po) or pypungi.is_source(po) or pypungi.is_debug(po):
            return True
        return False

    def is_kernel(self, po):
        for p_name, p_flag, (p_e, p_v, p_r) in po.provides:
            if p_name == "kernel":
                return True
        return False

    def is_kernel_devel(self, po):
        for p_name, p_flag, (p_e, p_v, p_r) in po.provides:
            if p_name == "kernel-devel":
                return True
        return False

    def is_kernel_or_kernel_devel(self, po):
        for p_name, p_flag, (p_e, p_v, p_r) in po.provides:
            if p_name in ("kernel", "kernel-devel"):
                return True
        return False


class NoneMultilibMethod(MultilibMethodBase):
    """multilib disabled"""
    name = "none"

    def select(self, po):
        return False


class AllMultilibMethod(MultilibMethodBase):
    """all packages are multilib"""
    name = "all"

    def select(self, po):
        if self.skip(po):
            return False
        return True


class RuntimeMultilibMethod(MultilibMethodBase):
    """pre-defined paths to libs"""
    name = "runtime"

    def __init__(self, **kwargs):
        self.blacklist = read_lines_from_file("/usr/share/pungi/multilib/runtime-blacklist.conf")
        self.whitelist = read_lines_from_file("/usr/share/pungi/multilib/runtime-whitelist.conf")
        self.patterns = expand_runtime_patterns(read_runtime_patterns_from_file("/usr/share/pungi/multilib/runtime-patterns.conf"))

    def select(self, po):
        if self.skip(po):
            return False
        if po.name in self.blacklist:
            return False
        if po.name in self.whitelist:
            return True
        if self.is_kernel(po):
            return False

        # gather all *.so.* provides from the RPM header
        provides = set()
        for i in po.provides:
            match = SONAME_PATTERN_RE.match(i[0])
            if match is not None:
                provides.add(match.group(1))

        for path in po.returnFileEntries() + po.returnFileEntries("ghost"):
            dirname, filename = path.rsplit("/", 1)
            dirname = dirname.rstrip("/")

            patterns = self.patterns[dirname]
            if not patterns:
                continue
            for dir_pattern, file_pattern in patterns:
                if file_pattern == "-":
                    return True
                if fnmatch.fnmatch(filename, file_pattern):
                    if ".so.*" in file_pattern:
                        if filename in provides:
                            # return only if the lib is provided in RPM header
                            # (some libs may be private, hence not exposed in Provides)
                            return True
                    else:
                        return True
        return False


class FileMultilibMethod(MultilibMethodBase):
    """explicitely defined whitelist and blacklist"""
    def __init__(self, **kwargs):
        self.name = "file"
        whitelist = kwargs.pop("whitelist", None)
        blacklist = kwargs.pop("blacklist", None)
        self.whitelist = self.read_file(whitelist)
        self.blacklist = self.read_file(blacklist)

    @staticmethod
    def read_file(path):
        if not path:
            return []
        result = [ i.strip() for i in open(path, "r") if not i.strip().startswith("#") ]
        return result

    def select(self, po):
        for pattern in self.blacklist:
            if fnmatch.fnmatch(po.name, pattern):
                return False
        for pattern in self.whitelist:
            if fnmatch.fnmatch(po.name, pattern):
                return False
        return False


class KernelMultilibMethod(MultilibMethodBase):
    """kernel and kernel-devel"""
    def __init__(self, **kwargs):
        self.name = "kernel"

    def select(self, po):
        if self.is_kernel_or_kernel_devel(po):
            return True
        return False


class YabootMultilibMethod(MultilibMethodBase):
    """yaboot on ppc"""
    def __init__(self, **kwargs):
        self.name = "yaboot"

    def select(self, po):
        if po.arch in ["ppc"]:
            if po.name.startswith("yaboot"):
                return True
        return False


class DevelMultilibMethod(MultilibMethodBase):
    """all -devel and -static packages"""
    name = "devel"

    def __init__(self, **kwargs):
        self.blacklist = read_lines_from_file("/usr/share/pungi/multilib/devel-blacklist.conf")
        self.whitelist = read_lines_from_file("/usr/share/pungi/multilib/devel-whitelist.conf")

    def select(self, po):
        if self.skip(po):
            return False
        if po.name in self.blacklist:
            return False
        if po.name in self.whitelist:
            return True
        if self.is_kernel_devel(po):
            return False
        # HACK: exclude ghc*
        if po.name.startswith("ghc-"):
            return False
        if po.name.endswith("-devel"):
            return True
        if po.name.endswith("-static"):
            return True
        for p_name, p_flag, (p_e, p_v, p_r) in po.provides:
            if p_name.endswith("-devel"):
                return True
            if p_name.endswith("-static"):
                return True
        return False


DEFAULT_METHODS = ["devel", "runtime"]
METHOD_MAP = {}
for cls in (AllMultilibMethod, DevelMultilibMethod, FileMultilibMethod, KernelMultilibMethod, NoneMultilibMethod, RuntimeMultilibMethod, YabootMultilibMethod):
    method = cls()
    METHOD_MAP[method.name] = method


def po_is_multilib(po, methods):
    for method_name in methods:
        if not method_name:
            continue
        method = METHOD_MAP[method_name]
        if method.select(po):
            return method_name
    return None


def do_multilib(yum_arch, methods, repos, tmpdir, logfile):
    import os
    import yum
    import rpm
    import logging

    archlist = yum.rpmUtils.arch.getArchList(yum_arch)

    yumbase = yum.YumBase()
    yumbase.preconf.init_plugins = False
    yumbase.preconf.root = tmpdir
    # order matters!
    # must run doConfigSetup() before touching yumbase.conf
    yumbase.doConfigSetup(fn="/dev/null")
    yumbase.conf.cache = False
    yumbase.conf.cachedir = tmpdir
    yumbase.conf.exactarch = True
    yumbase.conf.gpgcheck = False
    yumbase.conf.logfile = logfile
    yumbase.conf.plugins = False
    yumbase.conf.reposdir = []
    yumbase.verbose_logger.setLevel(logging.ERROR)

    yumbase.doRepoSetup()
    yumbase.doTsSetup()
    yumbase.doRpmDBSetup()
    yumbase.ts.pushVSFlags((rpm._RPMVSF_NOSIGNATURES|rpm._RPMVSF_NODIGESTS))

    for repo in yumbase.repos.findRepos("*"):
        repo.disable()

    for i, baseurl in enumerate(repos):
        repo_id = "multilib-%s" % i
        if "://" not in baseurl:
            baseurl = "file://" + os.path.abspath(baseurl)
        yumbase.add_enable_repo(repo_id, baseurls=[baseurl])

    yumbase.doSackSetup(archlist=archlist)
    yumbase.doSackFilelistPopulate()

    method_kwargs = {}

    result = []
    for po in sorted(yumbase.pkgSack):
        method = po_is_multilib(po, methods)
        if method:
            nvra = "%s-%s-%s.%s.rpm" % (po.name, po.version, po.release, po.arch)
            result.append((nvra, method))
    return result


def main():
    import optparse
    import shutil
    import tempfile

    class MyOptionParser(optparse.OptionParser):
        def print_help(self, *args, **kwargs):
            optparse.OptionParser.print_help(self, *args, **kwargs)
            print
            print "Available multilib methods:"
            for key, value in sorted(METHOD_MAP.items()):
                default = (key in DEFAULT_METHODS) and " (default)" or ""
                print "  %-10s %s%s" % (key, value.__doc__ or "", default)

    parser = MyOptionParser("usage: %prog [options]")

    parser.add_option(
        "--arch",
    )
    parser.add_option(
        "--method",
        action="append",
        default=DEFAULT_METHODS,
        help="multilib method",
    )
    parser.add_option(
        "--repo",
        dest="repos",
        action="append",
        help="path or url to yum repo; can be specified multiple times",
    )
    parser.add_option("--tmpdir")
    parser.add_option("--logfile", action="store")

    opts, args = parser.parse_args()

    if args:
        parser.error("no arguments expected")

    if not opts.repos:
        parser.error("provide at least one repo")

    for method_name in opts.method:
        if method_name not in METHOD_MAP:
            parser.error("unknown method: %s" % method_name)
    print opts.method

    tmpdir = opts.tmpdir
    if not opts.tmpdir:
        tmpdir = tempfile.mkdtemp(prefix="multilib_")

    nvra_list = do_multilib(opts.arch, opts.method, opts.repos, tmpdir, opts.logfile)
    for nvra, method in nvra_list:
        print "MULTILIB(%s): %s" % (method, nvra)

    if not opts.tmpdir:
        shutil.rmtree(tmpdir)


if __name__ == "__main__":
    main()
