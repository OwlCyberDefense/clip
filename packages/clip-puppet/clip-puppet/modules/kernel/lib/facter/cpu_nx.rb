# cpu_nx.rb
#
# Fact to return if the cpu has NoeXecute/eXecuteDisable bit

Facter.add("cpu_nx") do
	setcode do
		result = "false"
		system("/bin/grep -iq nx /proc/cpuinfo")
		if ($?.exitstatus == 0)
				result = "true"
		end
	end
end
