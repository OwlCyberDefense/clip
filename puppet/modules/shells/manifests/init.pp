# Module: shells
#
# Class: shells
#
# Description:
#       This class configures the shells daemon on a system
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
class shells {
		file {
			"/bin/sh":
                        	mode => 755,
                        	owner => "root";
                
			"/bin/bash":
                       		mode => 755,
                        	owner => "root";
                
			"/sbin/nologin":
                       		mode => 755,
                        	owner => "root";
                
			"/bin/tcsh":
                        	mode => 755,
                        	owner => "root";
                
			"/bin/csh":
                        	mode => 755,
                        	owner => "root";
                
			"/bin/ksh":
                        	mode => 755,
                        	owner => "root";
		}

		augeas {
			context	=>	"/etc/shells";
			lens	=>	shells.lns;
		}
}

	
