# Author: Matt Keeler <mkeeler@tresys.com>
#
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
#  File: util.py
#  This file contains utility functions for the secstate module.

import os
import sys
import shutil
import xml.dom.minidom
import time
import re
import ConfigParser
import simplejson as json
import zipfile
import libxml2
import libxslt

import openscap_api as oscap

class SecstateException(Exception):
    def __init__(self, reason):
        self.reason = reason
    def __str__(self):
        return str(self.reason)

def load_config(conf_file):
    config = ConfigParser.ConfigParser()
    config.optionxform = str
    try:
        fp = open(conf_file)
        config.readfp(fp)
        fp.close()
    except IOError, e:
        raise SecstateException("Error opening config file: %(file)s" % {'file':conf_file})

    return config

def wait_timeout(proc, seconds):
    """
    Waits the specified amount of time for proc to terminate and return True
    If proc does not terminate within the specified time, return False
    Note: this function WILL NOT kill or terminate proc for you, that is the caller's job
    """
    start = time.time()
    while proc.poll() is None and time.time() - start < seconds:
        time.sleep(0.5)
    if proc.poll() is None:
        return False
    else:
        return True

def xccdf_reporter(msg, usr):
    result = msg.result
    if result == oscap.xccdf.XCCDF_RESULT_PASS:
        usr['pass'] += 1
    elif msg.user1str in usr['mitigations']:
        usr['mitg_total'] += 1
    elif result == oscap.xccdf.XCCDF_RESULT_FAIL:
        usr['fail'] += 1
    elif result == oscap.xccdf.XCCDF_RESULT_UNKNOWN:
        usr['unknown'] += 1
    elif result == oscap.xccdf.XCCDF_RESULT_NOT_APPLICABLE:
        usr['na'] += 1
    elif result == oscap.xccdf.XCCDF_RESULT_NOT_CHECKED:
        usr['ncheck'] += 1
    elif result == oscap.xccdf.XCCDF_RESULT_NOT_SELECTED:
        usr['nselect'] += 1
    elif result == oscap.xccdf.XCCDF_RESULT_INFORMATIONAL:
        usr['info'] += 1
    elif result == oscap.xccdf.XCCDF_RESULT_FIXED:
        usr['fixed'] += 1
    elif result == oscap.xccdf.XCCDF_RESULT_ERROR:
        usr['err'] += 1
    else:
        usr['parse_err'] += 1

    if usr['verbose']:
        print "Rule '%(id)s' result: %(res)s" % {'id':msg.idref,
                                                 'res':oscap.xccdf.test_result_type_get_text(result)}
    return 0

def evaluate_xccdf(benchmark, url_XCCDF, s_profile=None, all=False, verbose=False):
    policy = None
    policy_model = oscap.xccdf.policy_model_new(benchmark)

    if (s_profile != None):
        policy = policy_model.get_policy_by_id(s_profile)
    else:
        policies = policy_model.policies
        if len(policies) > 0:
            policy = policies[0]

    if policy == None:
        raise SecstateException("No policy to evaluate.\n")

    res_dict = {'pass':0,
                'fail':0,
                'err':0,
                'unknown':0,
                'na':0,
                'ncheck':0,
                'nselect':0,
                'info':0,
                'fixed':0,
                'mitg_total':0,
                'parse_err':0,
                'verbose':verbose,
                'mitigations':benchmark.mitigations.keys()}

    policy_model.register_output_callback(xccdf_reporter, res_dict)

    sessions = []
    for oval_file,def_model in benchmark.oval.items():
        tmp_sess = oscap.oval.agent.new_session(def_model, oval_file)
        tmp_sess.__dict__['filename'] = oval_file
        policy_model.register_engine_oval(tmp_sess)
        sessions.append(tmp_sess)

    ritem = policy.evaluate()
    ritem.benchmark_uri = url_XCCDF
    title = oscap.common.text_new()
    title.text = "Secstate Audit Result"
    ritem.add_title(title)
    ritem.start_time = time.time()
    if policy != None:
        if policy.profile != None:
            ritem.set_profile(policy.profile.id)

    for sess in sessions:
        oscap.oval.agent_export_sysinfo_to_xccdf_result(sess, ritem)

    for model in benchmark.models:
        score = policy.get_score(ritem, model.system)
        ritem.add_score(score)

    for rule_res in ritem.rule_results:
        id = rule_res.idref
        if benchmark.mitigations.has_key(id):
            override = oscap.xccdf.override_new()
            override.new_result = oscap.xccdf.XCCDF_RESULT_INFORMATIONAL
            override.old_result = rule_res.result
            remark = oscap.common.text_new()
            remark.text = str(benchmark.mitigations[id]['remark'])
            override.remark = remark
            authority = benchmark.mitigations[id]['authority']

            if authority != None:
                override.authority = authority
            rule_res.add_override(override)
            rule_res.result = override.new_result

    ritem.end_time = time.time()

    # Print results in beautiful manner, using ljust instead of tabs
    left_col = ["Passed:",
                "Mitigated:",
                "Failed:",
                "Fixed:",
                "Not Selected:",
                "Not Checked:",
                "Not Applicable:",
                "Error:",
                "Informational:",
                "Unknown:",
                "Parse Error:",]
    right_col = ['pass',
                 'mitg_total',
                 'fail',
                 'fixed',
                 'nselect',
                 'ncheck',
                 'na',
                 'err',
                 'info',
                 'unknown',
                 'parse_err',]

    print "--Results for '%(id)s' (Profile: '%(prof)s')--" % {'id':benchmark.id, 'prof':s_profile}
    for l, r in zip(left_col, right_col):
        print(l.ljust(16) + str(res_dict[r]))

    totalrules = sum(i for i in res_dict.values() if type(i) is int)
    print("Total:".ljust(16) + str(totalrules))
    print
    results_benchmark = benchmark.clone()
    results_benchmark.add_result(oscap.xccdf.result_clone(ritem))

    return (results_benchmark, sessions)

def oval_reporter(msg, usr):
    result = msg.user2num
    if result == oscap.oval.OVAL_RESULT_TRUE:
        usr['true'] += 1
    elif result == oscap.oval.OVAL_RESULT_FALSE:
        usr['false'] += 1
    elif result == oscap.oval.OVAL_RESULT_ERROR:
        usr['err'] += 1
    elif result == oscap.oval.OVAL_RESULT_UNKNOWN:
        usr['unknown'] += 1
    elif result == oscap.oval.OVAL_RESULT_NOT_EVALUATED:
        usr['neval'] += 1
    elif result == oscap.oval.OVAL_RESULT_NOT_APPLICABLE:
        usr['na'] += 1

    if usr['verbose']:
        print "Definintion '%(id)s' result: %(res)s" % {'id':msg.user1str,
                                                        'res':oscap.oval.result_get_text(result)}

    return 0

def evaluate_oval(sess, verbose=True):
    usr = {'false':0,
           'true':0,
           'err':0,
           'unknown':0,
           'neval':0,
           'na':0,
           'verbose':verbose}

    ret = oscap.oval.agent_eval_system(sess, oval_reporter, usr)

    if verbose:
        print "Evaluation Completed"

    if ret == -1:
        if oscap.common.err():
            raise SecstateException("Error: (%(code)d) %(desc)s" % {'code':oscap.common.err_code(),
                                                             'desc':oscap.common.err_desc()})
        return None

    # Print results in beautiful manner
    left_col = ["True:",
                "False:",
                "Error:",
                "Unknown:",
                "Not Evaluated:",
                "Not Applicable:"]
    right_col = ['true',
                 'false',
                 'err',
                 'unknown',
                 'neval',
                 'na']
    print("--Results--")
    for l, r in zip(left_col, right_col):
        print(l.ljust(16) + str(usr[r]))
    print

    return (None, [sess])

def export_xml(results_dir, id, benchmark=None, sessions=None):
    unique = "audit-%(hostname)s-%(date)s" % {'hostname':os.uname()[1],
                                              'date':time.strftime("%a-%B-%d-%H_%M_%S-%Y")}
    if results_dir == None:
        results_dir = unique

    if not os.path.isdir(results_dir):
        try:
            os.makedirs(results_dir)
        except IOError, e:
            raise SecstateException("Could not create benchmark directory: %(dir)s" % {'dir':results_dir})

    if benchmark != None:
        xccdf_xml = os.path.join(results_dir, id + ".results.xml")
        benchmark.export(xccdf_xml)

    if sessions != None:
        for sess in sessions:
            res_model = oscap.oval.agent.get_results_model(sess)

            id = os.path.splitext(os.path.basename(sess.filename))[0]

            oval_xml = os.path.join(results_dir, id + ".results.xml")
            oscap.oval.results.model.export(res_model.instance, None, oval_xml)
    
    return True

def result_to_html(input, stylesheet, output, media=None, about=None, help=None):
    output_dir = os.path.dirname(output)
    transform_params = {'path': output_dir}
    try:
        shutil.copy(stylesheet, output_dir)
    except IOError,e:
        raise SecstateException("Error copying stylesheet: %(err)s" % {'err':e})

    stylesheet = os.path.join(output_dir, os.path.basename(stylesheet))
    styledoc = libxml2.parseFile(stylesheet)
    style = libxslt.parseStylesheetDoc(styledoc)
    if os.path.isfile(input):
        doc = libxml2.parseFile(input)
        if not is_valid_xccdf_file(input):
            transform_params['ovalid'] = "'%s'" % os.path.basename(input.split('.results.xml')[0])
    else:
        doc = libxml2.parseDoc(input)

    if doc == None:
        raise SecstateException("Error parsing input: '%(in)s'" % {'in':input})

    result = style.applyStylesheet(doc, transform_params)
    if not style.saveResultToFilename(output, result, 0):
        raise SecstateException("Error exportng results to %(file)s" % {'file':output})

    if media:
        try:
            if os.path.exists(os.path.join(output_dir, os.path.basename(media))):
                shutil.rmtree(os.path.join(output_dir, os.path.basename(media)))
            shutil.copytree(media, os.path.join(output_dir, os.path.basename(media)))
        except IOError,e:
            raise SecstateException("Error copying media: %(err)s" % {'err':e})

    if about or help:
        try:
            if about:
                shutil.copy(about, os.path.join(output_dir, os.path.basename(about)))
            if help:
                shutil.copy(help, os.path.join(output_dir, os.path.basename(help)))
        except IOError,e:
            raise SecstateException("Error copying html: %(err)s" % {'err':e})

    style.freeStylesheet()
    doc.freeDoc()
    result.freeDoc()
    try:
        os.remove(stylesheet)
    except IOError,e:
        raise SecstateException("Error removing stylsheet: %(err)s" % {'err':e})

    return True

def oscap_validate(filename, doc_type):
    """
    Validates an XML file against the openscap-provided schemas, using the openscap library.
    doc_type should be one of oscap.OSCAP.OSCAP_DOCUMENT_XCCDF or oscap.OSCAP.OSCAP_DOCUMENT_OVAL_DEFINITIONS,
    but there are other possibilities, which Secstate doesn't use.
    """
    try:
        version = None
        # detect OVAL version
        if doc_type == oscap.OSCAP.OSCAP_DOCUMENT_OVAL_DEFINITIONS:
            version = oscap.OSCAP.oval_determine_document_schema_version(filename, doc_type)

        # detect XCCDF version
        if version is None:
            version = oscap.OSCAP.xccdf_detect_version(filename)

        # no version detected, die
        if version is None:
            return False

        is_valid = oscap.OSCAP.oscap_validate_document(filename, doc_type, version, None, None)
        # openscap is originally written in C, so they use 0 to mean success
        if (0 == is_valid):
            return True
    except Exception, e:
        raise SecstateException("Error parsing '%(file)s': %(err)s" % {'file':filename, 'err':e})
    return False


def is_valid_xccdf_file(filename):
    return oscap_validate(filename, oscap.OSCAP.OSCAP_DOCUMENT_XCCDF)

def is_valid_oval_file(filename):
    return oscap_validate(filename, oscap.OSCAP.OSCAP_DOCUMENT_OVAL_DEFINITIONS)

def is_xccdf(obj):
    """
    This is currently the best way of telling if an object is an openscap XCCDF benchmark object.
    """
    try:
        return obj.object == "xccdf_benchmark"
    except:
        return False

def is_oval(obj):
    """
    This is currently the best way of telling if an object is an openscap OVAL definition object.
    """
    try:
        return obj.object == "oval_definition_model"
    except:
        return False

def get_active_profile(content, key):
    """
    Gets the active profile for the given key in the content's config object, or NONE_PROFILE
    """
    try:
        if content.config.has_option(key, 'profile'):
            return content.config.get(key, 'profile')
        else:
            return 'None'
    except:
        return 'None'
         

def get_benchmark_id(benchmark):
    tree = xml.dom.minidom.parse(benchmark)
    return tree.getElementsByTagName("Benchmark")[0].getAttribute("id").encode('utf_8')

def xccdf_get_items(template, file_type, items=None):
    """
    Function:       Get all items of 'file_type' from an XCCDF document
    Input:          xccdf_benchmark, xccdf_type_t, xccdf_item_iterator
    Output:         A list of all items of "type" specified in the template
    """
    result = []

    if items == None:
        result.extend(xccdf_get_items(template, file_type, template.content))

    else:
        for item in items:
            if file_type == oscap.xccdf.XCCDF_BENCHMARK:
                if item.type == oscap.xccdf.XCCDF_BENCHMARK:
                    result.append(item.to_benchmark())

            elif file_type == oscap.xccdf.XCCDF_PROFILE:
                if item.type == oscap.xccdf.XCCDF_PROFILE:
                    pass

            # Rule is the base element where we can get checks and definition id's
            elif file_type == oscap.xccdf.XCCDF_RULE:
                if item.type == oscap.xccdf.XCCDF_RULE:
                    result.append(item.to_rule())
                    
                elif (item.type == oscap.xccdf.XCCDF_BENCHMARK) or (item.type == oscap.xccdf.XCCDF_GROUP):
                    result.extend(xccdf_get_items(template, file_type, item.content))

            elif file_type == oscap.xccdf.XCCDF_GROUP:
                if item.type == oscap.xccdf.XCCDF_GROUP:
                    result.append(item.to_group())
                    result.extend(xccdf_get_items(template, file_type, item.content))
                elif item.type == oscap.xccdf.XCCDF_BENCHMARK:
                    result.extend(xccdf_get_items(template, file_type, item.content))

            if file_type == oscap.xccdf.XCCDF_CONTENT:
                result.extend(xccdf_get_items(template, file_type, item))

            if file_type == oscap.xccdf.XCCDF_ITEM:
                if (item.type == oscap.xccdf.XCCDF_GROUP) or (item.type == oscap.xccdf.XCCDF_BENCHMARK):
                    result.append(item)
                    result.extend(xccdf_get_items(template, file_type, item.content))
                else:
                    result.append(item)

    return result

def xccdf_get_values(benchmark):
    result = []
    result.extend(benchmark.values)
    for group in xccdf_get_items(benchmark, oscap.xccdf.XCCDF_GROUP, benchmark.content):
        result.extend(group.values)

    return result

def xccdf_get_refs(benchmark):
    """
    Function:   Get all referenced OVAL files from an XCCDF document
    Input:      xccdf_benchmark
    Output:     Returns a list of flies referenced in an XCCDF benchmark
    """
    refs = []
    rules = xccdf_get_items(benchmark, oscap.xccdf.XCCDF_RULE)
    for rule in rules:
        for check in rule.checks:
            for ref in check.content_refs:
                refs.append(ref.href)
    return refs

def xccdf_rule_get_defs(rule):
    defs = []
    for check in rule.checks:
        for ref in check.content_refs:
            defs.append(ref.name)

    return defs

def rules_to_defs(benchmark):
    res_defs = {}
    rules = xccdf_get_items(benchmark, oscap.xccdf.XCCDF_RULE)
    for rule in rules:
        res_defs[rule.id] = xccdf_rule_get_defs(rule)

    return res_defs

def apply_changes_profile(benchmark):
    for section in benchmark.config.sections():
        if section != benchmark.id:
            prof = oscap.xccdf.profile_new()
            if benchmark.config.has_option(section, 'extends'):
                original_prof = benchmark.get_member(oscap.xccdf.XCCDF_PROFILE, benchmark.config.get(section, 'extends')).to_profile()
                if len(original_prof.title) > 0:
                    new_title = oscap.common.text_new()
                    new_title.text = "-- Customized --" + original_prof.title[0].text
                    prof.add_title(new_title)
                prof.extends = benchmark.config.get(section, 'extends')
            else:
                new_title = oscap.common.text_new()
                new_title.text = "Customized profile from secstate"
                prof.add_title(new_title)
            prof.id = section

            if section != 'mitigations':
                for id,val in benchmark.config.items(section):
                    if id != 'extends':
                        sel_dict = json.loads(val)
                        select = oscap.xccdf.select_new()
                        select.item = id
                        select.selected = sel_dict['selected']
                        prof.add_select(select)

            benchmark.add_profile(prof)

    return benchmark

def get_profile_selections(benchmark, profile):
    selections = {}
    if profile.extends != None:
        selections.update(get_profile_selections(benchmark, benchmark.get_member(oscap.xccdf.XCCDF_PROFILE, profile.extends).to_profile()))

    for sel in profile.selects:
        selections[sel.item] = sel.selected

    return selections


def xccdf_get_fixes(benchmark, ignore_ids=[]):
    """
    Function:   Get all fixes for rules in the XCCDF document
    Input:      xccdf_benchmark
    Output:     Returns a list of fixes for all rules in the XCCDF benchmark
    """

    rules = xccdf_get_items(benchmark, oscap.xccdf.XCCDF_RULE)
    fixes = []
    for rule in rules:
        if rule.id not in ignore_ids:
            fixes.extend(rule.fixes)
    return fixes

def item_get_type_str(item):
    item_type = item.type
    if item_type == oscap.xccdf.XCCDF_BENCHMARK:
        return "Benchmark"
    elif item_type == oscap.xccdf.XCCDF_GROUP:
        return "Group"
    elif item_type == oscap.xccdf.XCCDF_RULE:
        return "Rule"
    elif item_type == oscap.xccdf.XCCDF_PROFILE:
        return "Profile"
    elif item_type == oscap.xccdf.XCCDF_RESULT:
        return "TestResult"
    elif item_type == oscap.xccdf.XCCDF_VALUE:
        return "Value"
    else:
        return "Item"

def value_instance_to_value(val_instance):
    if val_instance.type == oscap.xccdf.XCCDF_TYPE_NUMBER:
        numeric_value = val_instance.value_number
        # turn float into int if they are equal to remove unnecessary decimal component
        if numeric_value == int(numeric_value):
            numeric_value = int(numeric_value)
        return str(numeric_value)
    elif val_instance.type == oscap.xccdf.XCCDF_TYPE_STRING:
        return val_instance.value_string
    elif val_instance.type == oscap.xccdf.XCCDF_TYPE_BOOLEAN:
        return str(val_instance.value_boolean).lower()

def is_parent(parent, item):
    item_parent = item.parent
    while item_parent != None:
        if parent.id == item_parent.id:
            return True
        item_parent = item_parent.parent

    return False

def parse_fixes(benchmark, ignore_ids=[]):
    fixes = xccdf_get_fixes(benchmark, ignore_ids)
    all_bash = []
    for fix in fixes:
        content = dereference_sub_elements(fix, benchmark)
        if fix.system == 'urn:xccdf:fix:script:bash':
            # Tag contents should be valid JSON describing a dictionary that looks like bash_fix
            bash_fix = {'script' : "", 'environment-variables' : {}, 'positional-args' : []}
            try:
                loaded = json.loads(str(content))
            except:
                raise SecstateException('Invalid JSON: "%s"' % content)

            if type(loaded) != dict:
                raise SecstateException('Non-dictionary JSON in bash remediation <fix> tag:\n%s' % content)

            # Load script path
            if 'script' in loaded:
                script = loaded['script']
                if type(script) not in [str, int, float, long, bool]:
                    raise SecstateException('Script name given as %(type)s in bash remediation <fix> tag:\n%(content)s'
                                                                % {'type':str(type(script)), 'content':content})
                bash_fix['script'] = str(script)
            else:
                raise SecstateException("No script name given in bash remediation <fix> tag:\n%s" % content)

            # Load environment variables dict
            if 'environment-variables' in loaded:
                env_var = loaded['environment-variables']
                if type(env_var) != dict:
                    raise SecstateException('Non-dictionary environment-variables in bash remediation <fix> tag:\n%s' % str(env_var))
                else: 
                    bash_fix['environment-variables'] = env_var

            # Load positional arguments list
            if 'positional-args' in loaded:
                pos_arg = loaded['positional-args']
                if type(pos_arg) != list:
                    raise SecstateException('Non-list positional-args in bash remediation <fix> tag:\n%s' % str(pos_arg))
                    continue
                else:
                    bash_fix['positional-args'] = pos_arg
            
            # add bash_fix to list of bash fixes
            all_bash.append(bash_fix)

    return all_bash

def dereference_sub_elements(fix, benchmark):
   sub_element_re = r'<sub\s+.*idref="(.*?)"\s*/\s*>'
   replacement_re = r'<sub\s+.*idref="%s"\s*/\s*>'
   
   content = fix.content
   ids = [m.group(1) for m in re.finditer(sub_element_re, content)]
   for id in ids:
      #lookup the actual value the id points too
      value = benchmark.vals[id]
      content = re.sub(replacement_re % id, re.escape(value), content)
   return content
  
def ancestors_selected(benchmark, id):
    item = benchmark.get_item(id)
    node = item
    while node != None:
        if benchmark.selections.has_key(node.id) and benchmark.selections[node.id] == False or not benchmark.selections.has_key(node.id) and node.selected == False:
            return False
        node = node.parent
    return True

def save_logs(filename, content):
    f = open(filename, "a")
    f.write(content)
    f.flush()
    f.close()
