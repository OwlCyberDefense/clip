# SC-5: Denial of Service Protection
# Kickstart Actions: None - PROCEDURAL REQUIREMENT

	# SC-5(1)
	# Kickstart Actions: None - PROCEDURAL REQUIREMENT

	# SC-5(2)
	# Kickstart Actions: None - PROCEDURAL REQUIREMENT
	class sc-5::p2 {
		# default path for following execs
		Exec { path => "/usr/bin:/usr/sbin:/bin:sbin" }

		## (GEN003600: CAT II) The SA will ensure network parameters are securely set.
		## (GEN005600: CAT II) The SA will ensure IP forwarding is disabled if the
		## system is not dedicated as a router.
		exec { "sed -i 's/^net.ipv4.conf.default.rp_filter.*/net.ipv4.conf.default.rp_filter = 1/g' /etc/sysctl.conf": }
		exec { "sed -i 's/^net.ipv4.conf.default.accept_source_route.*/net.ipv4.conf.default.accept_source_route = 0/g' /etc/sysctl.conf": }
		exec { "sed -i 's/^net.ipv4.ip_forward.*/net.ipv4.ip_forward = 0/g' /etc/sysctl.conf": }

		append_if_no_such_line { "net.ipv4.tcp_max_syn_backlog":
			name => "syn_backlog",
			file => "/etc/sysctl.conf",
			line => "net.ipv4.tcp_max_syn_backlog = 1280"
		}

		append_if_no_such_line { "net.ipv4.icmp_echo_ignore_broadcasts":
			name => "ignore_broadcasts",
			file => "/etc/sysctl.conf",
			line => "net.ipv4.icmp_echo_ignore_broadcasts = 1"
		}

		append_if_no_such_line { "net.ipv4.icmp_echo_ignore_all":
			name => "echo_ignore_all",
			file => "/etc/sysctl.conf",
			line => "net.ipv4.icmp_echo_ignore_all = 1"
		}
	}

	# SC-5(3)
	# Kickstart Actions: None - PROCEDURAL REQUIREMENT

