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

FILE="/etc/issue"

if ! /bin/grep -q "authorized" $FILE; then
	/bin/cat <<EOF >/etc/issue
-- WARNING --
This system is for the use of authorized users only. Individuals
using this computer system without authority or in excess of their
authority are subject to having all their activities on this system
monitored and recorded by system personnel. Anyone using this
system expressly consents to such monitoring and is advised that
if such monitoring reveals possible evidence of criminal activity
system personal may provide the evidence of such monitoring to law
enforcement officials.
EOF
fi
