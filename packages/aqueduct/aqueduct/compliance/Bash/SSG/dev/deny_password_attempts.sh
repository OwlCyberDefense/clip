#!/bin/bash
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

FILES[0]="$FOLDER/system-auth"
FILES[1]="$FOLDER/password-auth"

[ -f "$FOLDER/$SYSAUTH" ] || [ -f "$FOLDER/$PASSAUTH" ] || exit 1

# Pattern for pam_unix.so and its replacement line
P1="auth\s+.*\s+pam\_unix\.so\s+nullok\s+try\_first\_pass"
R1="auth        required      pam_unix.so nullok try_first_pass"

# Pattern for pam_succeed_if.so and its replacement line
P2="auth\s+requisite\s+pam\_succeed\_if\.so\s+uid\s*>\=\s*500\s+quiet"
R2="auth        requisite     pam_succeed_if.so uid >=500  quiet"

# Pattern for pam_deny.so and its replacement line
P3="auth\s+.*\s+pam\_deny\.so"
R3="auth        required      pam_deny.so"

# Pattern for pam_faillock.so preauth and its replacement line.
P4="auth\s+required\s+pam\_faillock\.so\s+preauth\s+audit\s+silent\s+deny\=5\s+unlock\_time\=900"
R4="auth        required      pam_faillock.so preauth audit silent deny=5 unlock_time=900"

# Pattern for pam_faillock.so authfail and its replacement line
P5="auth\s+\[default\=die\]\s+pam\_faillock\.so\s+authfail\s+audit\sdeny\=5\s+unlock\_time\=900"
R5="auth        [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900"

# Pattern for pam_faillock.so authsucc and its replacement line.
P6="auth\s+sufficient\s+pam\_faillock\.so\s+authsucc\s+audit\s+deny\=5\s+unlock\_time\=900"
R6="auth        sufficient    pam_faillock.so authsucc audit deny=5 unlock_time=900"


function fix_line_in_pamd {
        PATTERN=$1; ANCHOR=$2; REPLACE=$3; FILE=$4; i=0;

	grep -Pqi $PATTERN $FILE
        if [ $? -eq 1 ]
        then
		sed -i -r -e "s|$ANCHOR|$REPLACE|g" $FILE
	fi
	}

# Replace the pam_unix.so line.  If this fails, add the pam_unix line under the pam_deny line.
for files in ${FILES[@]}; do
	sed -i -r -e "s@$P1@$R1@g" $files
	fix_line_in_pamd $P1 $P3 "$R3\n$R1" $files
	sed -i -r -e "s|(\#)*$P2|\#$R2|g" $files
	sed -i -r -e "s|(\#)*$P3|\#$R3|g" $files

	fix_line_in_pamd $P4 $P1 "$R4\n$R1" $files
	fix_line_in_pamd $P5 $P1 "$R1\n$R5" $files
	fix_line_in_pamd $P6 $P5 "$R5\n$R6" $files
	done
