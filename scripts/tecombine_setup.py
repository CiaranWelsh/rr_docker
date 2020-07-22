from setuptools import setup, Distribution

class BinaryDistribution(Distribution):
    """Distribution which always forces a binary package with platform name"""
    def has_ext_modules(foo):
        return True

setup(name='tecombine',
      version='0.2.3.0',
      description='A library for working with COMBINE archives',
      classifiers=[
          'Intended Audience :: Science/Research',
          'Operating System :: MacOS :: MacOS X',
          'Operating System :: Microsoft :: Windows',
          'Operating System :: POSIX',
          'Programming Language :: C++',
          ],
      author='Frank Bergmann, Kyle Medley (packaging)',
      url='https://github.com/sbmlteam/libCombine',
      packages=['tecombine'],
      package_dir={'tecombine': 'libcombine'},
      package_data={'tecombine': ['*.so*','*.dylib*','*.pyd','lib*','*.dll']},
      distclass=BinaryDistribution,
)
