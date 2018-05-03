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

import os
import pypungi
import pypungi.config
import yum
import pykickstart.parser
import pykickstart.version
import subprocess

def main():

    config = pypungi.config.Config()

    (opts, args) = get_arguments(config)

    # You must be this high to ride if you're going to do root tasks
    if os.geteuid () != 0 and (opts.do_all or opts.do_buildinstall):
        print >> sys.stderr, "You must run pungi as root"
        return 1
    
    if opts.do_all or opts.do_buildinstall:
        try:
            selinux = subprocess.Popen('/usr/sbin/getenforce', 
                                       stdout=subprocess.PIPE, 
                                       stderr=open('/dev/null', 'w')).communicate()[0].strip('\n')
            if selinux == 'Enforcing':
                print >> sys.stdout, "WARNING: SELinux is enforcing.  This may lead to a compose with selinux disabled."
                print >> sys.stdout, "Consider running with setenforce 0."
        except:
            pass

    # Set up the kickstart parser and pass in the kickstart file we were handed
    ksparser = pykickstart.parser.KickstartParser(pykickstart.version.makeVersion())
    ksparser.readKickstart(opts.config)

    if opts.sourceisos:
        config.set('pungi', 'arch', 'source')

    for part in ksparser.handler.partition.partitions:
        if part.mountpoint == 'iso':
            config.set('pungi', 'cdsize', str(part.size))
            
    config.set('pungi', 'force', str(opts.force))

    # Set up our directories
    if not os.path.exists(config.get('pungi', 'destdir')):
        try:
            os.makedirs(config.get('pungi', 'destdir'))
        except OSError, e:
            print >> sys.stderr, "Error: Cannot create destination dir %s" % config.get('pungi', 'destdir')
            sys.exit(1)
    else:
        print >> sys.stdout, "Warning: Reusing existing destination directory."

    cachedir = config.get('pungi', 'cachedir')

    if not os.path.exists(cachedir):
        try:
            os.makedirs(cachedir)
        except OSError, e:
            print >> sys.stderr, "Error: Cannot create cache dir %s" % cachedir
            sys.exit(1)

    # Set debuginfo flag
    if opts.nodebuginfo:
        config.set('pungi', 'debuginfo', "False")
    if opts.nogreedy:
        config.set('pungi', 'alldeps', "False")
    if opts.isfinal:
        config.set('pungi', 'isfinal', "True")
    if opts.nohash:
        config.set('pungi', 'nohash', "True")
    if opts.full_archlist:
        config.set('pungi', 'full_archlist', "True")
    if opts.arch:
        config.set('pungi', 'arch', opts.arch)

    # Actually do work.
    mypungi = pypungi.Pungi(config, ksparser)

    if not opts.sourceisos:
        if opts.do_all or opts.do_gather or opts.do_buildinstall:
            mypungi._inityum() # initialize the yum object for things that need it
        if opts.do_all or opts.do_gather:
            mypungi.getPackageObjects()
            if not opts.nosource or opts.selfhosting or opts.fulltree:
                mypungi.createSourceHashes()
                mypungi.getSRPMList()
            if opts.selfhosting:
                mypungi.resolvePackageBuildDeps()
            if opts.fulltree:
                mypungi.completePackageSet()
            if opts.selfhosting and opts.fulltree:
                # OUCH.
                while 1:
                    plen = len(mypungi.srpmpolist)
                    mypungi.resolvePackageBuildDeps()
                    if plen == len(mypungi.srpmpolist):
                        break
                    plen = len(mypungi.srpmpolist)
                    mypungi.completePackageSet()
                    if plen == len(mypungi.srpmpolist):
                        break
            if opts.nodownload:
                for line in mypungi.listPackages():
                    sys.stdout.write("RPM: %s\n" % line)
                sys.stdout.flush()
            else:
                mypungi.downloadPackages()
            mypungi.makeCompsFile()
            if not opts.nodebuginfo:
                mypungi.getDebuginfoList()
                if opts.nodownload:
                    for line in mypungi.listDebuginfo():
                        sys.stdout.write("DEBUGINFO: %s\n" % line)
                    sys.stdout.flush()
                else:
                    mypungi.downloadDebuginfo()
            if not opts.nosource:
                if opts.nodownload:
                    for line in mypungi.listSRPMs():
                        sys.stdout.write("SRPM: %s\n" % line)
                    sys.stdout.flush()
                else:
                    mypungi.downloadSRPMs()

        if opts.do_all or opts.do_createrepo:
            mypungi.doCreaterepo()

        if opts.do_all or opts.do_buildinstall:
            if not opts.norelnotes:
                mypungi.doGetRelnotes()
            mypungi.doBuildinstall()

        if opts.do_all or opts.do_createiso:
            mypungi.doCreateIsos()

    # Do things slightly different for src.
    if opts.sourceisos:
        # we already have all the content gathered
        mypungi.topdir = os.path.join(config.get('pungi', 'destdir'),
                                      config.get('pungi', 'version'),
                                      config.get('pungi', 'flavor'),
                                      'source', 'SRPMS')
        mypungi.doCreaterepo(comps=False)
        if opts.do_all or opts.do_createiso:
            mypungi.doCreateIsos()

    print "All done!"

if __name__ == '__main__':
    from optparse import OptionParser
    import sys
    import time

    today = time.strftime('%Y%m%d', time.localtime())

    def get_arguments(config):
        parser = OptionParser("%prog [--help] [options]", version="%prog 2.9")

        def set_config(option, opt_str, value, parser, config):
            config.set('pungi', option.dest, value)
            # When setting name, also set the iso_basename.
            if option.dest == 'name':
                config.set('pungi', 'iso_basename', value)

        # Pulled in from config file to be cli options as part of pykickstart conversion
        parser.add_option("--name", dest="name", type="string",
          action="callback", callback=set_config, callback_args=(config, ),
          help='the name for your distribution (defaults to "Fedora")')
        parser.add_option("--ver", dest="version", type="string",
          action="callback", callback=set_config, callback_args=(config, ),
          help='the version of your distribution (defaults to datestamp)')
        parser.add_option("--flavor", dest="flavor", type="string",
          action="callback", callback=set_config, callback_args=(config, ),
          help='the flavor of your distribution spin (optional)')
        parser.add_option("--destdir", dest="destdir", type="string",
          action="callback", callback=set_config, callback_args=(config, ),
          help='destination directory (defaults to current directory)')
        parser.add_option("--cachedir", dest="cachedir", type="string",
          action="callback", callback=set_config, callback_args=(config, ),
          help='package cache directory (defaults to /var/cache/pungi)')
        parser.add_option("--bugurl", dest="bugurl", type="string",
          action="callback", callback=set_config, callback_args=(config, ),
          help='the url for your bug system (defaults to http://bugzilla.redhat.com)')
        parser.add_option("--selfhosting", action="store_true", dest="selfhosting",
          help='build a self-hosting tree by following build dependencies (optional)')
        parser.add_option("--fulltree", action="store_true", dest="fulltree",
          help='build a tree that includes all packages built from corresponding source rpms (optional)')
        parser.add_option("--nosource", action="store_true", dest="nosource",
          help='disable gathering of source packages (optional)')
        parser.add_option("--nodebuginfo", action="store_true", dest="nodebuginfo",
          help='disable gathering of debuginfo packages (optional)')
        parser.add_option("--nodownload", action="store_true", dest="nodownload",
          help='disable downloading of packages. instead, print the package URLs (optional)')
        parser.add_option("--norelnotes", action="store_true", dest="norelnotes",
          help='disable gathering of release notes (optional)')
        parser.add_option("--nogreedy", action="store_true", dest="nogreedy",
          help='disable pulling of all providers of package dependencies (optional)')
        parser.add_option("--sourceisos", default=False, action="store_true", dest="sourceisos",
          help='Create the source isos (other arch runs must be done)')
        parser.add_option("--force", default=False, action="store_true",
          help='Force reuse of an existing destination directory (will overwrite files)')
        parser.add_option("--isfinal", default=False, action="store_true", 	
          help='Specify this is a GA tree, which causes betanag to be turned off during install')
        parser.add_option("--nohash", default=False, action="store_true",
          help='disable hashing the Packages trees')
        parser.add_option("--full-archlist", action="store_true",
          help='Use the full arch list for x86_64 (include i686, i386, etc.)')
        parser.add_option("--arch",
          help='Override default (uname based) arch')

        parser.add_option("-c", "--config", dest="config",
          help='Path to kickstart config file')
        parser.add_option("--all-stages", action="store_true", default=True, dest="do_all",
          help="Enable ALL stages")
        parser.add_option("-G", action="store_true", default=False, dest="do_gather",
          help="Flag to enable processing the Gather stage")
        parser.add_option("-C", action="store_true", default=False, dest="do_createrepo",
          help="Flag to enable processing the Createrepo stage")
        parser.add_option("-B", action="store_true", default=False, dest="do_buildinstall",
          help="Flag to enable processing the BuildInstall stage")
        parser.add_option("-I", action="store_true", default=False, dest="do_createiso",
          help="Flag to enable processing the CreateISO stage")


        (opts, args) = parser.parse_args()

        if not opts.config:
            parser.error("Please specify a config file")

        if not config.get('pungi', 'flavor').isalnum() and not config.get('pungi', 'flavor') == '':
            parser.error("Flavor must be alphanumeric")

        if opts.do_gather or opts.do_createrepo or opts.do_buildinstall or opts.do_createiso:
            opts.do_all = False

        if opts.arch and (opts.do_all or opts.do_buildinstall):
            parser.error("Cannot override arch while the BuildInstall stage is enabled")

        return (opts, args)

    main()
