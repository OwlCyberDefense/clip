#
# clip.py
#
# Copyright (C) 2018  Tresys Technology.  All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
import os
from pyanaconda.installclass import BaseInstallClass

__all__ = ["CLIPBaseInstallClass"]


class CLIPBaseInstallClass(BaseInstallClass):
	name = "CLIP"
	sortPriority = 30000
	defaultFS = "xfs"

	_l10n_domain = "anaconda"

	rel_file = open ("/etc/system-release", "r")
	release = rel_file.readline()
	rel_file.close ()

	if release.startswith ("Red Hat"):
		efi_dir = "redhat"
	elif release.startswith ("CentOS"):
		efi_dir = "centos"
	elif release.startswith ("Fedora"):
		efi_dir = "fedora"
	else:
		efi_dir = "clip"

	help_placeholder = "FedoraPlaceholder.html"
	help_placeholder_with_links = "FedoraPlaceholderWithLinks.html"

	def configure(self, anaconda):
		BaseInstallClass.configure(self, anaconda)

	def __init__(self):
		BaseInstallClass.__init__(self)

