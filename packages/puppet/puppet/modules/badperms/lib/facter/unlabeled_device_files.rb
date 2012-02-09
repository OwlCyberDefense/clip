#Return the count of the unlabled device files

Facter.add("unlabeled_dev_count") do
	setcode do
		%x{find /dev -context "*unlabeled_t*" | wc -l}
	end
end
