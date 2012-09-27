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
  USER="ORG_USER_${org}"
  FIRST="ORG_FIRST_${org}"
  LAST="ORG_LAST_${org}"
  EMAIL="ORG_EMAIL_${org}"
  PASSWD="ORG_PASSWD_${org}"
    if [[ `spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
        -- org_list | grep "$org"` == "" ]];then
        spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
        -- org_create -n ${org} -u "${!USER}" -f "${!FIRST}" -l "${!LAST}" \
        -e "${!EMAIL}" -p "${!PASSWD}"
        spacecmd --user="$SATUSER" --password="$SATPASSWORD" --quiet \
        -- org_addtrust "${DEFAULT_ORGANIZATION}" ${org}
    fi

done
exit 0
