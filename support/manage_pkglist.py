#!/usr/bin/python

import argparse
import dnf
import os
import re
import sys
import rpm

from configparser import ConfigParser
from pykickstart.parser import KickstartParser
from pykickstart.version import makeVersion

verbose_output = False

buildrequires_regex = re.compile(r"^BuildRequires:\s*(?P<reqs>.+)$")
lorax_regex = re.compile(r"^installpkg\s*(?P<reqs>.+)$")
spec_req_regex = re.compile(r"^(?P<req>[a-zA-Z0-9_\(\).\+/\-]+)")

def verbose(info):
	global verbose_output
	if verbose_output:
		print(info)

def load_repodata(dnf_file, cache_dir, arch='x86_64'):

	dnf_config = ConfigParser ()
	dnf_config.read (dnf_file)

	base = dnf.Base ()
	base.conf.read (dnf_file)

	base.conf.fastestmirror=True
	base.conf.zchunk = False
	base.conf.timeout = 5

#	base.conf.config_file_path = "/dev/null"
	base.conf.persistdir = cache_dir
	base.conf.cachedir = cache_dir
	base.conf.substitutions["arch"] = arch
	base.conf.substitutions["basearch"] = dnf.rpm.basearch (arch)

	for section in dnf_config.sections ():
		enabled = False
		url = None
		name = None

		if dnf_config.has_option (section, "enabled"):
			enabled = dnf_config.getboolean (section, "enabled")
		if not enabled:
			continue

		repo = dnf.repo.Repo (section, base.conf)
		if dnf_config.has_option (section, "name"):
			name = dnf_config.get (section, "name")
		if dnf_config.has_option (section, "baseurl"):
			repo.baseurl = dnf_config.get (section, "baseurl")
		if dnf_config.has_option (section, "mirrorlist"):
			repo.mirrorlist = dnf_config.get (section, "mirrorlist")
		if dnf_config.has_option (section, "metalink"):
			repo.metalink = dnf_config.get (section, "metalink")
		if dnf_config.has_option (section, "gpgcheck"):
			repo.gpgcheck = dnf_config.get (section, "gpgcheck")
		if dnf_config.has_option (section, "gpgkey"):
			repo.gpgkey = dnf_config.get (section, "gpgkey")

		if dnf_config.has_option (section, "sslverify"):
			repo.sslverify = dnf_config.get (section, "sslverify")
		if dnf_config.has_option (section, "sslcacert"):
			repo.sslcacert = dnf_config.get (section, "sslcacert")
		if dnf_config.has_option (section, "sslclientkey"):
			repo.sslclientkey = dnf_config.get (section, "sslclientkey")
		if dnf_config.has_option (section, "sslclientcert"):
			repo.sslclientcert = dnf_config.get (section, "sslclientcert")

		base.repos.add (repo)
	base.fill_sack(load_system_repo=False)

	return base

# grep for BuildRequires in a .spec file
def get_build_reqs_from_spec(spec_path):
	reqs = set()
	with open(spec_path, "r") as spec:
		for line in spec:
			match = buildrequires_regex.match(line.strip())
			if not match:
				continue

			reqs_str = match.group("reqs")
			reqs_list = reqs_str.split(' ')
			for req_str in reqs_list:
				print("Requirement: %s" % reqs_list)
				match = spec_req_regex.match(req_str)
				if match:
					reqs.add(match.group("req"))
	return reqs

def get_build_reqs_from_rpm(rpm_path):
	reqs = set()
	fdno = os.open(rpm_path, os.O_RDONLY)
	ts = rpm.ts()
	hdr = ts.hdrFromFdno(fdno)
	os.close(fdno)

	for line in hdr[rpm.RPMTAG_REQUIRES]:
		reqs.add(line)

	return reqs

def get_build_reqs_from_lorax(lorax_path):
	reqs = set()
	with open(lorax_path, "r") as lorax:
		for line in lorax:
			match = lorax_regex.match(line.strip())
			if not match:
				continue

			reqs_str = match.group("reqs")
			reqs_list = reqs_str.split(' ')
			for req_str in reqs_list:
				match = spec_req_regex.match(req_str)
				if match:
					reqs.add(match.group("req"))
	return reqs


# parse the %packages section of a kickstart to determine
# what packages are to be installed
def get_kickstart_reqs(kickstart_path):
	# gather all of the reqs listed in the %packages sections
	reqs = set()
	ksparser = KickstartParser(makeVersion())
	ksparser.readKickstart(kickstart_path)
	reqs.update(ksparser.handler.packages.packageList)
	return reqs


def repos_from_args(repo_args):
	repos = dict()
	for r in repo_args:
		repo = dict()
		repo["pkgs"] = set()
		repo["path"], repo["pkglist"] = r.split(",")
		# add 'file://' prefix or local directories (to match dnf config)
		if repo["path"].find ("://") == -1:
			repo["path"] = "file://" + repo["path"]
		# if path begins with file:// - check if it really exists
		if repo["path"].startswith ("file://"):
			local_path = repo["path"][7:]
			if not os.path.exists(local_path):
				raise Exception("ERROR: repo path %s does not exist" % (repo["path"],))
		repos[repo["path"]] = repo
	return repos


def read_pkglist(pkglist_path):
	packages = set()
	if not os.path.exists(pkglist_path):
		return packages

	with open(pkglist_path, "r") as f:
		for line in f:
			line = line.strip()[:-4]
			if line:
				packages.add(line)
	return packages


def read_pkglists(repos):
	for repo in repos:
		repo["pkgs"].update(read_pkglist(repo["pkglist"]))

def dump_pkglist(pkglist_path, pkgs):
	with open(pkglist_path, "w") as f:
		pkg_list = list(pkgs)
		pkg_list.sort()
		for p in pkg_list:
			f.write("%s\n" % os.path.basename (p.location))
	verbose("INFO: Updated %s" % (pkglist_path,))


def dump_pkglists(repos, dnf_conf):
	for pkg in dnf_conf.transaction.install_set:
		repo = dnf_conf.repos[pkg.repoid]

		if repo.mirrorlist is not None:
			# works when using mirror list
			rid = repo.mirrorlist
		elif repo.metalink is not None:
			rid = repo.metalink
		elif repo.baseurl is not None:
			# works when giving URLs for repos to this script
			rid = repo.baseurl[0]
		else:
			# work when giving local path for repo
			rid = repo.pkgdir
		repos[rid]["pkgs"].add (pkg)

	for repo in repos:
		d = repos[repo]
		dump_pkglist(d["pkglist"], d["pkgs"])

def main():
	parser = argparse.ArgumentParser(description="Create a minimal list of dependencies from kickstarts, .spec files, and requirement strings.")
	parser.add_argument("COMMAND", choices=["create", "add"])
	parser.add_argument("-c", "--config", default="/etc/yum.conf")
	parser.add_argument("-k", "--kickstart", action="append")
	parser.add_argument("-s", "--spec", action="append")
	parser.add_argument("-l", "--lorax", action="append")
	parser.add_argument("-a", "--arch", default="x86_64,noarch")
	parser.add_argument("-d", "--dnf_cache", default="tmp", action="store")
	parser.add_argument("-p", "--package", action="append")
	parser.add_argument("-r", "--require", action="append")
	parser.add_argument("-R", "--required-versions-file", action="append")
	parser.add_argument('-v', "--verbose", action="store_true", default=False)
	parser.add_argument("repo", help="repository information.  for each repository, 2 components must be supplied in the following form:  repo_path,pkglis", nargs="+", metavar="PATH,PKGLIST")
	parser.add_argument("-t", "--runtime", action='store_true', help="Generate list of run time dependencies instead of build time dependencies")
	args = parser.parse_args()

	global verbose_output
	global buildrequires_regex
	if args.runtime:
		verbose("Using only Requires tags")
		buildrequires_regex = re.compile(r"^Requires:\s*(?P<reqs>.+)$")
	else:
		verbose("Using both Requires and BuildRequires tags")
		buildrequires_regex = re.compile(r"^(Build)?Requires:\s*(?P<reqs>.+)$")

	config = args.config
	command = args.COMMAND
	kickstarts = args.kickstart
	if kickstarts is None:
		kickstarts = list()
	specs = args.spec
	if specs is None:
		specs = list()
	lorax = args.lorax
	if lorax is None:
		lorax = list()
	packages= args.package
	if packages is None:
		packages = list ()
	manual_reqs = args.require
	if manual_reqs is None:
		manual_reqs = list()
	required_versions_file = args.required_versions_file
	if required_versions_file is None:
		required_versions_file = list()
	verbose_output = args.verbose

	arch = args.arch
	repos = repos_from_args(args.repo)
	reqs = set()

	# gather packages to install from kickstart
	for k in kickstarts:
		if not os.path.exists(k):
			raise Exception("ERROR: Kickstart %s does not exist" % (k,))
		tmp = get_kickstart_reqs(k)
		verbose ("INFO: Requirements from kickstart: %s %s" % (k, tmp))
		reqs.update(tmp)

	# gather build requirements from .spec file
	for s in specs:
		if not os.path.exists(s):
			raise Exception("ERROR: spec file %s does not exist" % (s,))
		tmp = get_build_reqs_from_spec(s)
		verbose ("INFO: Requirements from spec: %s %s" % (s, tmp))
		reqs.update(tmp)

	for l in lorax:
		if not os.path.exists(l):
			raise Exception("ERROR: lorax file %s does not exist" % (l,))
		tmp = get_build_reqs_from_lorax(l)
		verbose ("INFO: Requirements from lorax: %s %s" % (l, tmp))
		reqs.update(tmp)

	for p in packages:
		if not os.path.exists(p):
			raise Exception("ERROR: package file %s does not exist" % (p,))
		tmp = get_build_reqs_from_rpm(p)
		verbose ("List of requirements (%s) from rpm: %s" % (tmp, p))
		reqs.update(tmp)

	# load repodata
	dnf_conf = load_repodata(config, args.dnf_cache)

	# requirement strings (capabilities, files, packages)
	reqs.update(manual_reqs)

	dependencies = set()

	for req in reqs:
		try:
			dnf_conf.install_specs ([req], strict=False)
		except dnf.exceptions.MarkingErrors as me:
			print ("ERROR: Unable find package %s: %s" % (req, me))

	try:
#		dnf_conf.install_specs (reqs, strict=False)
		dnf_conf.resolve ()
	except dnf.exceptions.MarkingErrors as me:
		print ("dnf errors: %s" % me)

	# write new pkglist files
	dump_pkglists(repos, dnf_conf)


if __name__ == "__main__":
	sys.exit(main())

