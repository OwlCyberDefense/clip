#!/bin/bash -x

ORACLE="oracle"
HOST=`hostname`
SATBACK="/var/satellite/$ORACLE-backup"
SATLOG="/var/log/oracle_backup.log"
echo "Start $SATBACK $0 `date`" >> $SATLOG

/bin/ps aux | grep -i $ORACLE 2>&1 >/dev/null
if [ $? -ne 1 ]; then
  /usr/sbin/rhn-satellite stop 2>&1 >/dev/null | tee -a  $SATLOG
fi

/bin/ps aux | grep -i $ORACLE 2>&1 >/dev/null | tee -a $SATLOG
if [ $? -ne 0 ]; then
 echo "Oracle is not successfully stopping...Backups not being performed" | tee -a $SATLOG
 echo "Attempting /etc/init.d/rhn-sattelite restart"
 /usr/sbin/rhn-satellite restart
 exit 1
fi

if [ ! -d $SATBACK ];then
  mkdir $SATBACK && chown $ORACLE $SATBACK || exit 1
fi

su -c "db-control backup $SATBACK" $ORACLE | tee -a $SATLOG &> /dev/null
if [ ! $? == 0 ]; then
 echo "Oracle is not successfully doing a DB dump" | tee -a $SATLOG
 echo "Attempting /etc/init.d/rhn-sattelite restart" | tee -a $SATLOG
 /usr/sbin/rhn-satellite restart
 exit 1
fi

/usr/sbin/rhn-satellite start 2>&1 >/dev/null | tee -a $SATLOG
/usr/bin/curl -k https://$HOST/rhn/YourRhn.do &> /dev/null
if [ $? != 0 ]; then
 echo "/usr/sbin/rhn-satellite start failed to start $ORACLE" | tee -a $SATLOG
 echo "Attempting /usr/sbin/rhn-satellite restart" | tee -a $SATLOG
 /usr/sbin/rhn-satellite restart
 exit 1
fi

su -c "db-control verify $SATBACK" $ORACLE | tee -a $SATLOG &> /dev/null
if [ $? != 0 ]; then
 echo "Oracle Backup is Bad, will not verify" | tee -a $SATLOG
 exit 1
fi
echo "End $SATBACK $0 `date`" >> $SATLOG
exit 0