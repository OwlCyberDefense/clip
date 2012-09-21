#!/bin/bash -x


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

# these nested for loops put release; dev, tst, prod with OS version; rhel4, rhel5 with \
# architecture; x86_64, i386 (converted to ia-32) with the name of the channel (based on \
# directory name in the svn directory structure.  the example here is "utils"
for org in ${ORGANIZATIONS};do
    if [[ `spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
        -- org_list | grep "$org"` == `spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
        -- org_list | grep "$org"` ]];then
        spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
        -- org_setsystementitlements ${org} enterprise_entitled 5
        spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
        -- org_setsystementitlements ${org} provisioning_entitled 5
        spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
        -- org_setsoftwareentitlements ${org} rhel-server 5
        spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
        -- org_setsoftwareentitlements ${org} rhel-server-6 5
        spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
        -- org_setsoftwareentitlements ${org} rhn-tools 5
        spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
        -- org_setsoftwareentitlements ${org} rhn-tools-rhel-server-6 5
    fi

done
exit 0