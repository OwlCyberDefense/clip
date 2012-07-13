#!/bin/bash -x

# restore command
# su -c "db-control restore /var/satellite/oracle-backup" oracle

SATBACK="/var/satellite/oracle-backup"
SATRESTORE="/var/satellite/restore"
SATLOG="/var/log/oracle_backup.log"
STOP="rhn-satellite stop"
START="rhn-satellite start"
STATUS="rhn-satellite status"
RESTART="rhn-satellite restart"
SERVER="localhost"
SECONDARY="nces-sb-vm-01"
HOME="/home/sysutil/scripts"
DBBACKUPSCRIPT="satellite-db-backup-secondary.sh"

echo "Start $SATBACK $0 `date`" >> $SATLOG

#rsync -av $SATBACK/ $SECONDARY:$SATRESTORE/

#if [ $? != "0" ];then
# echo "Satellite Primary DB to Secondary rsync failed!"
#fi

rsync -a /var/satellite/ $SECONDARY:/var/satellite/

if [ $? != "0" ];then
 echo "Satellite Primary '/var/satellite' to Secondary rsync failed!"
fi

ssh $SECONDARY $HOME/$DBBACKUPSCRIPT
exit 0