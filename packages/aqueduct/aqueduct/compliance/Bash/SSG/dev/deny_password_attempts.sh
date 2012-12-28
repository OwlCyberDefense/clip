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

# deny_password_attempts

FOLDER="/etc/pam.d"

[ -f ${FOLDER}/system-auth-ac ] || [ -f ${FOLDER}/password-auth ] || exit 1

. $(dirname $0)/set_general_entry
add_entry_after "^.*pam_env\.so.*$" "auth required pam_tally2.so deny=$var_accounts_passwords_pam_faillock_deny onerr=fail unlock_time=900" ${FOLDER}/system-auth-ac

add_entry_after "^.*pam_env\.so.*$" "auth required pam_tally2.so deny=$var_accounts_passwords_pam_faillock_deny onerr=fail unlock_time=900" ${FOLDER}/password-auth
