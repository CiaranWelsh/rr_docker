#! /usr/bin/env python

from setuptools import setup, Distribution
import os

PY3_MINOR_VERSION = os.environ['PY3_MINOR_VERSION']
assert len(PY3_MINOR_VERSION) != 0


class BinaryDistribution(Distribution):
    """Distribution which always forces a binary package with platform name"""
    def has_ext_modules(foo):
        return True

setup(name='tenuml',
      version='1.1.1.4',
      description='Library for reading/writing data in COMBINE archives',
      classifiers=[
          'Intended Audience :: Science/Research',
          'Operating System :: MacOS :: MacOS X',
          'Operating System :: Microsoft :: Windows',
          'Operating System :: POSIX',
          'Programming Language :: C++',
          ],
      author='Frank Bergmann, Kyle Medley (packaging)',
      url='https://github.com/NuML/NuML',
      packages=['tenuml'],
      package_dir= {'tenuml': 'lib/python3.{}/site-packages/libnuml'.format(PY3_MINOR_VERSION)},
      package_data={'tenuml': ['*.so*','*.dylib*','*.pyd','lib*','*.dll']},
      distclass=BinaryDistribution,
)

