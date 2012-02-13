# Module: pam
#
# Class: pam
#
# Description:
#       This class configures pam on a system
#
# Defines:
#       None
#
# Variables:
#       None
#
# Facts:
#       None
#
class pam {	
	augeas {
		 "pam":
			context => "/etc/pam.d/system-auth.tpl",
			lens    => "pam.lns";
	}
}
