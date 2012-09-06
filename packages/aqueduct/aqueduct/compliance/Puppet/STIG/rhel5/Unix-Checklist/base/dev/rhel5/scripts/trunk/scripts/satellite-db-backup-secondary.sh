#!/bin/bash

# restore command
# su -c "db-control restore /var/satellite/oracle-backup" oracle

SATBACK="/var/satellite/oracle-backup"
SATRESTORE="satellite-db-restore-secondary.sh"
SATLOG="/var/log/oracle_backup.log"
STOP="rhn-satellite stop"
START="rhn-satellite start"
STATUS="rhn-satellite status"
RESTART="rhn-satellite restart"
SERVER="localhost"
HOME="/home/sysutil/scripts"

echo "Start $SATBACK $0 `date`" >> $SATLOG

$STATUS 2>&1 >/dev/null
if [ $? == 0 ]; then
        $STOP 2>&1 >/dev/null
        if [ $? == 0 ]; then
                # $STOP 2>&1 >/dev/null | tee -a  $SATLOG
                /bin/ps aux | grep -i oracle 2>&1 >/dev/null | tee -a $SATLOG
                if [ $? != 0 ]; then
                 echo "Oracle is not successfully stopping...Backups not being performed" | tee -a $SATLOG
                 echo "Attempting rhn-sattelite restart"
                 # $RESTART
                 exit 1
                fi

                su -c "db-control backup $SATBACK" oracle | tee -a $SATLOG &> /dev/null
                if [ $? != 0 ]; then
                 echo "Oracle is not successfully doing a DB dump" | tee -a $SATLOG
                 echo "Attempting rhn-sattelite restart" | tee -a $SATLOG
                 # $RESTART
                 exit 1
                fi

                #$RESTART 2>&1 >/dev/null | tee -a $SATLOG
                $RESTART 2>&1 >/dev/null
                if [ $? != 1 ]; then
                /usr/bin/curl -k https://$SERVER/rhn/YourRhn.do &> /dev/null
                else
                exit 1
                fi
                if [ $? != 0 ]; then
                 echo "rhn-satellite start failed to start oracle" | tee -a $SATLOG
                 echo "Attempting rhn-satellite restart" | tee -a $SATLOG
                 # $RESTART
                 exit 1
                fi

                su -c "db-control verify $SATBACK" oracle | tee -a $SATLOG &> /dev/null
                if [ $? != 0 ]; then
                 echo "Oracle Backup is Bad, will not verify" | tee -a $SATLOG
                 exit 1
                fi
                echo "End $SATBACK $0 `date`" >> $SATLOG
        fi
fi

$HOME/$SATRESTORE
exit 0