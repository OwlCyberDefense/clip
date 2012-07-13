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

[ -f $FILE ] || exit 1

PATTERN="^(\s)*(\#)*(\s)*(default_process_limit)(\s*\=\s*.*)"
grep -Eq $PATTERN $FILE && sed -i -r -e "s/$PATTERN/\3\4 = 100/g" $FILE ||
echo default_process_limit = 100 >> $FILE 

PATTERN="^(\s)*(\#)*(\s)*(smtpd_client_connection_count_limit)(\s*\=\s*.*)"
grep -Eq $PATTERN $FILE && sed -i -r -e "s/$PATTERN/\3\4 = 10/g" $FILE ||
echo smtpd_client_connection_count_limit = 10 >> $FILE

PATTERN="^(\s)*(\#)*(\s)*(smtpd_client_connection_rate_limit)(\s*\=\s*.*)"
grep -Eq $PATTERN $FILE && sed -i -r -e "s/$PATTERN/\3\4 = 30/g" $FILE ||
echo smtpd_client_connection_rate_limit = 30 >> $FILE

PATTERN="^(\s)*(\#)*(\s)*(queue_minfree)(\s*\=\s*.*)"
grep -Eq $PATTERN $FILE && sed -i -r -e "s/$PATTERN/\3\4 = 20971520/g" $FILE ||
echo queue_minfree = 20971520 >> $FILE

PATTERN="^(\s)*(\#)*(\s)*(header_size_limit)(\s*\=\s*.*)"
grep -Eq $PATTERN $FILE && sed -i -r -e "s/$PATTERN/\3\4 = 51200/g" $FILE ||
echo header_size_limit = 51200 >> $FILE

PATTERN="^(\s)*(\#)*(\s)*(message_size_limit)(\s*\=\s*.*)"
grep -Eq $PATTERN $FILE && sed -i -r -e "s/$PATTERN/\3\4 = 10485760/g" $FILE ||
echo message_size_limit = 10485760 >> $FILE

PATTERN="^(\s)*(\#)*(\s)*(smtpd_recipient_limit)(\s*\=\s*.*)"
grep -Eq $PATTERN $FILE  && sed -i -r -e "s/$PATTERN/\3\4 = 100/g" $FILE ||
echo smtpd_recipient_limit = 100 >> $FILE
