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
#  This file is the implementation of the pam provider

require 'puppet/provider/parsedfile'
targ = "/etc/pam.d/system-auth"

def handle_pam_record(line)
#     puts "RECORD_HANDLER | Line: #{line}"

     match = /(\S+)\s+(\S+)\s+(\S+)\s*(.*)/.match(line)
     pam_record = {}
     pam_record[:type] = match[1]
     pam_record[:control] = match[2]
     pam_record[:library] = match[3]
     pam_record[:name] = "#{match[1]}:#{match[3]}"
     unless pam_record[:module_args] = parse_args(match[4])
         pam_record[:module_args] = ""
     end
#     puts "TYPE: #{pam_record[:type]} | CONTROL: #{pam_record[:control]} | LIBRARY #{pam_record[:library]} | MODULE_ARGS: #{pam_record[:module_args]}"
     pam_record
end

def parse_args(args_str)
    return nil unless args_str
    args_arr = args_str.split(' ')
    def args_arr.to_s 
        self.join(" ")
    end
    args_arr
end
                                                                         
Puppet::Type.type(:pam).provide(:parsed, :parent => Puppet::Provider::ParsedFile, :default_target => targ, :filetype => :flat, :process => "handle_pam_record") do
 
    attr_accessor :other_target

    desc "The provider to handle PAM records"
 
    text_line :comment, :match => /^\s*#/;
    text_line :blank, :match => /^\s*$/;
 
#    rec = record_line :parsed, {:fields => %w{type control module_path}, :optional => %w{module_args}} do |line|
    rec = record_line :parsed, {:fields => %w{type control library module_args}} do |line|
        handle_pam_record(line)
    end 

# This was to be handling for managing every file in pam.d
#    def self.initvars
#        super
#        puts "custom initvars GO"
#        files = ["/home/fslavin/PUPPET/test1", "home/fslavin/PUPPET/test2"]
#        other_target = "/home/fslavin/PUPPET/test1"
#        target_obj = target_object(other_target)
#        puts "target_object in initvars: #{target_obj}"
#        files.each do |path|
#            target_object(path)
#        end
#    end

    def module_args
        module_args = []
        if module_args = @property_hash[:module_args]
            module_args.join(" ")
        else
            module_args
        end
    end

    self.initvars

end
