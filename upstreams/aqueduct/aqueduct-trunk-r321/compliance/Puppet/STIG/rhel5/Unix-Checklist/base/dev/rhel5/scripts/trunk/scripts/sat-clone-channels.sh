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
  for clone in ${CLONECHANNELSRELEASE};do
    if [[ `spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
    -- softwarechannel_list | grep "$rel-$clone"` == "" ]];then
    spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
    -- softwarechannel_clone -s ${clone} -n ${rel}-${clone} -l ${rel}-${clone}
    # this is cloning channels and the majority of the verbage is to pull the number "5", "6",
    # etc out of the distro name to put it on the end of $rel--rhn-tools-rhel-"5" (no quotes)
    spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
    -- softwarechannel_clone -s rhn-tools-rhel-`echo $clone | cut -d"-" -f2`-server-`echo $clone \
    | cut -d"-" -f4` -n ${rel}-rhn-tools-rhel-`echo $clone | cut -d"-" -f2`-server-`echo $clone \
    | cut -d"-" -f4` -l ${rel}-rhn-tools-rhel-`echo $clone | cut -d"-" -f2`-server-`echo $clone \
    | cut -d"-" -f4` -p ${rel}-${clone}
    fi
  done
done
exit 0