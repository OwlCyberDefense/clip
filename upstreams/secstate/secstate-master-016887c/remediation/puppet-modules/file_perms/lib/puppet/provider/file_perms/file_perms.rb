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
#  File: file_perms.rb
#  This file is the implementation of the file_perms provider

require 'puppet'
require 'fileutils'
require 'find'

Puppet::Type.type(:file_perms).provide :file_perms, :parent => Puppet::Provider do
   desc 'Allows setting of unix dac mode bits.  Bits not specified are untouched'

   @@mode_bits_hash = { :suid   => 2048,
                        :sgid   => 1024,
                        :sticky => 512,
                        :uread  => 256,
                        :uwrite => 128,
                        :uexec  => 64,
                        :gread  => 32,
                        :gwrite => 16,
                        :gexec  => 8,
                        :oread  => 4,
                        :owrite => 2,
                        :oexec  => 1 }

   def initialize(args)
      super
      param_parse
      prefetch
   end

   def param_parse
      originals = @resource.original_parameters
      if originals[:recurse] != nil
         @resource[:recurse] = convert_symbol(originals[:recurse])
      else
         @resource[:recurse] = false
      end
      
      if originals[:change_files] != nil
         @resource[:change_files] = convert_symbol(originals[:change_files])
      else
         @resource[:change_files] = true
      end
      
      if originals[:change_dirs] != nil
         @resource[:change_dirs] = convert_symbol(originals[:change_dirs])
      else
         @resource[:change_dirs] = false
      end
   end


   def prefetch
      unless @resource
         raise Puppet::DevError, "Somehow got told to prefetch with no resource set"
      end
 
      if not File.exists?(@resource[:name])
         raise ArgumentError,
            "Error: No such file or directory : #{@resource[:name]}"
      end

      if convert_symbol(@resource[:recurse])
         #when the recurse option is set mode_bits is a hash from filenames (or directory names) to a hash of its permission bits
         @permissions = Hash.new
         
         #recurses over the directory
         Find.find(@resource[:name]) do |fname|
            next if (File.file?(fname) and (convert_symbol(@resource[:change_files]) == false))
            next if (File.directory?(fname) and (convert_symbol(@resource[:change_dirs]) == false))

            mode = File.stat(fname).mode
            @permissions[fname] = mode_to_hash(mode)
            @permissions[fname][:owner] = File.stat(@resource[:name]).uid
            @permissions[fname][:group] = File.stat(@resource[:name]).gid
         end
         
         if @permissions.size == 0
            raise RuntimeError,
               "Error: There are no files or directories to be processed."
         end
      else
         mode = File.stat(@resource[:name]).mode
         @permissions = mode_to_hash(mode)
         @permissions[:owner] = File.stat(@resource[:name]).uid
         @permissions[:group] = File.stat(@resource[:name]).gid
      end
   end
  
 
   def flush
      if convert_symbol(@resource[:recurse])
         @permissions.each do |fname, value|
            new_mode = hash_to_mode(value)
            File.chmod(new_mode, fname)
            File.chown(value[:owner], value[:group], fname)
         end
      else
         new_mode = hash_to_mode(@permissions)      
         File.chmod(new_mode, @resource[:name])
         File.chown(@permissions[:owner], @permissions[:group], @resource[:name])
      end
   end
     
   def all_or_nil(hash, hash2_key)
      aon = nil
      hash.each do |key, value|
         if aon == nil
            aon = value[hash2_key]
         elsif aon != value[hash2_key]
            return nil
         end
      end
      
      return aon
   end
   
   def set_all_hash_vals(hash, hash2_key, hash2_val)
      hash.each do |key, value|
         value[hash2_key] = hash2_val
      end
   end
   
   def get_val(symbol)
      if @resource[:recurse] == :true
         value = all_or_nil(@permissions, symbol)
      else
         value = @permissions[symbol]
      end
      return truth_to_symbol(value)
   end
   
   def set_val(symbol, value)
      value = convert_symbol(value)
      
      if convert_symbol(@resource[:recurse])
         set_all_hash_vals(@permissions, symbol, value)
      else
         @permissions[symbol] = value
      end
   end
   
   def suid
      get_val(:suid)
   end
   
   def sgid
      get_val(:sgid)   
   end
   
   def sticky
      get_val(:sticky)
   end
   
   def uread
      get_val(:uread)
   end
   
   def uwrite
      get_val(:uwrite)
   end
   
   def uexec
      get_val(:uexec)
   end
   
   def gread
      get_val(:gread)
   end
   
   def gwrite
      get_val(:gwrite)
   end
   
   def gexec
      get_val(:gexec)
   end
   
   def oread
      get_val(:oread)
   end
   
   def owrite
      get_val(:owrite)
   end
   
   def oexec
      get_val(:oexec)
   end
   
   def owner
      get_val(:owner)
   end
   
   def group
      get_val(:group)
   end

   def suid=(value)
      set_val(:suid, value)   
   end
   
   def sgid=(value)
      set_val(:sgid, value)   
   end
   
   def sticky=(value)
      set_val(:sticky, value)
   end
   
   def uread=(value)
      set_val(:uread, value)
   end
   
   def uwrite=(value)
      set_val(:uwrite, value)
   end
   
   def uexec=(value)
      set_val(:uexec, value)
   end
   
   def gread=(value)
      set_val(:gread, value)
   end
   
   def gwrite=(value)
      set_val(:gwrite, value)
   end
   
   def gexec=(value)
      set_val(:gexec, value)
   end
   
   def oread=(value)
      set_val(:oread, value)
   end
   
   def owrite=(value)
      set_val(:owrite, value)
   end
   
   def oexec=(value)
      set_val(:oexec, value)
   end
   
   def owner=(value)
      set_val(:owner, value)
   end
   
   def group=(value)
      set_val(:group, value)
   end

   def mode_to_hash(mode)
      mode_bits = Hash.new()
      
      mode_bits[:suid]   = (mode & @@mode_bits_hash[:suid])   != 0 ? true : false
      mode_bits[:sgid]   = (mode & @@mode_bits_hash[:sgid])   != 0 ? true : false
      mode_bits[:sticky] = (mode & @@mode_bits_hash[:sticky]) != 0 ? true : false
      mode_bits[:uread]  = (mode & @@mode_bits_hash[:uread])  != 0 ? true : false
      mode_bits[:uwrite] = (mode & @@mode_bits_hash[:uwrite]) != 0 ? true : false
      mode_bits[:uexec]  = (mode & @@mode_bits_hash[:uexec])  != 0 ? true : false
      mode_bits[:gread]  = (mode & @@mode_bits_hash[:gread])  != 0 ? true : false
      mode_bits[:gwrite] = (mode & @@mode_bits_hash[:gwrite]) != 0 ? true : false
      mode_bits[:gexec]  = (mode & @@mode_bits_hash[:gexec])  != 0 ? true : false
      mode_bits[:oread]  = (mode & @@mode_bits_hash[:oread])  != 0 ? true : false
      mode_bits[:owrite] = (mode & @@mode_bits_hash[:owrite]) != 0 ? true : false
      mode_bits[:oexec]  = (mode & @@mode_bits_hash[:oexec])  != 0 ? true : false
      
      #returns the new hash
      return mode_bits      
   end

   def convert_symbol(value)
      if value == true or value == :true
         return true
      elsif value == false or value ==:false
         return false
      else
         return value
      end
   end
   
   def truth_to_symbol(value)
      if value == true
         return :true
      elsif value == false
         return :false
      else
         return value
      end
   end   
   

   def hash_to_mode(hash)
      new_mode = 0
      new_mode |= convert_symbol( hash[:suid]   ) ? @@mode_bits_hash[:suid]   : 0
      new_mode |= convert_symbol( hash[:sgid]   ) ? @@mode_bits_hash[:sgid]   : 0
      new_mode |= convert_symbol( hash[:sticky] ) ? @@mode_bits_hash[:sticky] : 0
      new_mode |= convert_symbol( hash[:uread]  ) ? @@mode_bits_hash[:uread]  : 0
      new_mode |= convert_symbol( hash[:uwrite] ) ? @@mode_bits_hash[:uwrite] : 0
      new_mode |= convert_symbol( hash[:uexec]  ) ? @@mode_bits_hash[:uexec]  : 0
      new_mode |= convert_symbol( hash[:gread]  ) ? @@mode_bits_hash[:gread]  : 0
      new_mode |= convert_symbol( hash[:gwrite] ) ? @@mode_bits_hash[:gwrite] : 0
      new_mode |= convert_symbol( hash[:gexec]  ) ? @@mode_bits_hash[:gexec]  : 0
      new_mode |= convert_symbol( hash[:oread]  ) ? @@mode_bits_hash[:oread]  : 0
      new_mode |= convert_symbol( hash[:owrite] ) ? @@mode_bits_hash[:owrite] : 0
      new_mode |= convert_symbol( hash[:oexec]  ) ? @@mode_bits_hash[:oexec]  : 0
      return new_mode
   end
end
