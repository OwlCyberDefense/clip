# Module: acl
#
# Class: acl
#
# Description:
#	Enable acls on filesystems
#
# Defines:
#	None
#
# Variables:
#	None
#
# Facts:
#	None
#
# Files:
#	None
#
# LinuxGuide:
#	2.3.7.1
#	2.3.7.2
#	3.6.2.1
#
# CCERef#:
#
# NIST 800-53:
#	AC-3
#
# DCID 6/3:
#	4.B.4.a(2)
#

define set_fs_opt ($fs, $opt) {
        augeas { $title:
                context => "/files/etc/fstab",
                changes => ["ins opt after *[file='$fs']/opt[last()]",
                            "set *[file='$fs']/opt[last()] $opt"],
		onlyif  => "match *[file='$fs' and count(opt[.='$opt'])=0] size > 0", 
        }

class acl {
        set_fs_opt { "home_fs_acl": fs=>'/home', opt=>'acl' }
        set_fs_opt { "root_fs_acl": fs=>'/',     opt=>'acl' }
        set_fs_opt { "var_fs_acl":  fs=>'/var',  opt=>'acl' }
        set_fs_opt { "tmp_fs_acl":  fs=>'/tmp',  opt=>'acl' }
        }
}
