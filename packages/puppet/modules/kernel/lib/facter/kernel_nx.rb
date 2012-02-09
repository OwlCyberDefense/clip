# kernel_nx.rb
#
# Fact to return if the booted kernel has NoeXecute/eXecuteDisable bit

Facter.add("kernel_nx") do
	setcode do
		result = "false"
		system("/bin/uname -r | /bin/egrep -iq 'PAE|x86_64'")
		if ($?.exitstatus == 0)
			result = "true"
		end
		result
	end
end
