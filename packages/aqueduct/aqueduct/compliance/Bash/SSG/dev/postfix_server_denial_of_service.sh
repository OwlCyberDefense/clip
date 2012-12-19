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

FILE="/etc/postfix/main.cf"

[ -f /etc/init.d/postfix ] || exit 0
[ -f $FILE ] || exit 1

. ($dirname $0)/set_general_entry
safe_add_field "(default_process_limit\s+=\s+).*" 100 $FILE
safe_add_field "(smptd_client_connection_count_limit\s+=\s+).*" 10 $FILE
safe_add_field "(smptd_client_connection_rate_limit\s+=\s+).*" 30 $FILE
safe_add_field "(queue_minfree\s+=\s+).*" 20971520 $FILE
safe_add_field "(header_size_limit\s+=\s+).*" 51200 $FILE
safe_add_field "(message_size_limit\s+=\s+).*" 10485760 $FILE
safe_add_field "(smptd_recipient_limit\s+=\s+).*" 100 $FILE
