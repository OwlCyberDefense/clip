#!/usr/bin/python
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
#  Author: Matt Keeler <mkeeler@tresys.com>

import os
import sys
#import difflib
import subprocess
import shutil
import re
import ConfigParser

def tab(lst, num_tabs=1):
   return [join(['    ' * num_tabs,line]) for line in lst]
   
def join(lst):
   return ''.join(lst)

def compare_configs(input, output):
    in_config = ConfigParser.ConfigParser()
    out_config = ConfigParser.ConfigParser()

    in_config.read(input)
    out_config.read(output)

    if len(in_config.sections()) != len(out_config.sections()):
        return False

    for sec in in_config.sections():
        if sec not in out_config.sections():
            return False

        if len(in_config.items(sec)) != len(out_config.items(sec)):
            return False

        for key,val in in_config.items(sec):
            if not out_config.has_option(sec, key):
                return False

            if not val == out_config.get(sec, key):
                return False

    return True

class Command:
   results_template = 'Command %(command_name)s Results:\n%(rc_results)s%(stdout_results)s%(stderr_results)s\n\tCommand Completed Successfully: %(success)s'
   rc_results = 'Expected RC : %(expected)s, Actual RC : %(actual)s'
   stdout_results = 'Expected STDOUT :\n%(expected)s\nActual STDOUT :\n%(actual)s\n'
   stderr_results = 'Expected STDERR :\n%(expected)s\nActual STDERR :\n%(actual)s\n'
   
   def __init__(self, commands_dir, command_name):
      self.cmd_args = None
      self.cmd_proc = None
      self.expected_rc = None
      self.expected_stdout = None
      self.expected_stderr = None
      self.executed = False
      
      self.rc = None
      self.stdout = None
      self.stderr = None
      
      self.commands_dir = commands_dir
      self.command_name = command_name
      
      self.command_path = os.path.join(commands_dir, '%s.cmd' % self.command_name)
      if not os.path.exists(self.command_path):
         print 'Error: Command Not Valid: %s.cmd does not exist in %s' % (self.command_name, self.command_path)
         sys.exit(0)
      
      self.rc_path = os.path.join(commands_dir, '%s.rc' % self.command_name)
      self.stdout_path = os.path.join(commands_dir, '%s.stdout' % self.command_name)
      self.stderr_path = os.path.join(commands_dir, '%s.stderr' % self.command_name)
      
      self.rc_exists = os.path.exists(self.rc_path)
      self.stdout_exists = os.path.exists(self.stdout_path)
      self.stderr_exists = os.path.exists(self.stderr_path)
      
      self.get_cmd_args()

   def get_cmd_args(self):
      cmd_file = open(self.command_path, 'r')
      self.cmd_args = cmd_file.readline().strip('\n').split()
      cmd_file.close()
      
   def cache_rc(self):
      if self.rc_exists:
         rc_file = open(self.rc_path, 'r')
         self.expected_rc = int(rc_file.read().strip())
         rc_file.close()

   def cache_stdout(self):
      if self.stdout_exists:
         stdout = open(self.stdout_path)
         self.expected_stdout = stdout.read().split('\n')
         stdout.close()
         if not self.expected_stdout:
            self.expected_stdout = ['']
      
   def cache_stderr(self):
      if self.stderr_exists:
         stderr = open(self.stderr_path)
         self.expected_stderr = stderr.read().split('\n')
         stderr.close()
         if not self.expected_stderr:
            self.expected_stderr = []

   def execute(self, chroot):
      if not self.cmd_args:
         self.get_cmd_args()
         
      cmd = ['/usr/sbin/chroot', chroot]
      cmd.extend(self.cmd_args)

      try:
         # uncomment to print the command that is executed in the chroot
         #print "command run: %s" % cmd
         self.cmd_proc = subprocess.Popen(cmd, close_fds=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
         self.cmd_proc.wait()
      
         self.rc = self.cmd_proc.returncode
         stdout, stderr = self.cmd_proc.communicate()

         self.stdout = stdout.split('\n')
         self.stderr = stderr.split('\n')
        
         """ 
         if self.stdout:
            for err in self.stdout: 
               print err

         """

         if self.stderr:
            for err in self.stderr: 
               print err

      except:
         #FIXME
         #might want to do something here
         pass

      self.executed = True
      self.cmd_proc = None
      
   def does_stdout_differ(self):
      if hasattr(self, "_does_stdout_differ_cache"):
         return self._does_stdout_differ_cache
      if not self.executed:
         raise Exception('Command has not been executed.')
      elif not self.stdout_exists:
         return False
      elif not self.expected_stdout:
         self.cache_stdout()
      
      for i, e in enumerate(self.stdout):
         self.stdout[i] = e.lower()

      for i, e in enumerate(self.expected_stdout):
         self.expected_stdout[i] = e.lower()
         
      diff = self.stdout != self.expected_stdout

      if diff:

         print "------Stdout differs:-------\n"
         import difflib
         for l in difflib.ndiff(self.expected_stdout, self.stdout):
             print l
         print "------Expected stdout:------\n"      
         for s in self.expected_stdout:
            print s

         print "------Actual stdout:--------\n"

         for s in self.stdout:
            print s

         print "----------------------------\n"

      self._does_stdout_differ_cache = diff
      return diff

   def stdout_differ_string(self):
      if self.does_stdout_differ():
         return self.stdout_results % {'expected' : '\n'.join(tab(self.expected_stdout)), 'actual' : '\n'.join(tab(self.stdout))}
      else:
         return ''
     
   def does_stderr_differ(self):
      if hasattr(self, "_does_stderr_differ_cache"):
          return self._does_stderr_differ_cache
      if not self.executed:
         raise Exception('Command has not been executed.')
      elif not self.stderr_exists:
         return False
      elif not self.expected_stderr:
         self.cache_stderr()
      
      for i, e in enumerate(self.stderr):
         self.stderr[i] = e.lower()

      for i, e in enumerate(self.expected_stderr):
         self.expected_stderr[i] = e.lower()

      diff = self.stderr != self.expected_stderr

      if diff:
         print "------Stderr differs:-------\n"
         import difflib
         for l in difflib.ndiff(self.expected_stderr, self.stderr):
             print l
         print "------Expected stderr:------\n"      
         for s in self.expected_stderr:
            print s

         print "------Actual stderr:--------\n"

         for s in self.stderr:
            print s

         print "----------------------------\n"

      self._does_stderr_differ_cache = diff
      return diff

   def stderr_differ_string(self):
      if self.does_stderr_differ():
         return self.stderr_results % { 'expected' : '\n'.join(tab(self.expected_stderr)), 'actual' : '\n'.join(tab(self.stderr))}
      else:
         return ''
      
   def does_rc_differ(self):
      if hasattr(self, "_does_rc_differ_cache"):
         return self._does_rc_differ_cache
      if not self.executed:
         raise Exception('Command has not been executed.')
      elif not self.rc_exists:
         return False
      elif not self.expected_rc:
         self.cache_rc()
   
      diff = self.rc != self.expected_rc

      if diff:
         sys.stdout.write("RC differs\nexpected rc: %s\n\nactual rc: %s\n\n\n" % (self.expected_rc, self.rc))

      self._does_rc_differ_cache = diff
      return diff
      
   def rc_differ_string(self):
      if self.does_rc_differ():
         return self.rc_results % { 'expected' : self.expected_rc, 'actual' : self.rc}
      else:
         return ''
	   
   def get_results_string(self):
		rep = { 'command_name' : self.command_name,
              'rc_results' : '',
              'stdout_results' : '',
              'stderr_results' : '',
              'success' : not (self.does_rc_differ() or self.does_stdout_differ() or self.does_stderr_differ())} 

		if self.rc_differ_string():
			rep['rc_results'] = self.rc_differ_string()
		
		if self.does_stdout_differ():
			rep['stdout_results'] = self.rc_differ_string()
		
		if self.does_stderr_differ():
			rep['stderr_results'] = self.rc_differ_string()
		
		return self.results_template % rep
         
class TestCase:
   # Class Constants
   REQUIRES_SECTION = 0
   TEST_SECTION = 1
   VERIFY_SECTION = 2
   
   def __init__(self, test_path, chroot_path=None):
      self.parse_errors = False
   
      self.path = test_path
      self.test_name = os.path.basename(self.path)
      self.chroot = chroot_path
		
      self.commands_dir = os.path.join(self.path, 'commands')
      self.files_dir = os.path.join(self.path, 'files')
      self.manifest_path = os.path.join(self.path, 'test.manifest')
      self.parse_manifest()
      self.install_files()
      
   def parse_manifest(self):
      self.manifest = {self.REQUIRES_SECTION : [], self.TEST_SECTION : [], self.VERIFY_SECTION : []}
      
      cmd_type = None
      manifest_file = open(self.manifest_path, 'r')
      
      for line in manifest_file:
         line = line.strip()
         if line == '[requires]':
            cmd_type = self.REQUIRES_SECTION
         elif line == '[test]':
            cmd_type = self.TEST_SECTION
         elif line == '[verify]':
            cmd_type = self.VERIFY_SECTION
         elif line.startswith('#'):
            #comment line in the manifest
            continue
         else:
            if cmd_type == None:
               sys.stderr.write('WARNING: Manifest file improperly formatted.  Omitting line: %s\n' % line)                              
               self.parse_errors = True
            else:
               try:
                  if line.strip() != '':
                     if cmd_type == 0:
                        required_test_dir = os.path.join(os.path.dirname(self.path), line)
                        rtc = TestCase(required_test_dir, self.chroot)
                        #rtc = TestCase(required_test_dir)
                        self.manifest[cmd_type].append(rtc)
                     elif cmd_type == 1:
                        self.manifest[cmd_type].append(Command(self.commands_dir, line))
                     else:
                        self.manifest[cmd_type].append(Command(self.commands_dir, line))   	
               except Exception, e:
                  self.parse_errors = True
                  sys.stderr.write('%s\n' % str(e))
   
   def install_files(self):
      paths = []
      input_path = os.path.join(self.files_dir, 'input')
      for root, dirs, files in os.walk(input_path):
         for file in files:
            paths.append(os.path.join(root, file))
      
      for fpath in paths:
         dirname = re.sub(r'^%s(.*)' % re.escape(input_path), r'\1', os.path.dirname(fpath)).lstrip(os.path.sep)
         basename = os.path.basename(fpath)
         chroot_dir = os.path.join(self.chroot, dirname)
         try:
            os.makedirs(chroot_dir)
         except Exception, e:
            if e.errno == 17:
               pass
            else:
               raise
         shutil.copy2(fpath, os.path.join(chroot_dir, basename))
   
   def check_output_files(self):
      rc = True
      expected = 'Expected File Contents:\n%s'
      actual = 'Actual File Contents:\n%s'
      fdiffer = 'Output File %(oname)s differs:\n%(expected)s\n%(actual)s\n'
      output_path = os.path.join(self.files_dir, 'output')

      compare_success = True

      # Walk through all files in the expected output
      for root,dirs,files in os.walk(output_path):
         for file in files:
            opath = os.path.join(root, file)
            dirname = re.sub(r'^%s(.*)' % re.escape(output_path), r'\1', root).lstrip(os.path.sep)
            cpath = os.path.join(self.chroot, dirname, file)
            subprocess.call('diff %s %s' % (opath, cpath), shell=True)

            ofile = open(opath)
            otext = ofile.readlines()
            ofile.close()

            if os.path.exists(cpath):
               compare_success = True

               cfile = open(cpath)
               ctext = cfile.readlines()
               cfile.close()

               # Compare config files in memory
               if os.path.splitext(opath)[1] == '.cfg':
                  if not compare_configs(opath, cpath):
                     rc = False
                     compare_success = False
               # For other files, do sting comparison of contents
               elif otext != ctext:
                  rc = False
                  compare_success = False

               # Report on failed file comparisons
               if not compare_success:
                  etext = '\n'.join(tab((expected % join(tab(otext))).split('\n')))
                  atext = '\n'.join(tab((actual % join(tab(ctext))).split('\n')))
                  dtext = fdiffer % {'oname' : os.path.join(dirname,file), 'expected' : etext, 'actual' : atext}
                  sys.stdout.write('\n'.join(tab(dtext.rstrip('\n').split('\n'))) + '\n')
            else:
               rc = False
               sys.stdout.write('\n'.join(tab(["Expected output file '%s' does not exist" % cpath])) + '\n')

      return rc
   
   def run_test(self):
      #sys.stdout.write('Test %s:\n' % self.test_name)
      sys.stdout.write('Test %s:\n' % self.path)
      rc = self.__run_requires()
      if rc:
         rc = self.__run_tests()
         if rc:
            rc = self.__run_verification()
            if rc:
               rc = self.check_output_files()
               if rc:
                  sys.stdout.write('Test %s Completed Successfully: True\n' % self.test_name)
                  return True
               #sys.stdout.write('Test %s Completed Successfully: True\n\n' % self.test_name)
               #return True
      sys.stdout.write('Test %s Completed Successfully: False\n' % self.test_name)
      return False
   
   def __run_requires(self):
      if not self.manifest[self.REQUIRES_SECTION]:
         return True

      testName = self.path.rstrip('/')
      sys.stdout.write(join(tab(['Requires Section - for test %s:\n' % (testName)])))
      for required_test_dir in self.manifest[self.REQUIRES_SECTION]:
         sys.stdout.write(join(tab(['Required test = %s\n\n' % (required_test_dir.path)])))
         required_test_successful = required_test_dir.run_test()
         if not required_test_successful:
            sys.stdout.write(join(tab(['Requires Section Completed Successfully: False\n\n'])))
            break

      return required_test_successful
      
   def __run_tests(self):
      testName = self.path
      sys.stdout.write(join(tab(['Tests Section - %s\n' % (testName)])))
      cmds_ok = True
      for cmd in self.manifest[self.TEST_SECTION]:
         cmd.execute(self.chroot)
         if cmd.does_rc_differ() or cmd.does_stdout_differ() or cmd.does_stderr_differ():
            cmds_ok = False
            
         sys.stdout.write('%s\n\n' % '\n'.join(tab(cmd.get_results_string().split('\n'), num_tabs=2)))
         
         if not cmds_ok:
            break
      
      sys.stdout.write(join(tab(['Tests Section Completed Successfully: %s\n\n' % str(cmds_ok)])))
      return cmds_ok
   
   def __run_verification(self):
      if not self.manifest[self.VERIFY_SECTION]:
         return True
      sys.stdout.write(join(tab(['Verification Section:\n'])))
      cmds_ok = True
      for cmd in self.manifest[self.VERIFY_SECTION]:
         cmd.execute(self.chroot)
         if cmd.does_rc_differ() or cmd.does_stdout_differ() or cmd.does_stderr_differ():
            cmds_ok = False
            
         sys.stdout.write('%s\n\n' % '\n'.join(tab(cmd.get_results_string().split('\n'), num_tabs=2)))
         
         if not cmds_ok:
            break
      
      sys.stdout.write(join(tab(['Verification Section Completed Successfully: %s\n' % str(cmds_ok)])))
      return cmds_ok
      
