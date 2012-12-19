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

[ -f ${FOLDER}/system-auth ] || [ -f ${FOLDER}/password-auth ] || exit 0

# Pattern for pam_unix.so and its replacement line
P1="auth\s+.*\s+pam\_unix\.so\s+nullok\s+try\_first\_pass"
R1='auth        required      pam_unix.so nullok try_first_pass'

# Pattern for pam_succeed_if.so and its replacement line
P2="auth\s+requisite\s+pam\_succeed\_if\.so\s+uid\s*>\=\s*500\s+quiet"
R2='auth        requisite     pam_succeed_if.so uid >=500  quiet'

# Pattern for pam_deny.so and its replacement line
P3="auth\s+.*\s+pam\_deny\.so"
R3='auth        required      pam_deny.so'

# Pattern for pam_faillock.so preauth and its replacement line.
P4="auth\s+required\s+pam\_faillock\.so\s+preauth\s+audit\s+silent\s+deny\=5\s+unlock\_time\=900"
R4='auth        required      pam_faillock.so preauth audit silent deny=5 unlock_time=900'

# Pattern for pam_faillock.so authfail and its replacement line
P5="auth\s+\[default\=die\]\s+pam\_faillock\.so\s+authfail\s+audit\sdeny\=5\s+unlock\_time\=900"
R5='auth        [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900'

# Pattern for pam_faillock.so authsucc and its replacement line.
P6="auth\s+sufficient\s+pam\_faillock\.so\s+authsucc\s+audit\s+deny\=5\s+unlock\_time\=900"
R6='auth        sufficient    pam_faillock.so authsucc audit deny=5 unlock_time=900'

. $(dirname $0)/set_general_entry
safe_add_field "()$P1" "$R1" ${FOLDER}/system-auth
safe_add_field "()$P1" "$R1" ${FOLDER}/password-auth

add_entry_before "$R3" "$R1" ${FOLDER}/system-auth
add_entry_before "$R3" "$R1" ${FOLDER}/password-auth

add_entry_before "$R4" "$R1" ${FOLDER}/system-auth
add_entry_after "$R1" "$R5" ${FOLDER}/password-auth

add_entry_before "$R5" "$R6" ${FOLDER}/system-auth
