# Note: this is not the typical puppet site.pp, as it has no nodes.  It
# is meant to be ran interactively using the puppet command.  To use it
# with a puppetmaster, nodes will need to be added.

# default path for exec resources:
Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin" }

# SITE: Site or geographic location specific; aliases for root mail, sendmail relay, admin account, subversion config, RPM build env, ntp, /etc/resolv
import "site"
include site::remove
include site::template
include site::services
include site::admin
include site::run


# SW: ensure some packages are installed
# import "SW"
# include sw

# SERVICE: ensure services are running
# import "SERVICE"
# include service

# RUN: run commands
# import "RUN"
# include run

# GROUP: create groups plus set pwconv
# import "GROUP"
# include group

# MOD: modifying files
# import "MOD"
# include mod

# FILES: copying files.  this was the quick and dirty way.
# need to modify files or be smarter about this.
# import "FILES"
# include files

# Adding a timeout and "default" passwd hash in grub.conf
# import "LNX00140"
# include lnx00140

