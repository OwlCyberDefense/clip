#!/bin/bash

# restore command
# su -c "db-control restore /var/satellite/oracle-backup" oracle

SATRESTORE="/var/satellite/restore"
SATBACK="/var/satellite/oracle-backup"
SATLOG="/var/log/oracle_backup.log"
STOP="rhn-satellite stop"
START="rhn-satellite start"
STATUS="rhn-satellite status"
RESTART="rhn-satellite restart"
SERVER="localhost"

echo "Start $SATRESTORE $0 `date`" >> $SATLOG

su -c "db-control verify $SATRESTORE" oracle

if [ $? != "0" ];then
  echo "DB VERIFY failed on Secondary Satellite during fail over operation from Primary"
  echo "Your primary and secondary Satellite servers are NOT in sync!"
  exit 1
fi

$STOP

if [ $? != "0" ];then
  echo "Satellite STOP failed on Secondary Satellite during fail over operation from Primary"
  echo "Your primary and secondary Satellite servers are NOT in sync!"
  exit 1
fi

su -c "db-control restore $SATRESTORE" oracle

if [ $? != "0" ];then
  echo "DB RESTORE failed on Secondary Satellite during fail over operation from Primary"
  echo "Your primary and secondary Satellite servers are NOT in sync!"
  exit 1
fi

$START

if [ $? != "0" ];then
  echo "Satellite START failed on Secondary Satellite during fail over operation from Primary"
  echo "Your secondary Satellite servers is probably NOT operational!"
  exit 1
fi

echo "End $SATRESTORE $0 `date`" >> $SATLOG
exit 0