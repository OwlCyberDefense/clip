# from puppet documentation
# http://www.reductivelabs.com/trac/puppet/wiki/PracticalTypes

module Puppet
  newtype(:append_if_no_such_line) do
    @doc = "Ensure that the given line is defined in the file, and append
            the line to the end of the file if the line isn't already in
            the file."

    newparam(:name) do
      desc "The name of the resource"
    end

    newparam(:file) do
      desc "The file to examine (and possibly modify) for the line."
    end

    newparam(:line) do
      desc "The line we're interested in."
    end

    newproperty(:ensure) do
      desc "Whether the resource is in sync or not."

      defaultto :insync

      def retrieve
        File.readlines(resource[:file]).map { |l|
            l.chomp
        }.include?(resource[:line]) ? :insync : :outofsync
      end

      newvalue :outofsync
      newvalue :insync do
        File.open(resource[:file], 'a') { |fd| fd.puts resource[:line] }
      end
    end
  end
end
