## @file    setup.py
## @brief   Python distutils code for libsedml Python module
## @author  Michael Hucka
## @author  Ben Bornstein
## @author  Ben Kovitz
## @author  Frank Bergmann (fbergman@caltech.edu)
## @author  J Kyle Medley
##
##<!---------------------------------------------------------------------------
## This file is part of libsedml.  Please visit http://sbml.org for more
## information about SBML, and the latest version of libsedml.
##
## Copyright (C) 2013-2016 jointly by the following organizations:
##     1. California Institute of Technology, Pasadena, CA, USA
##     2. EMBL European Bioinformatics Institute (EMBL-EBI), Hinxton, UK
##     3. University of Heidelberg, Heidelberg, Germany
##
## Copyright 2005-2010 California Institute of Technology.
## Copyright 2002-2005 California Institute of Technology and
##                     Japan Science and Technology Corporation.
##
## This library is free software; you can redistribute it and/or modify it
## under the terms of the GNU Lesser General Public License as published by
## the Free Software Foundation.  A copy of the license agreement is provided
## in the file named "LICENSE.txt" included with this software distribution
## and also available online as http://sbml.org/software/libsedml/license.html
##----------------------------------------------------------------------- -->*/

from setuptools import setup, Distribution

import os
PY3_MINOR_VERSION = os.environ['PY3_MINOR_VERSION']
assert len(PY3_MINOR_VERSION) != 0


class BinaryDistribution(Distribution):
    """Distribution which always forces a binary package with platform name"""
    def has_ext_modules(foo):
        return True

setup(name             = "tesedml",
      version          = "0.4.5.2",
      description      = "LibSEDML Python API",
      long_description = ("libSEDML is a library for reading, writing and "+
      "manipulating SEDML. It is written in ISO C and C++, supports SEDML "+
      "Levels 1, Version 1-3, and runs on Linux, Microsoft Windows, and Apple "+
      "MacOS X. For more information about SEDML, please see http://sed-ml.org/."),
      classifiers=[
          'Intended Audience :: Science/Research',
          'Operating System :: MacOS :: MacOS X',
          'Operating System :: Microsoft :: Windows',
          'Operating System :: POSIX',
          'Programming Language :: C++',
          ],
      license          = "LGPL",
      author           = "Frank T. Bergmann, J Kyle Medley (packaging)",
      url              = "http://sed-ml.org/",
      packages         = ["tesedml"],
      package_dir      = {'tesedml': 'lib64/python3.{}/site-packages/libsedml'.format(PY3_MINOR_VERSION)},
      package_data     = {'tesedml': ['*.so*', '*.pyd', '*.dll', '*.dylib*']},
      distclass=BinaryDistribution,
)

