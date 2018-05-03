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
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.


import rpmUtils.arch


TREE_ARCH_YUM_ARCH_MAP = {
    "i386": "athlon",
    "ppc64": "ppc64p7",
    "sparc": "sparc64v",
    "arm": "armv7l",
    "armhfp": "armv7hnl",
}


def tree_arch_to_yum_arch(tree_arch):
    # this is basically an opposite to rpmUtils.arch.getBaseArch()
    yum_arch = TREE_ARCH_YUM_ARCH_MAP.get(tree_arch, tree_arch)
    return yum_arch


def get_multilib_arch(yum_arch):
    arch_info = rpmUtils.arch.getMultiArchInfo(yum_arch)
    if arch_info is None:
        return None
    return arch_info[0]


def get_valid_multilib_arches(tree_arch):
    yum_arch = tree_arch_to_yum_arch(tree_arch)
    multilib_arch = get_multilib_arch(yum_arch)
    if not multilib_arch:
        return []
    return [ i for i in rpmUtils.arch.getArchList(multilib_arch) if i not in ("noarch", "src") ]


def get_valid_arches(tree_arch, multilib=True, add_noarch=True, add_src=False):
    result = []

    yum_arch = tree_arch_to_yum_arch(tree_arch)
    for arch in rpmUtils.arch.getArchList(yum_arch):
        if arch not in result:
            result.append(arch)

    if not multilib:
        for i in get_valid_multilib_arches(tree_arch):
            while i in result:
                result.remove(i)

    if add_noarch and "noarch" not in result:
        result.append("noarch")

    if add_src and "src" not in result:
        result.append("src")

    return result


def get_compatible_arches(arch, multilib=False):
    tree_arch = rpmUtils.arch.getBaseArch(arch)
    compatible_arches = get_valid_arches(tree_arch, multilib=multilib)
    return compatible_arches


def is_valid_arch(arch):
    if arch in ("noarch", "src", "nosrc"):
        return True
    if arch in rpmUtils.arch.arches:
        return True
    return False


def split_name_arch(name_arch):
    if "." in name_arch:
        name, arch = name_arch.rsplit(".", 1)
        if not is_valid_arch(arch):
            name, arch = name_arch, None
    else:
        name, arch = name_arch, None
    return name, arch
