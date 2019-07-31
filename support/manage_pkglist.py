#!/usr/bin/python

import os
import re
import sys
import subprocess
import argparse

#import rpm

from pykickstart.parser import KickstartParser
from pykickstart.version import makeVersion

verbose_output = False

buildrequires_regex = re.compile(r"^BuildRequires:\s*(?P<reqs>.+)$")
lorax_regex = re.compile(r"^installpkg\s*(?P<reqs>.+)$")
reposfrompath=[]

def verbose(info):
	global verbose_output
	if verbose_output:
		print info

def reqs_to_packages(config, reqs, arch):
	# resolve the reqs to package names
	package_names = set()
	repoquery_args = ["/usr/bin/repoquery", "-c", config, "--whatprovides", "--queryformat", "%{NAME}", "--archlist",arch]
	# TODO: see if this can be collapsed into a single call
	for r in reqs:
		verbose ("executing: %s" % (repoquery_args + [r],))
		repoquery = subprocess.Popen(repoquery_args + [r], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
		for line in repoquery.stdout:
			if line.strip():
				verbose ("Req %s provided by %s" % (r, line.strip()))
				package_names.add(line.strip())
			rc = repoquery.wait()
			if rc != 0:
				print "ERROR: repoquery exited with rc %s: stderr: %s" % (rc, repoquery.stderr.read())
				raise Exception("ERROR: repoquery exited with rc %s: stderr: %s" % (rc, repoquery.stderr.read()))

	if not package_names:
		print "Unmatched regs: %s" % reqs
		return set()

	# resolve package names to nvra form
	packages = set()
	repoquery_args = ["/usr/bin/repoquery", "-c", config, "--qf", "%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}","--archlist",arch]
	for p in package_names:
		repoquery_args.append(p)
	repoquery = subprocess.Popen(repoquery_args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	for line in repoquery.stdout:
		if line.strip():
			packages.add(line.strip())
	rc = repoquery.wait()
	if rc != 0:
		print "ERROR: repoquery exited with rc %s: stderr: %s" % (rc, repoquery.stderr.read())
		raise Exception("ERROR: repoquery exited with rc %s: stderr: %s" % (rc, repoquery.stderr.read()))
	return packages

dep_tree_regex = re.compile(r"(?: (?:\|   )*(?:\\_  ))?(?:\d+:)?(?P<pkg>.+) \[.*\]\n?")
def update_deps(config, reqs, deps, arch):
	# gather deps for all reqs
	repoquery_args = ["/usr/bin/repoquery", "-c", config, "--tree-requires", "--qf", "%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}", "--archlist",arch]
	repoquery_args = repoquery_args + reposfrompath
	for p in reqs:
		if p in deps:
			verbose ("not gathering deps for package %s because it has already been resolved" % (p,))
			continue

		verbose ("executing: %s" % (repoquery_args + [p],))
		repoquery = subprocess.Popen(repoquery_args + [p], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
		for line in repoquery.stdout:
			match = dep_tree_regex.search(line)
			if match:
				pkg = match.group("pkg")
				verbose ("match: '%s' from: '%s'" % (pkg, line))
				deps.add(pkg)
			else:
				print "no match: %s" % (line,)
		rc = repoquery.wait()
		if rc != 0:
			print "ERROR: repoquery exited with rc %s: stderr: %s" % (rc, repoquery.stderr.read())
			raise Exception("ERROR: repoquery exited with rc %s: stderr: %s" % (rc, repoquery.stderr.read()))

	'''
	for p in explicit_packages:
		print p
		repoquery_args.append(p)
	all_packages_single_repoquery = set()
	if True:
		print "executing: %s" % (repoquery_args,)
		repoquery = subprocess.Popen(repoquery_args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
		for line in repoquery.stdout:
			match = dep_tree_regex.search(line)
			if match:
				print "match s: '%s' from: '%s'" % (match.group("pkg"), line)
				all_packages_single_repoquery.add(match.group("pkg"))
			else:
				print "no match s: %s" % (line,)
		rc = repoquery.wait()
		if rc != 0:
			print "ERROR: repoquery exited with rc %s: stderr: %s" % (rc, repoquery.stderr.read())
			raise Exception("ERROR: repoquery exited with rc %s: stderr: %s" % (rc, repoquery.stderr.read()))
	only_in_single_query = all_packages_single_repoquery - all_packages_multiple_repoquery
	only_in_multiple_query = all_packages_multiple_repoquery - all_packages_single_repoquery
	if not only_in_single_query and not only_in_multiple_query:
		print "both repoquery usages produced the same results"
	else:
		if only_in_single_query:
			print "packages found only in the single query method: %s" % (only_in_single_query,)
		if only_in_multiple_query:
			print "packages found only in the multiple query method: %s" % (only_in_multiple_query,)
		
	all_packages = all_packages_single_repoquery + all_packages_multiple_repoquery
	'''

'''
def get_build_deps_using_repoquery():
	build_reqs = set()
	package_names = get_local_package_names()
	repoquery_args = ["repoquery", "-c", "test_yum.conf", "--requires", "--srpm"]
	for p in package_names:
		repoquery = subprocess.Popen(repoquery_args + [p], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
		for line in repoquery.stdout:
			if line.strip():
				build_reqs.add(line.strip())
		rc = repoquery.wait()
		if rc != 0:
			print "ERROR: repoquery exited with rc %s: stderr: %s" % (rc, repoquery.stderr.read())
			raise Exception("ERROR: repoquery exited with rc %s: stderr: %s" % (rc, repoquery.stderr.read()))
			
	return build_reqs
'''

'''
# use the rpm module to query a srpm for BuildRequires
def get_build_reqs_using_librpm(package_paths):
	build_reqs = list()
	ts = rpm.TransactionSet()

	for package_path in package_paths:
		fd = os.open(package_path, os.O_RDONLY)
		h = ts.hdrFromFdno(fd)
		build_reqs.update(h.dsFromHeader('requirename'))
	return build_reqs
'''

spec_req_regex = re.compile(r"^(?P<req>[a-zA-Z0-9_.\+-]+)")
# grep for BuildRequires in a .spec file
def get_build_reqs_from_spec(spec_path):
	reqs = set()
	for line in file(spec_path):
		match = buildrequires_regex.match(line.strip())
		if not match:
			continue

		reqs_str = match.group("reqs")
		reqs_list = reqs_str.split(' ')
		for req_str in reqs_list:
			match = spec_req_regex.match(req_str)
			if match:
				reqs.add(match.group("req"))
	return reqs

def get_build_reqs_from_lorax(lorax_path):
	reqs = set()
	for line in file(lorax_path):
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
	global reposfrompath
	repos = list()
	for r in repo_args:
		repo = dict()
		repo["pkgs"] = set()
		repo["path"], repo["pkglist"] = r.split(",")
		reposfrompath.append("--repofrompath")
		reposfrompath.append("%s,%s" % (os.path.basename(repo["pkglist"]), repo["path"]))
		if not os.path.exists(repo["path"]):
			raise Exception("ERROR: repo path %s does not exist" % (repo["path"],))
		repos.append(repo)
	return repos

def resolve_packages_to_repos(pkgs, repos):
	for pkg in pkgs:
		found = False
		for repo in repos:
			pkg_path = os.path.join(repo["path"], "%s.rpm" % (pkg,))
			if os.path.exists(pkg_path):
				repo["pkgs"].add(pkg)
				found = True
				break
			elif pkg in repo["pkgs"]:
				found = True
				break
		if not found:
			print "ERROR: package %s could not be found" % (pkg,)
			#raise Exception("ERROR: package %s could not be found" % (pkg,))

def read_pkglist(pkglist_path):
	packages = set()
	if not os.path.exists(pkglist_path):
		return packages

	f = file(pkglist_path, "r")
	for line in f:
		line = line.strip()[:-4]
		if line:
			packages.add(line)
	return packages

def read_pkglists(repos):
	for repo in repos:
		repo["pkgs"].update(read_pkglist(repo["pkglist"]))

def dump_pkglist(pkglist_path, pkgs):
	f = file(pkglist_path, "w")
	pkg_list = list(pkgs)
	pkg_list.sort()
	f.write("\n".join(["%s.rpm" % (p,) for p in pkg_list]) + "\n")
	f.close()
	print "Updated %s" % (pkglist_path,)

def dump_pkglists(repos):
	for repo in repos:
		dump_pkglist(repo["pkglist"], repo["pkgs"])

def main():
	parser = argparse.ArgumentParser(description="Create a minimal list of dependencies from kickstarts, .spec files, and requirement strings.")
	parser.add_argument("COMMAND", choices=["create", "add"])
	parser.add_argument("-c", "--config", default="/etc/yum.conf")
	parser.add_argument("-k", "--kickstart", action="append")
	parser.add_argument("-s", "--spec", action="append")
	parser.add_argument("-l", "--lorax", action="append")
	parser.add_argument("-a", "--arch", default="x86_64,noarch")
	parser.add_argument("-r", "--require", action="append")
	parser.add_argument('-v', "--verbose", action="store_true", default=False)
	parser.add_argument("repo", help="repository information.  for each repository, 2 components must be supplied in the following form:  repo_path,pkglis", nargs="+", metavar="PATH,PKGLIST")
	parser.add_argument("-t", "--runtime", action='store_true', help="Generate list of run time dependencies instead of build time dependencies")
	args = parser.parse_args()

	global verbose_output
	global buildrequires_regex
	if args.runtime:
		print "Using only Requires tags"
		buildrequires_regex = re.compile(r"^Requires:\s*(?P<reqs>.+)$")
	else:
		print "Using both Requires and BuildRequires tags"
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
	manual_reqs = args.require
	if manual_reqs is None:
		manual_reqs = list()
	verbose_output = args.verbose

	arch = args.arch
	repos = repos_from_args(args.repo)
	reqs = set()

	# gather packages to install from kickstart
	for k in kickstarts:
		if not os.path.exists(k):
			raise Exception("ERROR: Kickstart %s does not exist" % (k,))
		tmp = get_kickstart_reqs(k)
		reqs.update(tmp)

	# gather build requirements from .spec file
	for s in specs:
		if not os.path.exists(s):
			raise Exception("ERROR: spec file %s does not exist" % (s,))
		tmp = get_build_reqs_from_spec(s)
		verbose ("List of requirements (%s) from spec: %s" % (tmp, s))
		reqs.update(tmp)

	for l in lorax:
		if not os.path.exists(l):
			raise Exception("ERROR: lorax file %s does not exist" % (l,))
		tmp = get_build_reqs_from_lorax(l)
		verbose ("List of requirements (%s) from spec: %s" % (tmp, l))
		reqs.update(tmp)

	# requirement strings (capabilities, files, packages)
	reqs.update(manual_reqs)


	dependencies = set()

	# convert req strings to specific packages
	required_packages = reqs_to_packages(config, reqs, arch)

	# gather all dependent packages
	update_deps(config, required_packages, dependencies, arch)

	# incorporate existing pkglist contents
	if command == "add":
		read_pkglists(repos)
		for repo in repos:
			dependencies.update(repo["pkgs"])

	# sort packages into the right repos
	resolve_packages_to_repos(dependencies, repos)

	# write new pkglist files
	dump_pkglists(repos)


if __name__ == "__main__":
	sys.exit(main())

