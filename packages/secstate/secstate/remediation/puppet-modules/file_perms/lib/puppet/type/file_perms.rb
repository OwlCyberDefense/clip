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
#  This file is the implementation of the file_perms type

require 'etc'

Puppet::Type.newtype(:file_perms) do
   @doc = "Set file permission bits while ignoring some others."
   
   newparam(:name) do
      isnamevar
   end
   
   newparam(:recurse) do
      newvalues(:true, :false)
      
      defaultto :false
   end

   newparam(:change_dirs) do
      newvalues(:true, :false)
      
      defaultto :false
   end
   
   newparam(:change_files) do
      newvalues(:true, :false)
      
      defaultto :true
   end
   
   newproperty(:suid) do
      newvalue(:true)
      newvalue(:false)
   end

   newproperty(:sgid) do
      newvalue(:true)
      newvalue(:false)
   end

   newproperty(:sticky) do
      newvalue(:true)
      newvalue(:false) 
   end

   newproperty(:uread) do
      newvalue(:true)
      newvalue(:false)
   end

   newproperty(:uwrite) do
      newvalue(:true)
      newvalue(:false)
   end

   newproperty(:uexec) do
      newvalue(:true)
      newvalue(:false)
   end

   newproperty(:gread) do
      newvalue(:true)
      newvalue(:false)
   end

   newproperty(:gwrite) do
      newvalue(:true)
      newvalue(:false)
   end

   newproperty(:gexec) do
      newvalue(:true)
      newvalue(:false)
   end

   newproperty(:oread) do
      newvalue(:true)
      newvalue(:false)
   end

   newproperty(:owrite) do
      newvalue(:true)
      newvalue(:false)
   end

   newproperty(:oexec) do
      newvalue(:true)
      newvalue(:false)
   end
   
   newproperty(:owner) do
      validate do |value|
         begin
            case value
            when Integer
               Etc.getpwuid(value)
            when Symbol
               Etc.getpwnam(value.to_s)
            when String
               Etc.getpwnam(value)
            end
         rescue
            fail Puppet::Error,"The owner specified is not a valid uid or user name"
         end
      end
      
      munge do |value|
         case value
         when Symbol, String
            Etc.getpwnam(value.to_s).uid
         else
            super
         end
      end            
   end
   
   newproperty(:group) do
      validate do |value|
         begin
            case value
            when Integer
               Etc.getgrgid(value)
            when Symbol
               Etc.getgrnam(value.to_s)
            when String
               Etc.getgrnam(value)
            end
         rescue
            fail Puppet::Error,"The group specified is not a valid gid or group name"
         end
      end 
      munge do |value|
         case value
         when Symbol, String
            Etc.getgrnam(value.to_s).gid
         else
            super
         end
      end
   end
end