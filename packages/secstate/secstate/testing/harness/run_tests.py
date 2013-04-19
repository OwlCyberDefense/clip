#!/usr/bin/python -E
# Copyright (C) 2010 Tresys Technology, LLC
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Lesser General Public
#  License as published by the Free Software Foundation; either
#  version 2.1 of the License, or (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public
#  License along with this library; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#  Authors: Spencer Shimko <sshimko@tresys.com>
#           Stuart Reynard <sreynard@tresys.com>
#           Matt Keeler    <mkeeler@tresys.com>

import signal
import glob
import os
import sys
import optparse
import traceback
from secstate_harness.chroot import Chroot, ChrootException
from secstate_harness.testcase import TestCase, PASSED, FIXED, FAILED

PYVER = sys.version[:3]
ARCH_64 = 'x86_64'

ARCH = os.uname()[4]

USR_LIB = '/usr/lib'
if ARCH == ARCH_64:
    USR_LIB = '/usr/lib64'

LIB = '/lib'
if ARCH == ARCH_64:
    LIB = '/lib64'


# directories to bind mount
bind_mount_deps = ["/dev","/sys","/proc","/selinux"]

# important directories to be copied in recursively
dir_deps = ["/etc/secstate",
            '/usr/share/secstate',
            '/usr/share/openscap',
            ] \
            + glob.glob('/usr/lib*/ruby')

# binary apps,libraries to copy into the chroot + determine deps for via ldd
binary_deps = ['/usr/bin/python',
               '/usr/bin/ruby',
               USR_LIB + '/python' + PYVER + '/lib-dynload/pyexpat.so',
               '/usr/libexec/openscap/probe_family',
               '/usr/libexec/openscap/probe_file',
               '/usr/libexec/openscap/probe_filehash',
               '/usr/libexec/openscap/probe_filehash58',
               '/usr/libexec/openscap/probe_inetlisteningservers',
               '/usr/libexec/openscap/probe_interface',
               '/usr/libexec/openscap/probe_password',
               '/usr/libexec/openscap/probe_process',
               '/usr/libexec/openscap/probe_rpminfo',
               '/usr/libexec/openscap/probe_runlevel',
               '/usr/libexec/openscap/probe_shadow',
               '/usr/libexec/openscap/probe_system_info',
               '/usr/libexec/openscap/probe_textfilecontent',
               '/usr/libexec/openscap/probe_textfilecontent54',
               '/usr/libexec/openscap/probe_uname',
               '/usr/libexec/openscap/probe_xinetd',
               '/usr/libexec/openscap/probe_xmlfilecontent',
               '/bin/mkdir',
               '/bin/chown',
               '/bin/chgrp',
               '/bin/sh',
               '/bin/bash',
               '/usr/bin/stat',
               '/bin/uname',
               '/bin/hostname',
               '/bin/domainname',
               '/bin/dnsdomainname',
               '/sbin/ifconfig',
               '/bin/cat',
               '/usr/sbin/sestatus',
               '/bin/grep',
               '/bin/awk',
               '/bin/sed',
               '/bin/mount',
               '/usr/bin/uniq',
               '/bin/sort',
               '/bin/chmod',
               '/usr/bin/tr',
               '/usr/bin/cut',
               '/usr/bin/wc',
               '/usr/bin/hostid',
               '/usr/bin/uptime',
               '/sbin/lspci',
               '/usr/sbin/dmidecode',
               '/usr/bin/whoami',
               '/usr/bin/passwd',
               '/usr/bin/test',
               '/usr/bin/[',
               ] \
               + glob.glob(LIB + '/libnss_files.so.*') \
               + glob.glob(USR_LIB + '/libopenscap.so.*') \
               + glob.glob(USR_LIB + '/libexslt.so.*') \
               + glob.glob(USR_LIB + '/libxslt.so.*') \
               + glob.glob(USR_LIB + '/libssl.so.*') \
               + glob.glob(USR_LIB + '/libuser/*') \

# script executables and other regular files to copy into the chroot
file_deps = ['/usr/sbin/secstate',
             '/etc/ld.so.cache',
             '/usr/lib/locale/locale-archive',
             '/etc/nsswitch.conf',
             '/etc/libuser.conf',
             '/etc/default/useradd',
             '/etc/mime.types',
             ] \
             + glob.glob('/usr/include/python' + PYVER + '/pyconfig-*.h')

def run_tests(tests):
   results = {}
   for test_path in tests:
      try:
              try:
                 chroot.build_chroot()
                 tc = TestCase(test_path, options.chroot, fixtests=options.fixtests)
                 results[test_path] = tc.run_test()
              # exception during build of chroot   
              except ChrootException, ce:
                 print(ce)
                 results[test_path] = None 
                 traceback.print_exc()
              # execution during test run
              except Exception, e:
                 print(e)
                 results[test_path] = None
                 traceback.print_exc()
              except KeyboardInterrupt, e:
                 chroot.clean_chroot()
      finally:
         #raw_input("Press Enter to continue")
         chroot.clean_chroot()
   return results

def main():
   parser = optparse.OptionParser()
   parser.add_option('-c', '--chroot', dest='chroot', help='Path where to create the chroot (cannot exist yet)')
   parser.add_option('-v', '--verbose', dest='verbose', action='store_true', default=False, help='Print extra info such as generated dependencies')
   parser.add_option('-x', '--fix', dest='fixtests', action='store_true', default=False,
                     help="Offer to fix broken tests.")
   options, args = parser.parse_args()
   
   try:
      chroot = Chroot(options.chroot, bind_mount_deps, dir_deps, binary_deps, file_deps)
      chroot.build_deps()
      if options.verbose:
         chroot.print_deps()
   except ChrootException, e:
      print(e)
      sys.exit(1)

   fix = 1
   while fix > 0:
       results = {}
       for test_path in args:
           try:
               try:
                   chroot.build_chroot()
                   tc = TestCase(test_path, options.chroot, fixtests=options.fixtests)
                   results[test_path] = tc.run_test()
               # exception during build of chroot   
               except ChrootException, ce:
                   print(ce)
                   results[test_path] = None 
                   traceback.print_exc()
               # execution during test run
               except Exception, e:
                   print(e)
                   results[test_path] = None
                   traceback.print_exc()
           finally:
              #raw_input("Press Enter to continue")
              chroot.clean_chroot()

       success = 0
       fail = 0
       broke = 0
       fix = 0
       failed = []
       broken = []
       fixed = []

       for key in results:
          value = results[key]
          if value is None:
              broke += 1
              broken.append(key)
          elif value == PASSED:
             success +=1
          elif value == FAILED:
             fail +=1
             failed.append(key)
          elif value == FIXED:
             fix += 1
             fixed.append(key)
             
       print('\n')   
       print('Successful tests  : %d' % success)
       print('Failed tests      : %d' % fail)
       print('Broken tests      : %d' % broke)
       print('Fixed tests       : %d' % fix)
       print('Total tests       : %d' % len(args))

       for i, test in enumerate(failed):
            print "Failed test %d: %s" % (i + 1, test.split("/")[1])
       for i, test in enumerate(broken):
            print "Broken test %d: %s" % (i + 1, test.split("/")[1])
       for i, test in enumerate(fixed):
            print "Fixed test %d: %s" % (i + 1, test.split("/")[1])
       
       if fix > 0:
           rerun_fixed = raw_input("Would you like to re-run the fixed tests? [Y/n]: ")
           if rerun_fixed.lower().startswith("y"):
               args = fixed
           else:
               return


#Catch signals
def handle_signals(signum, frame):
   sys.exit(signum)

if __name__ == "__main__":
   signal.signal(signal.SIGINT, handle_signals)
   main()
