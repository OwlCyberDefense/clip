#!/bin/bash -x

# slim-sat-channel-create.sh will source the slim.cfg file to understand what
# what it needs to work on.
#
# then it will iterate through Release/OS/Arch array to export from
# svn server and then check for the existence of a channel, create
# it if it does not exist and populate it with rpm's

# ~sysutil/svn.forge.mil/slim/base/dev/rhel4/rpm/trunk/channels/i386/utils

# I put a variable in my scripts named PROGNAME which
# holds the name of the program being run.  You can get
# thisÃÂ£value from the first item on the command line ($0).
PROGNAME=$(basename $0)
function error_exit
{

#       ----------------------------------------------------------------
#       Function for exit due to fatal program error
#               Accepts 1 argument:
#                       string containing descriptive error message
#       ----------------------------------------------------------------


        echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
        exit 1
}

# Example call of the error_exit function.  Note the inclusion
# of the LINENO environment variable.  It contains the current
# line number.

source slim.cfg || error_exit "Line $LINENO: Could not source slim.cfg"

# trouble shooting...
# echo user "$SATUSER"
# echo pass "$SATPASSWORD"
#
# these nested for loops put release; dev, tst, prod with OS version; rhel4, rhel5 with \
# architecture; x86_64, i386 (converted to ia-32) with the name of the channel (based on \
# directory name in the svn directory structure.  the example here is "utils"
for rel in ${RELEASEPHASE};do
  for os in ${OPERATINGSYSTEM};do
    for arch in ${ARCHITECTURE};do
      for channel in ${SOFTWARECHANNELS};do
      # ~sysutil/svn.forge.mil/slim/base/dev/rhel4/rpm/trunk/channels/i386
      #
      # all vars are in the slim.cfg
      # $HOMEDIR did have ~username but that did not work so changed to /home
      # if the homedir is not in /home then it will break
      # var example in slim.cfg;
      #  BASEDIR="svn.forge.mil/slim/base"
      #  HOMEDIR="/home/$USER/$BASEDIR"
      #  TRUNKCHANNELS="rpm/trunk/channels"
      # echo "$HOMEDIR/${rel}/${os}/$TRUNKCHANNELS/${arch}"
      if [ -d $HOMEDIR/${rel}/${os}/$TRUNKCHANNELS/${arch}/${channel} ];then
        #DOCHANNELSEXIST="${rel}-${arch}-${channel}"
        DOCHANNELSEXIST="${channel}-${rel}-${arch}-${os}"
        # echo DOCHANNELSEXIST $DOCHANNELSEXIST
          # sense stupid satellite uses ia32 as architecture but names the base channel
          # rhel-i386-server-5 it breaks.  be consistent!
          if [ "$arch" == "ia32" ];then
            archi386="i386"
             else
              archi386="$arch"
          fi
          # switches i386 with ia32 if it exists
        # this is going to return the channel name if it exists, if not we create it.
        if [[ `spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
          -- softwarechannel_list | grep $DOCHANNELSEXIST` == "" ]];then
          # what ever channels that do not exist will be created with a naming convention \
          # of dev-ia32-utils based on the directory structure in svn
          # have to do this i386 conversion to ia32 because RPM build does it i386 \
          # and Satelite does it ia-32
          # DOCHANNELSEXIST is based on the "does this path exist above", which is
          # is looking at where 'channels' should be under 'rpm' then what is lef is
          # is what needs to be created because it did not come back as an existing
          # channel with the 'spacecmd softwarechannel_list' command above.
          # then we have to change i386 to ia32 (wish they would pick one)
          # switches i386 with ia32 if it exists
          spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
          -- softwarechannel_create  -n $DOCHANNELSEXIST -l $DOCHANNELSEXIST \
          -a $arch -p $rel-rhel-`echo $arch`-server-`echo $os | awk '$0=$NF' FS=` 2>&1 > /dev/null
          #
          spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
          -- softwarechannel_list | grep $DOCHANNELSEXIST 2>&1 > /dev/null || error_exit \
          "Line $LINENO: Could not create $CHANNELSTOCREATE channels with spacecmd softwarechannel_create."
        fi
      fi
      done
    done
  done
done
exit 0