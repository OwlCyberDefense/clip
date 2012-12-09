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

. $(dirname $0)/audit_rules_common

add_rule '-a exit,always -F arch=b32 -S sethostname -S setdomainname -k audit_network_modifications'
if /bin/uname -m|/bin/grep -q 64; then
    add_rule '-a exit,always -F arch=b64 -S sethostname -S setdomainname -k audit_network_modifications'
fi
add_rule '-w /etc/issue -p wa -k audit_network_modifications'
add_rule '-w /etc/issue.net -p wa -k audit_network_modifications'
add_rule '-w /etc/hosts -p wa -k audit_network_modifications'
add_rule '-w /etc/sysconfig/network -p wa -k audit_network_modifications'
add_rule ''
