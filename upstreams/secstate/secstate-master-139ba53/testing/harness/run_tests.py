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

import glob
import os
import sys
import optparse
import traceback
from secstate_harness.chroot import Chroot, ChrootException
from secstate_harness.testcase import TestCase

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
            '/etc/puppet',
            '/usr/share/puppet',
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
file_deps = ['/usr/bin/puppet',
             '/usr/bin/secstate',
             '/etc/ld.so.cache',
             '/usr/lib/locale/locale-archive',
             '/etc/nsswitch.conf',
             '/etc/libuser.conf',
             '/etc/default/useradd',
             '/usr/libexec/secstate/secstate_external_node',
             '/var/lib/secstate/puppet/site.pp',
             '/etc/mime.types',
             ] \
             + glob.glob('/usr/include/python' + PYVER + '/pyconfig-*.h')

def main():
   parser = optparse.OptionParser()
   parser.add_option('-c', '--chroot', dest='chroot', help='Path where to create the chroot (cannot exist yet)')
   parser.add_option('-v', '--verbose', dest='verbose', action='store_true', default=False, help='Print extra info such as generated dependencies')
   #parser.add_option('-f', '--force', dest='force', action='store_true', default=False, help='Force running of all commands even when one fails')
   options, args = parser.parse_args()
   
   try:
      chroot = Chroot(options.chroot, bind_mount_deps, dir_deps, binary_deps, file_deps)
      chroot.build_deps()
      if options.verbose:
         chroot.print_deps()
   except ChrootException, e:
      print(e)
      sys.exit(1)

   results = {}
   for test_path in args:
      try:
              try:
                 chroot.build_chroot()
                 tc = TestCase(test_path, options.chroot)
                 results[test_path] = tc.run_test()
              # exception during build of chroot   
              except ChrootException, ce:
                 print(ce)
                 traceback.print_exc()
              # execution during test run
              except Exception, e:
                 print(e)
                 traceback.print_exc()
      finally:
         #raw_input("Press Enter to continue")
         chroot.clean_chroot()
   
   success = 0
   fail = 0
   for key in results:
      value = results[key]
      if value:
         success +=1
      else:
         fail +=1
         
   print('\n')   
   print('Successfull tests : %d' % success)
   print('Failed tests      : %d' % fail)
if __name__ == "__main__":
   main()
   
