# ifdefined -- if a variable is defined, use it, otherwise use undef
#
# which means, for instance, "if this variable is defined, set the mode to it,
# otherwise do nothing"
#
# allows:
#  $x = ifdefined('foo')
#
# Michael DeHaan <michael@puppetlabs.com>

module Puppet::Parser::Functions
    newfunction(:ifdefined, :type => :rvalue) do |args|
        key = args[0]
        value = lookupvar(key)
        if value == ''
           value = :undef # not nil
        end
        value
    end
end

