# Note: this is not the typical puppet site.pp, as it has no nodes.  It
# is meant to be ran interactively using the puppet command.  To use it
# with a puppetmaster, nodes will need to be added.

# default path for exec resources:
Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin" }

###SINGLE PUPPET MODULE TO TEST ISO###
import "auditd"
include "auditd"
