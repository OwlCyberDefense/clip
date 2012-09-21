#!/bin/bash

# slim-svn-export.sh will source the slim.cfg file to understand what
# it needs to work on.
#
# then is does an svn export and monitors disc space through a second
# script that is generated below.
#
# Example of structure:
# ~sysutil/svn.forge.mil/slim/base/dev/rhel4/rpm/trunk/channels/i386/utils
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

if [ ! -d /home/$USER ];then
  error_exit "Line $LINENO: Could not find /home/$USER"
fi

  for rel in ${RELEASEPHASE};do
    for os in ${OPERATINGSYSTEM};do
      for arch in ${ARCHITECTURE};do
	        # if the dirctory structure does not exist we are assuming that a checkout (initial getting
			# of repo) has not been done...
            if [ ! -d "$HOMEDIR/$rel/$os/$TRUNKCHANNELS/$arch" ];then
			  # ... then we do a check check to see if the svn repo structure exists...
              svn --non-interactive list $SVNSERVER/$rel/$os/$TRUNKCHANNELS/$arch
			        # ... if the exit value of the last command is successful, 0 it means
					# it exists in the svn repo.
                    if [ $? == "0" ];then
		      # now being that this is a nested for loop we will iterate through all combinations of
			  # dev, tst, prod & rhel4, rhel5, rhel6 & ia32, x86_64, etc or whatever is configured in the
			  # file being sourced at the top of this file (slim.cfg)
			  # ... and do a svn checkout.
              svn --quiet --non-interactive co $SVNSERVER/$rel/$os/$TRUNKCHANNELS/$arch $HOMEDIR/$rel/$os/$TRUNKCHANNELS/$arch \
                  || error_exit "Line $LINENO: Could not run $SVNSERVER/$rel/$os/$TRUNKCHANNELS/$arch $HOMEDIR/$rel/$os/$TRUNKCHANNELS/$arch"
                        fi
                fi
      done
    done
  done

  for rel in ${RELEASEPHASE};do
    for os in ${OPERATINGSYSTEM};do
      for arch in ${ARCHITECTURE};do
	        # this is the same as above but is checking to see if the local directory structure does exist
			# and then assumes that a checkout has been done before and now only does an "svn update"
            if [ -d "$HOMEDIR/$rel/$os/$TRUNKCHANNELS/$arch" ];then
              svn --non-interactive list $SVNSERVER/$rel/$os/$TRUNKCHANNELS/$arch
                    if [ $? == "0" ];then
              svn --quiet --non-interactive update $SVNSERVER/$rel/$os/$TRUNKCHANNELS/$arch $HOMEDIR/$rel/$os/$TRUNKCHANNELS/$arch \
                  || error_exit "Line $LINENO: Could not run $SVNSERVER/$rel/$os/$TRUNKCHANNELS/$arch $HOMEDIR/$rel/$os/$TRUNKCHANNELS/$arch"
                    fi
                fi
          done
    done
  done
  exit 0