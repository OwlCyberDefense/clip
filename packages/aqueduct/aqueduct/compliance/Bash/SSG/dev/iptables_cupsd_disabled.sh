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

IP="/etc/sysconfig/iptables"
IP6="/etc/sysconfig/ip6tables"

# If there are no iptables, panic.
[ -f "$IP" ] || [ -f "$IP6" ] || exit 1

P1="-A RH-Firewall-1-INPUT -p udp -m udp --dport 631 -j ACCEPT"

P2="-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 631 -j ACCEPT"

[ -f "$IP" ] && /bin/sed -i -r -e "/($P1|$P2)/d" $IP
[ -f "$IP6" ] && /bin/sed -i -r -e "/($P1|$P2)/d" $IP6
