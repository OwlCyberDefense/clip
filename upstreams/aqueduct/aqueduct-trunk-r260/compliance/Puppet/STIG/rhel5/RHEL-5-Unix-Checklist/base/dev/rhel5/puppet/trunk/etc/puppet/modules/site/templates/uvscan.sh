#!/bin/sh
#set -x
###############################################################
# /usr/local/uvscan/antivirus_scan.sh
# Script to recursively scan /home and /usr/local on this host
###############################################################
DATE=`date '+%Y%m%d'`
DAY=`date '+%a'`
UVSCANDIR=/usr/local/uvscan
UVSCAN=$UVSCANDIR/uvscan
#EXCLUDE=$UVSCANDIR/avexclude
README=$UVSCANDIR/README
LOGDIR=/var/log/av
if [ ! -e "$LOGDIR" ];then
  mkdir $LOGDIR
fi
REPORT=$LOGDIR/antivirus_scan_report.$DATE
ERRORS=$LOGDIR/antivirus_scan_errors.$DATE
RECIPIENTS=root

CAT=/bin/cat
ECHO=/bin/echo
MAIL=/bin/mail
LN=/bin/ln
RM=/bin/rm

if [ $DAY = "Sun" ]; then
        DIRLIST="/ /var /opt /home"
else
        DIRLIST="/var /home"
fi

if [ -x "$UVSCAN" ]; then
        # Initialize report files
        if [ -e "$README" ];then
         $CAT $README > $REPORT
        fi
        $ECHO "/usr/local/uvscan/antivirus_scan.sh started at `date`" >> $REPORT
        $CAT /dev/null > $ERRORS

        for DIR in $DIRLIST
        do
                #du -sk $DIR >> $REPORT 2>>$ERRORS
                #$UVSCAN -d $UVSCANDIR --clean --exclude $EXCLUDE --mime --noboot --recursive --secure --summary --allole $DIR >> $REPORT 2>>$ERRORS
				$UVSCAN -d $UVSCANDIR --clean --mime --noboot --recursive --secure --summary --allole $DIR >> $REPORT 2>>$ERRORS
        done
        $ECHO "" >> $REPORT
        $ECHO "/usr/local/uvscan/antivirus_scan.sh completed at `date`" >> $REPORT
        $ECHO "" >> $REPORT
        $ECHO "The following files or directories were not scanned:" >> $REPORT
        $ECHO "" >> $REPORT
        #$CAT $EXCLUDE >> $REPORT

        # Antivirus report is now included in logwatch report
        # $CAT $REPORT $ERRORS | mail -s "Antivirus Report: `hostname`" $RECIPIENTS
else
        echo "ERROR:  uvscan not found" | mail -s "Antivirus Problem: `hostname`" $RECIPIENTS
fi

# Now to fix the links for logwatch report
for reportfile in antivirus_scan_report antivirus_scan_errors
do
if [ -e "$LOGDIR/$reportfile" ];then
        $RM $LOGDIR/$reportfile
fi
        $LN -s $LOGDIR/$reportfile.$DATE $LOGDIR/$reportfile
done

exit 0