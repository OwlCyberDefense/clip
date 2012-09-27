#!/bin/bash -u
set -e

# 
# Copyright (c) 2012 Tresys Technology LLC, Columbia, Maryland, USA
#
# This software was developed by Tresys Technology LLC
# with U.S. Government sponsorship.
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

. $(dirname $0)/set_avahi_common

# Set the following [publish] entries to no.
# "disable-user-service-publishing," "publish-addresses," "publish-hinfo,"
# "publish-workstation," "publish-domain"

add_section_entry disable-user-service-publishing yes publish
add_section_entry publish-addresses no publish
add_section_entry publish-hinfo no publish
add_section_entry publish-workstation no publish
add_section_entry publish-domain no publish
