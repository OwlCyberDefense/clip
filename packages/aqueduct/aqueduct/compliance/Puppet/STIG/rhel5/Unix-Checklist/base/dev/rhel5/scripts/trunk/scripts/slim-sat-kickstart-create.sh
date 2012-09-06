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
# thisÂ£value from the first item on the command line ($0).
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
      for kickstart in `ls $HOMEDIR/${rel}/${os}/$TRUNKKICKSTART/${arch}/`;do
        if [ -d $HOMEDIR/${rel}/${os}/$TRUNKKICKSTART/${arch}/ ];then
          KICKSTARTNAME="${rel}-${os}-${arch}-${kickstart}"
          # This is setting up the expansion of a variable in the source config.cfg file above.  ${!KEY} below.
          KEY="KEY_${rel}${arch}${os}"
            if [[ `ls $HOMEDIR/${rel}/${os}/$TRUNKKICKSTART/${arch}/${kickstart}` != "" ]];then
              spacecmd -y --username="$SATUSER" --password="$SATPASSWORD" -- kickstart_delete "$KICKSTARTNAME"
              spacecmd --username="$SATUSER" --password="$SATPASSWORD" -- kickstart_import -n "$KICKSTARTNAME" \
                       -f "$HOMEDIR/${rel}/${os}/$TRUNKKICKSTART/${arch}/$kickstart" -d ks-rhel-$arch-server-5 \
                       -p 'Password' -v 'none'  || error_exit "Line $LINENO: Could not create Kickstart \
                       ${rel}-${arch}-$TRUNKKICKSTART"
              spacecmd --username="$SATUSER" --password="$SATPASSWORD" -- kickstart_addactivationkeys \
                       "$KICKSTARTNAME" "${!KEY}"
			  # this is very good stuff.  allows flexibility that will keep these cripts very simple
                       # !KEY is telling it to go back to the variable reference in "source slim.cfg" KEY_devx86_64rhel5
            fi
        fi
      done
    done
  done
done
exit 0