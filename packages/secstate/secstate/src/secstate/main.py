# Author: Josh Adams <jadams@tresys.com>
#
# Copyright (C) 2010 Tresys Technology, LLC
#
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
#  File: main.py
#  This file is the core implementation of the secstate module.

import sys
import os
import shutil
import ConfigParser
import logging
from logging.handlers import SysLogHandler
import tarfile
import zipfile
import tempfile
import subprocess
import time
import mimetypes
import simplejson as json
import xml.dom.minidom

import openscap_api as oscap
from secstate.util import *

NONE_PROFILE = 'None'

class Secstate:
    def __init__(self, conf_file):
        self.setConfigFile(conf_file)
        self.conf_dir = self.config.get('secstate', 'conf_dir')
        if not os.path.isdir(self.conf_dir):
            try:
                os.makedirs(self.conf_dir)
            except IOError, e:
                # Logging is not initialized yet, so we have to write to stderr directly
                sys.stderr.write("Could not create config directory: %(dir)s\n" % {'dir':self.conf_dir})
                return (None, None)

        self.content = {}
        self.content_configs = {}
        self.load_content()
        self.log = self.getLogger()
        self.benchmark_dir = self.config.get('secstate', 'benchmark_dir')
        self.tempfiles = {'dirs':[], 'files':[]}

    def __del__(self):
        try:
            for dir in self.tempfiles['dirs']:
                shutil.rmtree(dir)

            for tmpfile in self.tempfiles['files']:
                os.remove(tmpfile)
        except IOError,e:
            sec_instance.log.error("Error cleaning up temporary files: %(err)s" % {'err':e})

    def setConfigFile(self, conf):
        config = ConfigParser.ConfigParser()
        try:
            fp = open(conf)
            config.readfp(fp)
        except IOError,e:
            # Logging is not initialized yet, so we have to write to stderr directly
            sys.stderr.write("Could not open config file: %(error)s\n" % {'error':e})
            return None
        self.config = config
        fp.close()

    def isDebugging(self):
        return self.config.getint('logging', 'debugging') > 0

    def getLogger(self):
        log_type = self.config.get('logging', 'logger')
        log = logging.getLogger()
        if self.isDebugging():
            log.setLevel(logging.DEBUG)
        else:
            log.setLevel(logging.INFO)

        if log_type== 'syslog':
            syslog = SysLogHandler(addres='/dev/log')
            formatter = logging.Formatter('%(name)s:%(levelname)s:%(message)s')
            syslog.setFormatter(formatter)
            log.addHandler(syslog)

        else:
            console = logging.StreamHandler()
            formatter = logging.Formatter('%(message)s')
            console.setFormatter(formatter)
            log.addHandler(console)

        return log

    def load_content(self):
        conf_dir = self.config.get('secstate', 'conf_dir')
        for conf_file in os.listdir(conf_dir):
            id = os.path.splitext(conf_file)[0]
            self.content_configs[id] = os.path.join(conf_dir, conf_file)
            try:
                config = load_config(os.path.join(conf_dir, conf_file))
            except SecstateException, e:
                self.log.error(str(e))
                return False
            content_file = config.get(id, 'file')
            self.content[id] = content_file

    def combine_def_models(self, target, source):
        """
        Function:   Add all the definitions from the source model to the target model
        Input:      Two oval_definition_model's
        Output:     Success or failure of combination
        """
        for defn in source.definitions:
            if target.get_definition(defn.get_id()) == None:
                new_def = oscap.oval.definition_clone(target, defn)
                if new_def == None:
                    self.log.error("Error adding definition %(name)s to target model" % {'name':defn.id()})
                    return False
                else:
                    self.log.debug("Succesfully added %(name)s to target model" % {'name':defn.id})

        for test in source.tests:
            if target.get_test(test.id) == None:
                new_test = oscap.oval.test_clone(target, test)
                if new_test == None:
                    self.log.error("Error adding test %(name)s to target model" % {'name':test.id})
                    return False
                else:
                    self.log.debug("Succesfully added %(name)s to target model" % {'name':test.id})

        for obj in source.objects:
            if target.get_object(obj.id) == None:
                new_obj = oscap.oval.object_clone(target, obj)
                if new_obj == None:
                    self.log.error("Error adding object %(name)s to target model" % {'name':obj.id})
                    return False
                else:
                    self.log.debug("Succesfully added %(name)s to target model" % {'name':obj.id})

        for state in source.states:
            if target.get_state(state.id) == None:
                new_state = oscap.oval.state_clone(target, state)
                if new_state == None:
                    self.log.error("Error adding state %(name)s to target model" % {'name':state.id})
                    return False
                else:
                    self.log.debug("Succesfully added %(name)s to target model" % {'name':state.id})

        for var in source.variables:
            if target.get_variable(var.id) == None:
                new_var = oscap.oval.variable_clone(target, var)
                if new_var == None:
                    self.log.error("Error adding variable %(name)s to target model" % {'name':var.id})
                    return False
                else:
                    self.log.debug("Succesfully added %(name)s to target model" % {'name':var.id})

        return True

    def import_oval(self, oval_file, store_path=None):
        def_model = oscap.oval.definition_model_import(oval_file)
        if def_model == None:
            self.log.error("Error importing OVAL content: %(file)s" % {'file':oval_file})
            return None

        if not oscap.OSCAP.oscap_validate_document_py(oval_file, oscap.OSCAP.OSCAP_DOCUMENT_OVAL_DEFINITIONS, None, None, None):
            self.log.error("Definition model is invalid for file: %s" % oval_file)
            return None

        oval_id = os.path.splitext(os.path.basename(oval_file))[0]
        def_model.__dict__['id'] = oval_id

        if self.content.has_key(oval_id):
            config = ConfigParser.ConfigParser()
            config.optionxform = str
            if config.read(self.content_configs[oval_id]) == []:
                self.log.error("Error loading config file: %(file)s" % {'file':self.content_configs[oval_id]})
                return None

            def_model.__dict__['config'] = config

        if store_path:
            if not os.path.isdir(store_path):
                try:
                    os.makedirs(store_path)
                except IOError, e:
                    self.log.error("Could not create benchmark directory: %(dir)s" % {'dir':bench_dir})
                    return None

            shutil.copy(oval_file, store_path)
            config = ConfigParser.ConfigParser()
            config.optionxform = str
            id = os.path.splitext(os.path.basename(oval_file))[0]
            config.add_section(id)
            config.set(id, 'selected', True)
            config.set(id, 'file', os.path.join(store_path, os.path.basename(oval_file)))
            conf_file = open(os.path.join(self.config.get('secstate', 'conf_dir'), id + ".cfg"), 'w')
            config.write(conf_file)
            conf_file.close()

        return def_model


    def import_benchmark(self, benchmark_file, oval_path="", store_path=None, changes=False, active_profile=NONE_PROFILE):
        """
        Function:       Imports an XCCDF benchmark
        Input:          Source File, path to associated OVAL content
        Output:         A tuple containg validated xccdf_benchmark and oval_definition_model
        """

        if oval_path == "":
            oval_path = os.path.split(benchmark_file)[0]
        #Create benchmark dir if it does not already exist
        bench_dir = self.benchmark_dir
        if not os.path.isdir(bench_dir):
            try:
                os.makedirs(bench_dir)
            except IOError, e:
                self.log.error("Could not create benchmark directory: %(dir)s" % {'dir':bench_dir})
                return None

        benchmark = oscap.xccdf.benchmark_import(benchmark_file)
        if benchmark == None:
            self.log.error("Error importing benchmark %(file)s" % {'file':benchmark_file})
            return None
        
        if not oscap.OSCAP.oscap_validate_document_py(benchmark_file, oscap.OSCAP.OSCAP_DOCUMENT_XCCDF, None, None, None):
            self.log.error("Definition model is invalid for file: %s" % benchmark_file)
            return None

        benchmark.__dict__['oval'] = {}
        oval_files = xccdf_get_refs(benchmark)
        for oval in list(set(oval_files)):
            oval_file = os.path.join(oval_path, oval)
            def_model = self.import_oval(oval_file)
            if def_model == None:
                return None
            benchmark.__dict__['oval'][oval] = def_model

        profile = oscap.xccdf.profile_new()
        profile.id = NONE_PROFILE

        # This is where we add the "None" profile
        # We give it a title to make audit output valid xccdf
        title = oscap.common.text_new()
        title.text = NONE_PROFILE
        oscap.xccdf.profile_add_title(profile, title)
        benchmark.add_profile(profile)

        config = ConfigParser.ConfigParser()
        config.optionxform = str
        if self.content_configs.has_key(benchmark.id):
            if config.read(self.content_configs[benchmark.id]) == []:
                self.log.error("Error opening config file: %(file)s" % {'file':self.content_config[benchmark.id]})
                return None
        else:
            config.add_section(benchmark.id)
            config.set(benchmark.id, 'profile', active_profile)
            
        benchmark.__dict__['config'] = config

        if changes:
            benchmark = apply_changes_profile(benchmark)

        benchmark.__dict__['selections'] = {}
        for item in xccdf_get_items(benchmark, oscap.xccdf.XCCDF_ITEM, benchmark.content):
            benchmark.selections[item.id] = item.selected

        benchmark.__dict__['vals'] = {}
        for val in xccdf_get_values(benchmark):
            val_instance = val.instances[0]
            benchmark.vals[val.id] = value_instance_to_value(val_instance)

        profiles = []
        current_profile = benchmark.config.get(benchmark.id, 'profile')
        prof_item = benchmark.get_member(oscap.xccdf.XCCDF_PROFILE, current_profile)
        if prof_item == None:
            self.log.error("Import failed: profile '%(prof)s' does not exist" % {'prof':current_profile})
            return None
        profiles.append(prof_item.to_profile())

        tmp_prof = profiles[0]
        while tmp_prof.extends != None:
            tmp_prof_item = benchmark.get_member(oscap.xccdf.XCCDF_PROFILE, tmp_prof.extends)
            if tmp_prof_item == None:
                self.log.error("Import failed: profile '%(prof)s does not exist" % {'prof':tmp_prof})
                return None
            tmp_prof = tmp_prof_item.to_profile()
            profiles.append(tmp_prof)

        # Start with the base profile first
        profiles.reverse()
        for profile in profiles:
            prof_sel = get_profile_selections(benchmark, profile)
            for key,val in prof_sel.items():
                benchmark.selections[key] = val

            for setval in profile.setvalues:
                if not benchmark.get_item(setval.item) != None:
                    if not benchmark.get_item(setval.item).prohibit_changes:
                        benchmark.vals[setval.item] = setval.value
                else:
                    self.log.error("Set value references non-existant value: %(val)s" % {'val':setval.item})
                    continue

            for refval in profile.refine_values:
                value_item = benchmark.get_item(refval.item)
                if value_item == None:
                    self.log.error("Refine value references non-existant value: %(val)s" % {'val':refval.item})
                    continue
                value = value_item.to_value()

                if not value.prohibit_changes:
                    benchmark.vals[refval.item] = value_instance_to_value(value.get_instance_by_selector(refval.selector))

        benchmark.__dict__['mitigations'] = {}
        if benchmark.config.has_section('mitigations'):
            for opt,val in benchmark.config.items('mitigations'):
                benchmark.mitigations[opt] = json.loads(val)

        if store_path != None:
            id = get_benchmark_id(benchmark_file)
            directory = os.path.join(bench_dir, id)
            if os.path.isdir(directory):
                self.log.error("A benchmark named %(id)s already exists: %(dir)s" % {'id':id, 'dir':directory})
                return None

            try:
                os.mkdir(directory)
                shutil.copy(benchmark_file, directory)
                benchmark.config.set(id, 'file', os.path.join(directory, os.path.basename(benchmark_file)))
                benchmark.config.set(id, 'selected', True)

                for oval in list(set(oval_files)):
                    shutil.copy(os.path.join(oval_path, oval), directory)

                conf_file = open(os.path.join(self.config.get('secstate', 'conf_dir'), id + ".cfg"), 'w')
                benchmark.config.write(conf_file)
                conf_file.close()

            except (IOError, OSError), e:
                self.log.error("Error importing content: %(error)s" % {'error':e})
                shutil.rmtree(directory)
                return None

        return benchmark

    def import_zipped_content(self, zip, file_type, store_path, changes=False, active_profile=NONE_PROFILE):
        """
        Function:       Validate and copy content from zipped file to repository
        Input:          Zipped file containing content
        Output:         Success of failure of the import
        """
        extract_path = tempfile.mkdtemp()
        self.tempfiles['dirs'].append(extract_path)

        if file_type[0] == "application/x-tar":
            tar_file = None
            try:
                if file_type[1] == "gzip":
                    tar_file = tarfile.open(zip, 'r:gz')
                elif file_type[1] == "bzip2":
                    tar_file = tarfile.open(zip, 'r:bz2')
                elif file_type[1] == None:
                    tar_file = tarfile.open(zip, 'r:')
                else:
                    self.log.error("Unsupported encoding: %(content)s - %(file_type)s" % {'content':zip,
                                                                                     'file_type':file_type[1]})
                    return None
            except IOError,e:
                self.log.error("Error opening tarfile: %(file)s" % {'file':zip})
                return None

            for member in tar_file.getmembers():
                tar_file.extract(member, extract_path)

            tar_file.close()

        elif file_type[0] == "application/zip":
            if sys.version_info < (2, 6):
                self.log.error("Zip file support requires Python >= 2.6")
                return None
            
            zip_files = zipfile.ZipFile(zip, 'r')
            zip_files.extractall(extract_path)

            zip_files.close()

        elif file_type[0] == "application/x-bzip2":
            tar_file = None
            try:
                tar_file = tarfile.open(zip, 'r:bz2')
            except IOError,e:
                self.log.error("Error opening tarfile: %(file)s" % {'file':zip})
                return None

            for member in tar_file.getmembers():
                tar_file.extract(member, extract_path)

            tar_file.close()

        else:
            self.log.error("Unsupported file type: %(content)s" % {'content':zip})
            return None

        # Now that the files have been extracted, find the benchmark and store the content if necessary
        xccdf = None
        directory = None
        extracted_files = os.listdir(extract_path)
        if (len(extracted_files) == 1) and os.path.isdir(os.path.join(extract_path, extracted_files[0])):
            extract_path = os.path.join(extract_path, extracted_files[0])

        for extracted_file in os.listdir(extract_path):
            print extracted_file
            if mimetypes.guess_type(os.path.join(extract_path, extracted_file))[0] == "text/xml":
                if is_valid_xccdf_file(os.path.join(extract_path, extracted_file)):
                    xccdf = extracted_file
            
        if xccdf == None:
            self.log.error("Could not find XCCDF benchmark in archive %(file)s", {'file':zip})
            return None
        
        benchmark = self.import_benchmark(os.path.join(extract_path, xccdf), extract_path, store_path, changes, active_profile=active_profile)
        if benchmark == None:
            return None
        
        return benchmark

    def import_content(self, content, changes=True, save=False, active_profile=NONE_PROFILE):
        """
        Function:       Validates XCCDF/OVAL content and optionally saves it to the data store
        Input:          File containing content
        Output:         Returns a tuple containing a validated benchmar and definition model
        """
        xccdf = False
        oval = False
        store_path = None
        conf_dir = self.config.get('secstate', 'conf_dir')

        if save:
            if not os.path.isdir(conf_dir):
                try:
                    os.makedirs(conf_dir)
                except IOError, e:
                    self.log.error("Could not create directory: %(dir)s" % {'dir':conf_dir})
                    return None

        if self.content.has_key(content):
            return self.import_content(self.content[content], changes, active_profile=active_profile) 

        if save:
            store_path = self.config.get('secstate', 'benchmark_dir')

        if not os.path.isfile(content):
            self.log.error("No such file: '%(file)s'" % {'file':content})
            return None

        file_type = mimetypes.guess_type(content)
        if file_type[0] == "text/xml":
            try:
                xccdf = is_valid_xccdf_file(content)
                oval = is_valid_oval_file(content)
            except SecstateException, e:
                self.log.error(str(e))
                return None

            # We expect either XCCDF or OVAL
            if xccdf:
                return self.import_benchmark(content, store_path=store_path, oval_path=os.path.dirname(content), changes=changes, active_profile=active_profile)
            elif oval:
                if save:
                    store_path = self.config.get('secstate', 'oval_dir')
                return self.import_oval(content, store_path)
            else:
                self.log.error("File %s is neither OVAL nor XCCDF." % content)
                
        else:
            return self.import_zipped_content(content, file_type, store_path=store_path, changes=changes, active_profile=active_profile)

    def export(self,  benchmark_id, new_file, original=False):
        if not self.content.has_key(benchmark_id):
            self.log.error("No benchmark '%(id)s' has been imported" % {'id':benchmark_id})
            return False

        if os.path.split(self.content[benchmark_id])[0] == self.config.get('secstate', 'oval_dir'):
            shutil.copy(self.content[benchmark_id], new_file)
            return True

        benchmark_file = None
        archive = zipfile.ZipFile(new_file, 'w')
        if original:
            benchmark_file = self.content[benchmark_id]
        else:
            benchmark_file = tempfile.mktemp()
            self.tempfiles['files'].append(benchmark_file)
            benchmark =  self.import_content(benchmark_id)
            if benchmark.export(benchmark_file) == None:
                self.log.error("Error exporting benchmark to %(file)s" % {'file':new_file})
                return False

        archive.write(benchmark_file, os.path.basename(self.content[benchmark_id]))
        bench_dir = os.path.join(self.benchmark_dir, benchmark_id)
        for content in os.listdir(bench_dir):
            file_type = mimetypes.guess_type(os.path.join(bench_dir, content))
            if (file_type[0] == "text/xml") and (not is_valid_xccdf_file(os.path.join(bench_dir, content))):
                archive.write(os.path.join(bench_dir, content), content)

        try:
            cfg = load_config(self.content_configs[benchmark_id])
        except SecstateException, e:
            self.log.error(str(e))
            return False

        archive.close()
        return True

    def remove_content(self, benchmark_id):
        if benchmark_id == 'all':
            for key in self.content:
                self.remove_content(key)
                
        elif self.content.has_key(benchmark_id):
            try:
                cfg = load_config(self.content_configs[benchmark_id])
            except SecstateException, e:
                self.log.error(str(e))
                return False
            try:
                if os.path.split(cfg.get(benchmark_id, "file"))[0] != self.config.get('secstate', 'oval_dir'):
                    shutil.rmtree(os.path.split(cfg.get(benchmark_id, "file"))[0])
                else:
                    os.remove(cfg.get(benchmark_id, "file"))
                os.remove(self.content_configs[benchmark_id])
                    
            except IOError,e:
                self.log.error("Error removing content: %(error)s" % {'error':e})
                return False

        else:
            self.log.error("Could not find %(benchmark)s in database" % {'benchmark':benchmark_id})
            return False

        return True

    def select(self, benchmark_id, item_id, selected, recurse=False):
        """
        Function:       Set the specified item to be selected, as well as its subelements
        Input:          Benchmark id, id of rule or group, boolean value to set the items selected status
        Output:         Succes or failure
        """
        sel_dict = {'selected':selected}
        
        if not self.content.has_key(benchmark_id):
            self.log.error("No benchmark %(id)s in datastore" % {'id':benchmark_id})
            return False

        benchmark = self.import_content(benchmark_id)
        if benchmark == None:
            self.log.error("Error opening benchmark: %(file)s" % {'file':benchmark_id})
            return False

        if not benchmark.__dict__.has_key('oval'):
            benchmark.config.set(benchmark_id, 'selected', selected)
            self.log.debug("Set Oval file %(file)s to %(sel)s" % {'file':benchmark_id,
                                                                      'sel':selected})
        else:

            if item_id == benchmark_id:
                benchmark.config.set(benchmark_id, 'selected', selected)
                self.log.debug("Setting %(id)s to %(val)s" % {'id':benchmark_id,
                                                                  'val':selected})
                item = benchmark.to_item()
            else:
                item = benchmark.get_item(item_id)

            if item == None:
                item = benchmark.get_member(oscap.xccdf.XCCDF_PROFILE, item_id)

                if item == None:
                    self.log.error("Benchmark %(bench_id)s does not contain %(item_id)s" % {'bench_id':benchmark_id,
                                                                                            'item_id':item_id})
                    return False

            if item.type == oscap.xccdf.XCCDF_PROFILE:
                # check if benchmark was selected before selecting new benchmark
                if benchmark.config.getboolean(benchmark_id, 'selected'):
                    benchmark.config.set(benchmark_id, 'selected', selected)

                benchmark.config.set(benchmark_id, 'profile', item_id)
                self.log.debug("Setting active profile to %(id)s" % {'id':item_id})
            else:
                if benchmark.config.has_option(benchmark_id, 'profile'):
                    active_profile = benchmark.config.get(benchmark_id, 'profile')
                    # Create 'Custom' profile if it doesn't exist
                    if (active_profile != "Custom"):
                        if not benchmark.config.has_section("Custom"):
                            benchmark.config.add_section("Custom")

                        # We either keep the 'extends' property from the configured profile,
                        # or set the 'extends' property to the original profile, we were on
                        if benchmark.config.has_section(active_profile):
                            for opt,val in benchmark.config.items(active_profile):
                                benchmark.config.set('Custom', opt, val)
                        elif active_profile != "None":
                            benchmark.config.set('Custom', 'extends', active_profile)
                        active_profile = 'Custom'

                if item.type != oscap.xccdf.XCCDF_BENCHMARK:
                    benchmark.config.set(active_profile, item_id, json.dumps(sel_dict))
                    self.log.debug("Setting %(id)s to %(val)s" % {'id':item_id,
                                                                  'val':selected})
                    if selected:
                        parent = item.parent
                        while parent.id != benchmark_id:
                            benchmark.config.set(active_profile, parent.id, json.dumps(sel_dict))
                            self.log.debug("Setting %(id)s to %(val)s" % {'id':parent.id,
                                                                          'val':selected})
                            parent = parent.parent
                        benchmark.config.set(benchmark.id, "selected", selected)

                benchmark.config.set(benchmark_id, 'profile', active_profile)
                if recurse:
                    if (item.type == oscap.xccdf.XCCDF_GROUP) or (item.type == oscap.xccdf.XCCDF_BENCHMARK):
                        for sub in xccdf_get_items(benchmark, oscap.xccdf.XCCDF_ITEM, item.content):
                            benchmark.config.set(active_profile, sub.id, json.dumps(sel_dict))
                            self.log.debug("Setting %(id)s to %(val)s" % {'id':sub.id,
                                                                          'val':selected})

        try:
            fp = open(self.content_configs[benchmark_id], 'w')
            benchmark.config.write(fp)
            fp.close()
        except IOError, e:
            self.log.error("Error saving changes: %(err)s" % {'err':e})
            return False

        return True

    def save_profile(self, benchmark_id, profile_name):
        if not self.content.has_key(benchmark_id):
            self.log.error("No benchmark named '%(id)s' has been imported" % {'id':benchmark_id})
            return False

        benchmark = self.import_content(benchmark_id)
        if benchmark.get_item(profile_name) != None:
            self.log.error("An item with the name '%(name)s' already exists in the benchmark" % {'name':profile_name})
            return False

        # check if profile_name exists, and create if it doesn't
        if not benchmark.config.has_section(profile_name):
            benchmark.config.add_section(profile_name)

        # for each selection, set the config for the new
        # profile to have the same values as before
        for opt,val in benchmark.config.items(profile_name):
            benchmark.config.set(profile_name, opt, val)

        # any updates will be in the "Custom" section, so we
        # update the saved profile with those values, then remove
        # the Custom section because it is no longer necessary
        if benchmark.config.has_section("Custom"):
            for opt,val in benchmark.config.items("Custom"):
                benchmark.config.set(profile_name, opt, val)
            benchmark.config.remove_section("Custom")

        # set profile_name as the currently active profile for
        # the benchmark
        benchmark.config.set(benchmark_id, 'profile', profile_name)

        # write changes to disk
        try:
            fp = open(self.content_configs[benchmark_id], 'w')
            benchmark.config.write(fp)
            fp.close()
        except IOError, e:
            self.log.error("Error saving changes: %(err)s" % {'err':e})
            return False

        return True


    def audit(self, args, profile=None, verbose=False, all=False, results_dir=None, output_xml=True, output_html=False, rule=None):
        """
        Function:       Run an audit on the system agains the given definition model
        Input:          Interpreter to use, args for interpreter, schema to use, specific definition or template
        Output:         None
        Side Effects:   Results are printed to stdout and possibly xml or html results files
        """
        def_model = None
        benchmark = None
        res_benchmark = None

        if results_dir == None:
            unique_str = "audit-%(hostname)s-%(date)s" % {'hostname':os.uname()[1],
                                                          'date':time.strftime("%a-%B-%d-%H_%M_%S-%Y")}
            results_dir = tempfile.mkdtemp(prefix=unique_str, dir=os.getcwd())

        if args == []:
            args = self.content.keys()

        file_index = []
        if len(args) == 0:
            self.log.error("No content has been imported")
            return False

        for arg in args:
            scanned_content = self.import_content(arg)
            if scanned_content == None:
                self.log.error("Error importing content: %(bench)s" % {'bench':arg})
                return False

            else:
                if self.content.has_key(arg):
                    if not all and (not scanned_content.config.getboolean(arg, 'selected')):
                        print "Skipping %(id)s" % {'id':arg}
                        ret = True
                        continue

                # If auditing an XCCDF benchmark
                if scanned_content.__dict__.has_key('oval'):
                    if all or (rule != None):
                        if rule != None:
                            if scanned_content.get_item(rule) == None:
                                self.log.error("Benchmark '%(bench)s' does not contain rule '%(id)s'" % {'bench':scanned_content.id,
                                                                                                         'id':rule})
                                return False

                        tmp_prof = oscap.xccdf.profile_new()
                        tmp_prof.id = '__tmp__'
                        for item in scanned_content.selections.keys():
                            sel = oscap.xccdf.select_new()
                            sel.item = item
                            if all or (item == rule) or is_parent(scanned_content.get_item(item), scanned_content.get_item(rule)):
                                sel.selected = True
                            else:
                                sel.selected = False
                            tmp_prof.add_select(sel)

                        scanned_content.add_profile(tmp_prof)
                        profile = '__tmp__'

                    # Set profile to default found in scanned_content.config.file
                    if (profile == None) and (scanned_content.__dict__.has_key('config')):
                        if scanned_content.config.has_option(arg, 'profile'):
                            audit_profile = scanned_content.config.get(arg, 'profile')
                        else:
                            audit_profile = NONE_PROFILE
                    else:
                        audit_profile = NONE_PROFILE
                    
                    if profile!= None:
                        if scanned_content.get_member(oscap.xccdf.XCCDF_PROFILE, profile) == None:
                            self.log.error("Profile '%(prof)s' does not exist." % {'prof':profile})
                            return False
                        audit_profile = profile

                    try:
                        (res_benchmark, sessions) = evaluate_xccdf(scanned_content, scanned_content.id, s_profile=audit_profile, verbose=verbose)
                    except SecstateException, e:
                        self.log.error(str(e))

                # If auditing OVAL content                
                else:
                    if self.content.has_key(scanned_content.id):
                        oval_filename = self.content[scanned_content.id]
                    else:
                        oval_filename = scanned_content.id + ".xml"
                    sess = oscap.oval.agent_new_session(scanned_content, scanned_content.id)
                    sess.__dict__['filename'] = oval_filename
                    try:
                        (res_benchmark, sessions) = evaluate_oval(sess, verbose)
                    except SecstateException, e:
                        self.log.error(str(e))
                        res_benchmark, sessions = None, None

                if (res_benchmark == None) and (sessions == None):
                    self.log.error("Error auditing %(arg)s" % {'arg':arg})
                    return False

                xccdf_ss = self.config.get('secstate', 'xccdf_stylesheet')
                oval_ss = self.config.get('secstate', 'oval_stylesheet')
                if output_xml:
                    try:
                        export_xml(results_dir, scanned_content.id, res_benchmark, sessions)
                    except SecstateException, e:
                        self.log.error(str(e))
                        return False

                file_index.append(scanned_content.id)

        print "Generating HTML output..."

        if output_html and file_index:
            impl = xml.dom.minidom.getDOMImplementation()
            newdoc = impl.createDocument(None, "Index", None)
            top_element = newdoc.documentElement
            for output in file_index:
                file_node = newdoc.createElement('file')
                text = newdoc.createTextNode(output + ".results.xml")
                file_node.appendChild(text)
                top_element.appendChild(file_node)
                try:
                    result_to_html(os.path.join(results_dir, output + ".results.xml"), oval_ss, os.path.join(results_dir, output + ".results.html"))
                except Exception, e:
                    self.log.error(str(e))
                    return False

            media = self.config.get('secstate', 'stylesheet_media')
            about = self.config.get('secstate', 'about_html')
            help = self.config.get('secstate', 'help_html')
            try:
                result_to_html(newdoc.toxml(), oval_ss, os.path.join(results_dir, "index.html"), media, about, help)
            except Exception,e:
                self.log.error(str(e))
                return False

        return True

    def search(self, search_string, verbose=False, reverse=False):
        """
        Function:       Searches though all imported benchmarks for a string of text
        Input:          A benchmark id and a string to search for
        Output:         None
        Side Effects:   Prints out the results of the search
        """
        found_something = False
        search_results = ""
        for key in self.content:
            content = self.import_content(key)
            if content == None:
                self.log.error("Error importing content: %(key)s" % {'key':key})
                return False

            search_results += "In benchmark %(bench)s:\n" % {'bench':key}

            if reverse:
                if content.__dict__.has_key('oval'):
                    for def_model in content.oval.values():
                        defn = def_model.get_definition(search_string)
                        if defn == None:
                            continue
                        else:
                            found_something = True
                            rule_defs = rules_to_defs(content)
                            for k, v in rule_defs.iteritems():
                                if search_string in v:
                                    search_results += "OVAL Definition %(id)s is used by %(rule_id)s\n" % {'id':search_string, 'rule_id':k}
                            continue

            if content.__dict__.has_key('oval'):
                for item in xccdf_get_items(content, oscap.xccdf.XCCDF_ITEM, content.content):
                    title = None
                    description = None

                    if len(item.title) > 0:
                        title = item.title[0].text
                    
                    if len(item.description) > 0:
                        description = item.description[0].text

                    if (title != None) and (description != None):
                        if (search_string in title) or (search_string in description):
                            found_something = True
                            search_results += "\t%(id)s:\n" % {'id':item.id}
                            search_results += "\t\tTitle:  '%(title)s'\n" % {'title':title}
                            search_results += "\t\tDescription:  %(description)s\n\n" % {'description':description}

        if not found_something:
            return 1
        else:
            print search_results,

        return found_something

    def show(self, content_id=None, item_id=None, verbose=False):
        # check arguments
        if content_id is None:
            raise TypeError("Content ID must be provided.")
        
        # import content with provided ID
        content = self.import_content(content_id)
        if content is None:
            self.log.error("Error importing content: %s" % content_id)
            return False

        # no item_id? just print info about the content
        if item_id is None:
            # to_item() is a weird openscap function which
            # switches content into a different type, which
            # gives us access to stuff like item.title
            item = content.to_item()
        elif is_xccdf(content):
            # searches and retrieves the item from inside the xccdf
            # it might be a group, profile, or rule
            item = content.get_item(item_id)
        else:
            # can't find anything useful, give up
            if item_id is None:
                self.log.error("No item ID provided and content ID does not refer to an XCCDF benchmark.")
            else:
                self.log.error("Could not find item %s in benchmark %s" % (item_id, content_id))
            return False

        # maybe we're getting a profile, those don't show up in the XCCDF
        if item is None and len(content.profiles) > 0:
            for profile in content.profiles:
                if item_id == profile.id:
                    item = profile
                    break

        # We've tried everything, give up
        if item is None:
            self.log.error("Could not find item %s in benchmark %s" % (item_id, content_id))
            return False

        print "%s:" % item.id
        if len(item.title) > 0:
            print "\tTitle:  '%s'" % item.title[0].get_text()
        if len(item.description) > 0:
            print "\tDescription:  %s" % item.description[0].get_text()

        if type(item.selected) == str or type(item.selected) == bool:
            print "\tSelected:  %s" % item.selected
        elif item.id == get_active_profile(content, content_id):
            print "\tSelected:  True"
        elif item_id is None and content.config.getboolean(content_id, 'selected'):
            print "\tSelected:  True"
        else:
            print "\tSelected:  False"

        # if we have them, print a list of profiles in this content
        if len(content.profiles) > 0 and item.type == oscap.OSCAP.XCCDF_BENCHMARK:
            active_profile = get_active_profile(content, content_id)
            print "\tProfiles:"
            for profile in content.profiles:
                # If this is the active profile, mark the box
                if profile.id == active_profile:
                    selected = '[X]'
                else:
                    selected = '[ ]'
                # Get the title of this profile
                title = ""
                if len(profile.title) > 0:
                    title = " - '%(title)s'" % {'title':profile.title[0].text}
                # Print [X]ProfileID - Title (see manpage for examples)
                print "\t\t%(sel)s%(id)s%(title)s" % {'sel':selected, 'id':profile.id, 'title':title}
        
        # verbocity!
        if verbose:
            # groups and rules have parents, print it if we have one
            parent = item.parent
            if parent is not None:
                print "\tMember of %(parent)s" % {'parent':parent.id}

            # groups and benchmarks have children, print them if we have them
            if item.type in (oscap.xccdf.XCCDF_GROUP, oscap.xccdf.XCCDF_BENCHMARK):
                print "\tSub Elements:"
                for sub in item.content:
                    print "\t\t%s" % sub.id
            # rules reference OVAL definitions, print that info
            elif item.type == oscap.xccdf.XCCDF_RULE:
                rule = item.to_rule()
                print "\tReferenced Definitions:"
                for defn in xccdf_rule_get_defs(rule):
                    print "\t\t%s" % defn

        return True

    def sublist(self, content, arg, recurse, show_all, tabs=0):
        tabstr = "\t" * tabs
        selected = ""
        profile = ""
        profiles = []
        profile_name = None

        is_selected = False
        if not content.__dict__.has_key('oval'):
            if self.content.has_key(arg):
                if content.config.getboolean(arg, 'selected'):
                    is_selected = True
                    if show_all:
                        selected = "[X]"
                else:
                    selected = "[ ]"

                if is_selected or show_all:
                    print "%(indent)s%(sel)sOVAL File - ID: %(id)s" % {'indent':tabstr, 'sel':selected, 'id':arg}
            else:
                defn = content.get_definition(arg)
                if defn != None:
                    print "%(indent)sDefinition - ID: %(id)s, Title: '%(title)s'" % {'indent':tabstr, 'id':arg,
                                                                                     'title':defn.title}
        else:
            item = None
            if arg == content.id:
                item = content.to_item() # get groups and rules
                profiles = content.get_profiles() # get profiles
                is_selected = content.config.getboolean(arg, 'selected')
                profile_name = content.config.get(arg, 'profile')
                if profile_name != NONE_PROFILE:
                    profile_name = "'%s'" % profile_name
                profile = ", Profile: %s" % profile_name

            else:
                item = content.get_item(arg)

                if item == None:
                    item = content.get_member(oscap.xccdf.XCCDF_PROFILE, arg)

                    if item == None:
                        for oval_file,def_model in content.oval.items():
                            return self.sublist(def_model, arg, recurse, show_all, tabs)

                try:
                    is_selected = content.selections[item.id]
                except:
                    # profile
                    if profile_name == None:
                        # use the benchmark's ID to determine profile name
                        profile_name = content.config.get(content.id, 'profile')

                    if profile_name == item.id:
                        is_selected = 1

            for title in item.title:
                if show_all:
                    if is_selected:
                        selected = "[X]"
                    else:
                        selected = "[ ]"
                    
                if not is_selected:
                    if not recurse or (tabs == 0):
                        selected = "[ ]"

                print "%(indent)s%(sel)s%(type)s - ID: %(id)s, Title: '%(title)s'%(prof)s" % {'indent':tabstr, 'sel':selected,
                                                                                                  'type':item_get_type_str(item), 'id':arg,
                                                                                                  'title':title.text,
                                                                                                  'prof':profile}
            if recurse and (is_selected or show_all):
                item_type = item.type
                if (item_type == oscap.xccdf.XCCDF_GROUP) or (item_type == oscap.xccdf.XCCDF_BENCHMARK):
                    # add profiles
                    for prof in profiles:
                        self.sublist(content, prof.id, recurse, show_all, tabs+1)

                    for sub in item.content:
                        self.sublist(content, sub.id, recurse, show_all, tabs+1)

        return True

    def list_content(self, content_id=None, item_id=None, recurse=False, show_all=False):
        ret = False
        if self.content == {}:
            return True

        if content_id == None:
            for key in self.content:
                content = self.import_content(key)
                if content == None:
                    self.log.error("Error loading benchmark: %(id)s" % {'id':key})
                    return False

                ret = self.sublist(content, key, recurse, show_all)
        elif item_id == None:
            content = self.import_content(content_id)
            if content == None:
                self.log.error("Error loading benchmark: %(id)s" % {'id':content_id})
                return False

            ret = self.sublist(content, content_id, recurse, show_all)
        else:
            content = self.import_content(content_id)
            if content == None:
                self.log.error("Error loading benchmark: %(id)s" % {'id':content_id})
                return False

            if not content.get_item(item_id):
                if not content.get_member(oscap.xccdf.XCCDF_PROFILE, item_id):
                    self.log.error("Could not find [group][rule][profile]: %(id)s" % {'id':item_id})
                    return False

            ret = self.sublist(content, item_id, recurse, show_all)

        return ret

    def get_passed_result_ids(self, xccdf_results, original_benchmarks):
        if original_benchmarks == None:
            self.log.error("Error importing original benchmark")
            return (None, None)

        if xccdf_results == None:
            return ([], set())

        result_files = []
        if os.path.isdir(xccdf_results):
            for res_file in os.listdir(xccdf_results):
                if res_file.endswith(".results.xml") and is_valid_xccdf_file(os.path.join(xccdf_results, res_file)):
                    result_files.append(os.path.join(xccdf_results, res_file))

        elif os.path.isfile(xccdf_results) and is_valid_xccdf_file(xccdf_results):
            result_files.append(xccdf_results)

        else:
            self.log.error("Not a valid xccdf result file: %s" % xccdf_results)
            return (None, None)
       
        result_ids = []
        for result in result_files:
            benchmark = oscap.xccdf.benchmark_import(result)
            
            if benchmark == None:
                self.log.error("Error importing benchmark %(file)s" % {'file':result})
                return None, None

            if not original_benchmarks.has_key(benchmark.id):
                self.log.info("Results file '%(file)s' does not match any remediation content, skipping" % {'file':result})
                continue

            result_ids.append(benchmark.id)
            passing_ids = set()
            for test_result in benchmark.results:
                for rule_result in test_result.rule_results:
                    id = rule_result.idref
                    result = rule_result.result
                    if result != oscap.xccdf.XCCDF_RESULT_FAIL or not original_benchmarks[benchmark.id].selections[id]:
                        passing_ids.add(id)
                    
        return (result_ids, passing_ids)

    def run_remediation(self, args, xccdf_results=None, log_dest=None, noop=False, verbose=False, yes_all=False):
        if args == []:
            args = self.content.keys()

        benchmarks = {}
        for arg in args:
            benchmark = self.import_content(arg)
            if benchmark == None:
                self.log.error("Error importing content: %s" % arg)
                return False
            if not benchmark.config.getboolean(arg, 'selected'):
                self.log.info("Skipping %(id)s" % {'id':arg})
                continue
            if not benchmark.__dict__.has_key('oval'):
                # OVAL Definition Model, so skip
                self.log.info("Skipping OVAL File: '%(file)s'" % {'file':arg})
                continue
            benchmarks[benchmark.id] = benchmark

        (result_ids, passing_ids) = self.get_passed_result_ids(xccdf_results, benchmarks)
        if result_ids == None or passing_ids == None:
            return False

        for bench_id,benchmark in benchmarks.items():
            if bench_id not in result_ids and not yes_all:
                inpt = raw_input("No results file provided for %s, remediate anyway? " % bench_id)
                if inpt != 'y':
                    continue

            self.log.info("-- Remediating %(id)s --" % {'id':bench_id})
            ignore_ids = []
            try:
                for key in benchmark.selections:
                    if benchmark.selections[key] == False or not ancestors_selected(benchmark, key):
                        ignore_ids.append(key)
                ignore_ids += passing_ids
                ignore_ids += benchmark.mitigations.keys()
                bash_content = parse_fixes(benchmark, ignore_ids)
            except SecstateException, se:
                self.log.error('Error: %s' % str(se))
                return False

            # Checking if there is automated content to run
            if bash_content == []:
                self.log.warning("No remediation to be done.")
                if verbose:
                    self.log.info("Either results XCCDF did not report any failures, or failures reported did not have a well formed <fix> element in the corresponding XCCDF benchmark.")
                continue

            # Running bash automated content
            for fix in bash_content:
                script_path = fix['script']

                env_vars = fix['environment-variables']
                environ = {}
                try:
                    for name, val in env_vars.iteritems():
                        environ[str(name)] = str(val)
                except:
                    self.log.error("Failed to set up environment for script: %(script)s" % {'script':script_path})
                    return False
                
                positional_args = fix['positional-args']
                positional_args = [str(a) for a in positional_args]

                if os.path.exists(script_path):
                    if verbose:
                        self.log.info("Running bash remediation script: %s" % script_path)
                    cmd = ["/bin/bash", script_path] + positional_args
                    try:
                        # Runs the remediation script with all the environment variables
                        # and positional args from a <fix> tag in the XCCDF content
                        proc = subprocess.Popen(cmd, env=environ, shell=False, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

                        # Check that the remediation script takes less than timeout seconds to terminate
                        timeout = int(self.config.get('secstate', 'remediation_timeout'))
                        finished = wait_timeout(proc, timeout)
                        if not finished and proc.poll() is None:
                            proc.kill()
                            raise Exception("timeout after %d seconds" % timeout)

                        # We pipe stdout and stderr into the same string, to keep the ordering
                        out = proc.communicate()[0]

                        rc = proc.returncode

                        # Log format lists script_path, command executed (incl. positional args),
                        # returncode, and stdout+stderr.
                        logs = "#"*20 + script_path + "#"*20 + "\n"
                        logs += "Executed \"%s\"\n" % (" ".join(cmd))
                        logs += "Environment: %s\n" % str(environ)
                        logs += "Returned: %d\n" % rc
                        logs += "-"*18 + " Output: " + "-"*18 + "\n"
                        logs += out
                        logs += "#"*20 + "end " + script_path + "#"*16 + "\n\n"

                        # log_dest set with -l flag, append log string to file
                        if log_dest:
                            save_logs(log_dest, logs)

                        # Only print on successful run (rc==0) if verbose is enabled
                        if rc != 0:
                            self.log.error(logs)
                        elif verbose:
                            print logs
                    except Exception, e:
                        self.log.error("Failed to execute remediation script: '%(cmd)s' failed: %(err)s" % {'cmd': " ".join(cmd), 'err': str(e)})
                else:
                    self.log.error("Script: %s does not exist\t\n" % script_path)
                    return False

        return True

    def mitigate(self, content_id, item_id, remark, authority=None):
        if not self.content.has_key(content_id):
            self.log.error("No content '%(id)s' has been imported" % {'id':content_id})
            return False

        benchmark = self.import_content(content_id)
        if not benchmark.__dict__.has_key('oval'):
            self.log.error("Cannot mitigate OVAL content")
            return False

        item = benchmark.get_item(item_id)
        if item == None:
            self.log.error("%(bench)s does not contain item %(item)s" % {'bench':benchmark_id, 'item':item_id})
            return False

        if not benchmark.config.has_section('mitigations'):
            benchmark.config.add_section('mitigations')
 
        mitg_dict = {'remark':remark, 'authority':authority}
        benchmark.config.set('mitigations', item_id, json.dumps(mitg_dict))

        try:
            fp = open(self.content_configs[content_id], 'w')
            benchmark.config.write(fp)
            fp.close()
        except IOError, e:
            self.log.error("Error saving changes: %(err)s" % {'err':e})
            return False

        return True

