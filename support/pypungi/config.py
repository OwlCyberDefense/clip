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
import time
import yum

from ConfigParser import SafeConfigParser

class Config(SafeConfigParser):
    def __init__(self):
        SafeConfigParser.__init__(self)

        self.add_section('pungi')

        self.set('pungi', 'osdir', 'os')
        self.set('pungi', 'sourcedir', 'source')
        self.set('pungi', 'debugdir', 'debug')
        self.set('pungi', 'isodir', 'iso')
        self.set('pungi', 'relnotefilere', 'GPL README-BURNING-ISOS-en_US.txt ^RPM-GPG')
        self.set('pungi', 'relnotedirre', '')
        self.set('pungi', 'relnotepkgs', 'fedora-release fedora-release-notes')
        self.set('pungi', 'product_path', 'Packages')
        self.set('pungi', 'cachedir', '/var/cache/pungi')
        self.set('pungi', 'arch', yum.rpmUtils.arch.getBaseArch())
        self.set('pungi', 'name', 'Fedora')
        self.set('pungi', 'iso_basename', 'Fedora')
        self.set('pungi', 'version', time.strftime('%Y%m%d', time.localtime()))
        self.set('pungi', 'flavor', '')
        self.set('pungi', 'destdir', os.getcwd())
        self.set('pungi', 'bugurl', 'https://bugzilla.redhat.com')
        self.set('pungi', 'cdsize', '695.0')
        self.set('pungi', 'debuginfo', "True")
        self.set('pungi', 'alldeps', "True")
        self.set('pungi', 'isfinal', "False")
        self.set('pungi', 'nohash', "False")
        self.set('pungi', 'full_archlist', "False")

