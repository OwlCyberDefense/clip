rpm: 
	rm -rf aqueduct-ssg-bash rpmbuild
	mkdir -p rpmbuild/{SOURCES,SPECS}
	mkdir -m 775 aqueduct-ssg-bash
	install -m 775 *.sh set_sysctl_common set_pam_common audit_rules_common modprobe_common user_umask_common set_avahi_common aqueduct-ssg-bash
	tar czf rpmbuild/SOURCES/aqueduct-ssg-bash.tgz aqueduct-ssg-bash
	env HOME=`pwd` rpmbuild -bb aqueduct-ssg-bash.spec
	cp rpmbuild/RPMS/noarch/a* .
	rm -rf aqueduct-ssg-bash rpmbuild

clean:
	rm -rf aqueduct-ssg-bash rpmbuild aqueduct-ssg-bash*rpm
