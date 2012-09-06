#!/bin/sh

# slim-svn-disk-check.sh: monitors disc space while the script that ran it
# is running.  helpful for any automated download activity so you don't run
# out of disc space.
#
# usage: in the download script, run the download command and put it in the
# background "&" as the next command /bin/bash disk-check.sh $$ using $$ to
# grab the pid of the script launching disk-check.sh
#

# the pid of the launching program becomes the first input of disk-check.sh
# $1 in this case SVN is the download.
SVNPID="$1"
# the original pid of the initiator script gets incremented when is goes in
# the background so we do also.
let "SVNPID = $SVNPID + 1"
# ps -p is looking at the initiator script pid and grabbing only the exit code
# throwing away the rest of the info 2>&1.  so when it changes from 0 successful
# to 1 unsuccessful we kill the while loop watching disc space.
#
# need to set DISCFILLER so that the while loop has something to start with
DISCFILLER=`ps -p $SVNPID 2>&1 > /dev/null; echo $?`

while [ "$DISCFILLER" == "0" ];do
  # the grep, awk below just brings back disc space from . current
  # directory. change to fit your needs.
  SPACE=`df . | grep -vE 'Filesystem|mapper' | awk '{ print $3 }'`
    if [[ "$SPACE" -le "102400"  ]];then
      echo "Less than 100M left: $SPACEK killing slim-svn-export.sh $SVNPID"
      kill "$SVNPID"
    fi
  # keep checking so see if the initiator download script pid exists
  DISCFILLER=`ps -p $SVNPID 2>&1 > /dev/null; echo $?`
done
exit 0