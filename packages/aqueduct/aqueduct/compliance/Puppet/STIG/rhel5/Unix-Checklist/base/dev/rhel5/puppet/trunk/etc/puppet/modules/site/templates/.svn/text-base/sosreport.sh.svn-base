# !/bin/bash

# This file is auto generated with puppet.  Anything modfified will be lost at the next run.
OldSoS="ls /tmp | grep sosreport"
HostName=`hostname`

if [ ! "$OldSoS" == "" ]; then
 # do something with it first if you want it.  I usually use whatever other
 # process to save before I delete, like the build process or generating
 # a web page.
 rm -rf /tmp/sosreport* /tmp/sos_*  /tmp/$HostName*
fi

echo "/n
" | sosreport --no-progressbar 2>&1>/dev/null | grep -v '(version 1.7)'

# optional if you need a lesser user than root to manipulate.
# chmod 755 /tmp/sosreport*
# mv /tmp/sosreport* /root/
