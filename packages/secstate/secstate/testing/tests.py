#!/usr/bin/env python

import subprocess
import sys
from optparse import OptionParser

def main():
    parser = OptionParser(usage="%prog [options] <test1 test2...>")
    parser.add_option("-x", "--fix", dest="fixtests", action="store_true", default=False)
    (options, args) = parser.parse_args()

    command = ["./harness/run_tests.py", "--chroot", "chroot"]

    if options.fixtests:
        command.append("--fix")

    if len(args) > 0:
        for test in args:
            command.append("tests/%s" % test.strip())
    else:
        try:
            testfile = open("active-tests.list", 'r')
            tests = testfile.readlines()
            testfile.close()

            if tests == None:
                print "There are no tests in active-tests.list"
                return

            for test in tests:
                command.append("tests/%s" % test.strip())

        except Exception, e:
            testfile.close()
            print e
            sys.exit(-1)
    subprocess.call(command)

if __name__ == "__main__":
   main()
