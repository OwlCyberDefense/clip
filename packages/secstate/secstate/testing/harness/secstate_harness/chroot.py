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
# Authors: Stuart Reynald <sreynald@tresys.com> 
#          Spencer Shimko <sshimko@tresys.com>
#          Matt Keeler    <mkeeler@tresys.com>

import sys
import os
import subprocess
import string
import shutil
import re
import errno

def safe_wait(proc):
    while True:
        try:
            return proc.wait()
        except OSError, e:
            if e.errno != 4:
                raise
            else:
                safe_sleep(.5)

def safe_sleep(duration):
    try:
        time.sleep(duration)
    except IOError, e:
        if e.errno != 514:
            raise

def printmap(str):
    print str

class ChrootException(Exception):
    def __init__(self, reason):
        self.reason = reason
    def __str__(self):
        return str(self.reason)

class Chroot:
    '''Class for creating and managing a chroot environment'''
    def __init__(self, chroot_path, bind_mount_deps, dir_deps, binary_deps, file_deps):
        '''We expect the chroot path, a list of bind mounts, any directories to be recursively copied, and a list of binaries to copy.'''
        self.chroot_path = chroot_path
        self.deps_built = False
        self.chroot_populated = False
        
        #list of files to copy in
        self.copy_deps = []
        
        self.bind_mount_deps = bind_mount_deps
        self.dir_deps = dir_deps
        self.binary_deps = binary_deps
        
        # full list of file dependencies (not dirs)
        self.file_deps = file_deps

        self.copy_deps.extend(self.file_deps)
        self.copy_deps.extend(self.binary_deps)

        chroot_parent = os.path.normpath(os.path.join(sys.argv[2]+"/../"))

        if os.path.isdir(self.chroot_path):
            raise ChrootException("""chroot path must not exist: %s \n""" % sys.argv[2])

        if not os.path.isdir(chroot_parent):
            raise ChrootException("""chroot path must not exist: %s \n""" % chroot_parent)

        if os.getuid() != 0:
            raise ChrootException("Bind mounting requires root access.  Please rerun this script as root!")

    def __determine_ldd_deps(self, binfile):
        '''Determine the library deps of a given binary via calling ldd.'''
        ldd_cmd = ['/usr/bin/ldd', binfile ]
        ldd_proc = subprocess.Popen(ldd_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, close_fds=True)

        try:
            stderr = ldd_proc.stderr
            stdout = ldd_proc.stdout

            ldd_errors = stderr.readlines()
            ldd_out = stdout.readlines()

            for line in ldd_out:
                lsub = re.sub(r'^(.*=> )?\t?(.*)\(.*\)\n$', r'\2', line).strip()
                if lsub:
                    self.copy_deps.append(lsub)
        except:
            pass
        safe_wait(ldd_proc)

    def __check_bind_mount(self, mnt):
        '''Verify a given bind mount path is a mount point.'''
        return os.path.ismount(mnt)
    
    def __validate_file_deps(self, file):
        if not os.path.isfile(file):
            raise ChrootException("""A file listed as or determined to be a dependency does not exist: %s""" % file)

    def __validate_dir_deps(self, dir):
        if not os.path.isdir(dir):
            raise ChrootException("""A dir listed as or determined to be a dependency does not exist: %s""" % dir)

    def __mkdirp(self, dir):
        try:
            os.makedirs(dir)
        except OSError, e:
            if e.errno == errno.EEXIST:
                pass
            else: 
                raise

    def build_deps(self):
        '''Build dependencies for the chroot environment.'''
        # This unfortunate distutils nastiness grabs the python module and lib install dirs
        from distutils.sysconfig import get_python_lib; 
        self.dir_deps.append(get_python_lib(plat_specific=1))
        self. dir_deps.append(get_python_lib(standard_lib=1))
        self.dir_deps.append(get_python_lib(plat_specific=0))
        # distutils doesnt seem to honor plat_specific=0, standard_lib=1 so build it ourselves
        self.dir_deps.append(os.path.normpath(os.path.join(get_python_lib(plat_specific=0) + '/../')))

        map(self.__determine_ldd_deps, self.binary_deps)
        filter(self.__check_bind_mount, self.bind_mount_deps)

        map(self.__validate_file_deps, self.file_deps)
        map(self.__validate_dir_deps, self.dir_deps)
        self.deps_built = True
        return

    def print_deps(self):
        '''Prints the current dependencies to standard out.'''
        if not self.deps_built:
            raise(ChrootException("Dependencies not built."))

        print "Directory dependencies (will be copied recursively):"
        map(printmap, self.dir_deps)
        print "\nFile dependencies:"
        map(printmap, self.file_deps)
        print "\nBind mounts:"
        map(printmap, self.bind_mount_deps)
        return


    def build_chroot(self):
        '''Creates a chroot'able environment by populating it with files, directories, and bind mounts.'''
        if not self.deps_built:
            raise ChrootException("Dependencies not built.")
        if self.chroot_populated:
            raise ChrootException("The chroot environment has already been populated by calling built_chroot().")

        os.mkdir(self.chroot_path)

        for file in self.copy_deps:
            for dir in self.dir_deps:
                if file.startswith(dir.rstrip('/') + '/'):
                    break
            else:
                filename = os.path.basename(file)
                dirname = os.path.dirname(file).lstrip('/')
                newfile = os.path.join(self.chroot_path, dirname, filename)
                newdir = os.path.join(self.chroot_path, dirname)
    
                if not os.path.exists(newdir):
                    os.makedirs(newdir)
    
                shutil.copy2(file,newfile)

        dir_deps = []
        for newdir in self.dir_deps:
            put_in = False
            for i, olddir in enumerate(dir_deps):
                if olddir.startswith(newdir.rstrip('/') + '/'):
                    dir_deps[i] = newdir
                    put_in = True
                elif newdir.startswith(olddir.rstrip('/') + '/'):
                    break
            else:
                if not put_in:
                    dir_deps.append(newdir)
                
        dir_deps = list(set(dir_deps))

        for dir in dir_deps:
            dirname = dir.lstrip('/')
            newdir = os.path.join(self.chroot_path, dirname)
            self.__mkdirp(os.path.dirname(newdir))
            try:
                shutil.copytree(dir,newdir)
            except OSError, e:
                if e.errno == errno.EEXIST:
                    pass
                else: 
                    raise

        for dir in self.bind_mount_deps:
            newdir = os.path.join(self.chroot_path, dir.lstrip('/'))
            self.__mkdirp(newdir)
            subprocess.call(["/bin/mount", "--bind", dir,  newdir])

        self.chroot_populated = True
        return

    def clean_chroot(self):
        '''Cleanup an existing chroot'''

        for dir in self.bind_mount_deps:
            mount = os.path.join(self.chroot_path, dir.lstrip('/'))
            #make sure directory is mounted
            #if os.path.ismount(mount):
            #dont care if we are bind mounting a directory on a filesystem into the Chroot
            #which is located on the same filesystem, always do the unmount
            dev_null = open(os.devnull, "w")
            subprocess.call(["/bin/umount", "-l", mount], stdout=dev_null, stderr=dev_null)

        shutil.rmtree(self.chroot_path)
        self.chroot_populated = False

if __name__ == "__main__":
    print "This module cannot be run as a main()"
    sys.exit(1)

