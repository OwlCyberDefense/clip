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
                        	owner	=> "root",
				mode	=> '0755';
                                        
			"/bin/bash":
                       		owner	=> "root",
				mode	=> '0755';                        	
             		"/sbin/nologin":
				owner	=> "root",  
                     		mode	=> '0755';
                  
			"/bin/tcsh":
				owner	=> "root",
                        	mode	=> '0755';
                
			"/bin/csh":
				owner	=> "root",
                        	mode 	=> '0755';
               
			"/bin/ksh":
                        	owner	=> "root",
				mode 	=> '0755';
		}

		augeas {
			"Map shells to augeas tree":
				context	=> "/etc/shells",
				lens	=> "shells.lns";
		}
}

	
