from distutils.core import setup
import glob

setup(name='pungi',
      version='2.13',
      description='Distribution compose tool',
      author='Dennis Gilmore',
      author_email='dgilmore@fedoraproject.org',
      url='http://fedorahosted.org/pungi',
      license='GPLv2',
      package_dir = {'': 'src'}, 
      packages = ['pypungi'],
      scripts = ['src/bin/pungi.py'],
      data_files=[('/usr/share/pungi', glob.glob('share/*'))]
      )

