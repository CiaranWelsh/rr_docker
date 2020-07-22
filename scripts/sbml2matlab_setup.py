from setuptools import setup, Distribution

class BinaryDistribution(Distribution):
    """Distribution which always forces a binary package with platform name"""
    def has_ext_modules(foo):
        return True

setup(name='sbml2matlab',
      version='0.9.1',
      description='An SBML to MATLAB translator',
      author='Stanley Gu, Lucian Smith',
      url='https://github.com/stanleygu/sbml2matlab',
      packages=['sbml2matlab'],
      package_dir={
          'sbml2matlab': 'lib'
      },
      package_data={
          "sbml2matlab": ["_sbml2matlab.pyd", "*.dll", "*.txt",
                          "*.lib", "*.so*", "*.dylib*"]
      },
      distclass=BinaryDistribution,
)

