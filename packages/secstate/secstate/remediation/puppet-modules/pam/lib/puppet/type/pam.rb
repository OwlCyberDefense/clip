# Copyright (C) 2010 Tresys Technology, LLC
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Lesser General Public
#  License as published by the Free Software Foundation; either
#  version 2.1 of the License, or (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public
#  License along with this library; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#
#  File: pam.rb
#  This file is the implementation of the pam type

require 'puppet/property/list'

Puppet::Type.newtype(:pam) do
    @doc = "Manage the contents of /etc/pam.d/system-auth"
 
 
    ensurable
 
    newproperty(:target) do
        desc "Location of the shells file"
 
        defaultto {
            if
                @resource.class.defaultprovider.ancestors.include?(Puppet::Provider::ParsedFile)
                @resource.class.defaultprovider.default_target
            else
                nil
            end
        }
    end

    newproperty(:control) do
       desc "Behavior in case of authentication failure"
    end


    newparam(:module_path) do
        desc "The full filename of the PAM module to be used"
        isnamevar
    end

    newproperty(:module_args, :parent => Puppet::Property::List) do
       desc "Arguments to pass to the PAM module being used.  Multiple arguments should be specified as an array."

        def delimiter
            " "
        end

        def membership
            :args_membership
        end

        def exclusive?
            @resource[membership] == :exclusive
        end

        # Handling for exclusive setting in module arguments list
        # Mirrors 'add_should_to_current()' in 'Puppet::Property::List'
        def sub_should_from_current(should, current)
            puts "sub should from current: #{should} | #{current}"
            if current.is_a?(Array)
                current -= should
            end
            current.uniq
        end

        def add_should_with_current(should, current)
            if current.is_a?(Array)
                current_keys = current.collect {|x| x.split('=', 2)[0]}
                should_keys = should.collect {|x| x.split('=', 2)[0]}
                should_keys.each_index do |i|
                    if (j = current_keys.index(should_keys[i])) != nil
                        current[j] = should[i]
                    elsif should[i] != ''
                        current.push(should[i])
                    end
                end
            end
            current
        end

        def dearrayify(array)
            array.join(delimiter)
        end

        # Overrides the one from 'Puppet::Property::List' to add 'exclusive'
        # handling.  I have no clue where the variable 'retrieve' gets set.
        def should
#            puts "custom SHOULD function"
            unless defined? @should and @should
                return nil
            end

            members = @should
            # Inclusive means we are managing everything so if it isn't in
            # 'should', it is removed.
            if ! inclusive?
                # Exclusive means if it's in should it gets removed from current
                if exclusive?
                    members = sub_should_from_current(members, retrieve)
                else
                    members = add_should_with_current(members, retrieve)
                end
            end
            dearrayify(members)
        end

        validate do |value|
            if value.include?(",")
                raise ArgumentError, "Module arguments must be provided as an array, not a comma-separated list"
            end
        end
    end

      newparam(:args_membership) do
          desc "Whether specified module arguments should be treated as the
              only module arguments which should be present or whether they
              should merely be treated as the minimum arguments list."

          newvalues(:inclusive, :minimum, :exclusive)

          defaultto :minimum
        end


end
