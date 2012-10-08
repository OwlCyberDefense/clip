#!/usr/bin/env python

import subprocess
import sys

def main():
    command = ["./harness/run_tests.py", "--chroot", "chroot"]

    if len(sys.argv) > 1:
        for test in sys.argv[1::]:
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
            sys.exit(-1
)
    subprocess.call(command)

if __name__ == "__main__":
   main()
